#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <cstring>
#include <string>
#include <sstream>
#include "greedy_route.h"
#include "con_route.h"
#include "mem_route.h"
#include "per_func.h"

static int network_size;
static int data_parallelism;
static int global_idx;
static int num_subnetworks;
static int stride_g;
static int sel_algorithm;
static ofstream debug;
static bool print_sub_files;

//route the benes network without any constraints
int greedyRoute(int net_size
               ,int dp
			   ,int stride
			   ,vector<int> output
			   ,int per_idx   //a global index for a permutation
			   ,int sel_alg   //select algorithm
			   ,int print_subs
			   )
{
	vector<int> input = vecGen(net_size, -1);
	//int p = log2(double(dp/2));  //number of tree levels - 1
	int p = int( log(double(dp/2))/log(2.0) );
	print_sub_files = print_subs;
	std::ostringstream tmp_stream;
	tmp_stream << "debug_" << per_idx;
	std::string per_idx_str = tmp_stream.str();


	debug.open(per_idx_str.c_str());
	debug<<"input size: "<<net_size<<std::endl;
	debug<<"stride: "<<stride<<std::endl;
	debug<<"data parallelism: "<<dp<<std::endl;
	debug<<"num of levels: "<<p<<std::endl;
	network_size = net_size;
	data_parallelism = dp;
	global_idx = per_idx;
	sel_algorithm = sel_alg;
	stride_g = stride;
	
	//input: input values; output: output values; p: num of tree levels
	buildAndRoute(input, output, stride, p);
	
	debug.close();
	return 1;
}

//build the network and route
void buildAndRoute(vector<int> val_l_node
                  ,vector<int> val_r_node
				  ,int stride
				  ,int p)
{
	vector<NODE *> nodes_l, nodes_r;
	//map_node_l: key -- value of left node, value -- value of right node, ex. map[1] = the second right node 
	//map_node_r: key -- value of right node, value -- value of left node,  ex. map[2] = the second left node 
	map<int, NODE *> map_node_l, map_node_r;
	vector<vector<bool> > ctrl_bits;

	//cout<<"stage 2: "<<val_l_node.size()<<endl;
	for(unsigned int i=0; i < val_l_node.size(); i++){
		NODE * node_l_new = new NODE();
		NODE * node_r_new = new NODE();
		nodes_l.push_back(node_l_new);
		nodes_r.push_back(node_r_new);
	}

	//build the map between left node and right node
	for(unsigned int i=0; i < val_l_node.size(); i++)
	{
	  //cout<<"stage 3: "<<endl;
	  //cout<<"stage 4: "<<endl;
	  nodes_l[i]->side = 1;                           //1:left side, 0:right side
	  nodes_l[i]->upper = 0;
	  nodes_l[i]->lower = 0;
	  nodes_l[i]->setvalue(val_l_node[i]);           
	  nodes_l[i]->idx_location = i;                   //i is the index
	   
	  nodes_r[i]->side = 0;                           //1:left side, 0:right side
	  nodes_r[i]->upper = 0;
	  nodes_r[i]->lower = 0;
	  nodes_r[i]->idx_location = i; 
	  nodes_r[i]->setvalue(val_r_node[i]);
	  	  
	  map_node_l.insert(pair<int, NODE *>(val_l_node[i],nodes_r[i]));
	  map_node_r.insert(pair<int, NODE *>(val_r_node[i],nodes_r[i]));	  
    }

	int nw_size = nodes_l.size();
	int num_files = int(pow((double)2,(double)(p+1)))-1;
	debug<<"num_files: "<<num_files<<std::endl;
	num_subnetworks = num_files;

	vector<NODEMAP *> map_subnetworks;
	
	map_subnetworks = routeLooping(nodes_l,nodes_r,map_node_l,map_node_r,nw_size,stride, p, &num_files);
	
	printCtrl(map_subnetworks);
	
	for(unsigned int k=0; k < nodes_l.size(); k++){
		delete nodes_l[k];
		delete nodes_r[k];
	} 
	
	for(unsigned int k=0; k<map_subnetworks.size(); k++)
	{
		delete map_subnetworks[k];
	}
}

//idx_level: index of levels in the tree
vector<NODEMAP *> routeLooping(vector<NODE *> nodes_l
                 ,vector<NODE *> nodes_r
				 ,map<int, NODE *> map_node_l
				 ,map<int, NODE *> map_node_r
				 ,int nw_size
				 ,int stride
				 ,int idx_level
				 ,int *num_files
				 //, map_subnetworks
				 )
{
	vector<NODEMAP *> map_subnetworks;
	NODEMAP map_tmp;	
    debug<<"idx_level: "<<idx_level<<std::endl;
	
	map_tmp = routeOneTime(nodes_l,nodes_r,map_node_l,map_node_r,nw_size,stride, idx_level, *num_files);
	NODEMAP * map_inst = new NODEMAP(map_tmp);
	map_subnetworks.push_back(map_inst);
	int num = *num_files;
    *num_files = num - 1;

	if(idx_level>0){
	    vector<NODE *> nodes_l_up, nodes_l_down;
	    vector<NODE *> nodes_r_up, nodes_r_down;
    
	    vector<vector<NODE *> > reordered_nodes = getSubNetworks(nodes_l,nodes_r);
	    //easy to insert wrong parts
	    nodes_l_up.insert(nodes_l_up.begin(),reordered_nodes[0].begin(),reordered_nodes[0].begin()+ reordered_nodes[0].size()/2);
	    nodes_l_down.insert(nodes_l_down.begin(),reordered_nodes[0].begin()+reordered_nodes[0].size()/2,reordered_nodes[0].end());
    
	    nodes_r_up.insert(nodes_r_up.begin(),reordered_nodes[1].begin(),reordered_nodes[1].begin()+reordered_nodes[1].size()/2);
	    nodes_r_down.insert(nodes_r_down.begin(),reordered_nodes[1].begin()+reordered_nodes[1].size()/2,reordered_nodes[1].end());
	    
	    //rebuild the map build the left nodes and the right nodes of the upper and lower networks respectively
	    relinkSubNetworks(nodes_l_up,nodes_r_up,map_node_l,map_node_r);
	    relinkSubNetworks(nodes_l_down,nodes_r_down,map_node_l,map_node_r);
	    vector<map<int, NODE *> > map_up = getNewMap( nodes_l_up, nodes_r_up);
	    vector<map<int, NODE *> > map_down = getNewMap( nodes_l_down, nodes_r_down);
		
		vector<NODEMAP *> map_sns_upper, map_sns_lower;
    
	    map_sns_upper = routeLooping(nodes_l_up,nodes_r_up,map_up[0],map_up[1],nw_size/2,stride,idx_level-1, num_files);
	    map_sns_lower = routeLooping(nodes_l_down,nodes_r_down,map_down[0],map_down[1],nw_size/2,stride,idx_level-1, num_files);
		
		map_subnetworks.insert(map_subnetworks.end(),map_sns_upper.begin(),map_sns_upper.end());
		map_subnetworks.insert(map_subnetworks.end(),map_sns_lower.begin(),map_sns_lower.end());
	}else{
	    return map_subnetworks;
	}
	return map_subnetworks;
}


NODEMAP routeOneTime(vector<NODE *> nodes_l
                 ,vector<NODE *> nodes_r
				 ,map<int, NODE *> map_node_l
				 ,map<int, NODE *> map_node_r
				 ,int nw_size
				 ,int stride
				 ,int idx_level
				 ,int p   //idx of file
				 ) 
{
	rstRoute(nodes_l);
	rstRoute(nodes_r);
	//stage 1: ctrl bits of input stage and output stage
	//global_idx = 12;
	vector<vector<bool> > switch_ctrl_bits; 
	//vector<vector<bool> > switch_ctrl_bits = runRoute(nodes_l, nodes_r, map_node_l, map_node_r, global_idx);
	
	if(sel_algorithm == 0)
		switch_ctrl_bits = runRoute(nodes_l, nodes_r, map_node_l, map_node_r, 0);
	else if(sel_algorithm == 1){
	    if(idx_level != 0)
	        switch_ctrl_bits = runRouteCon(nodes_l, nodes_r, map_node_l, map_node_r, network_size, data_parallelism, debug);
	    else
	    	switch_ctrl_bits = runRouteMem(nodes_l, nodes_r, map_node_l, map_node_r, network_size, data_parallelism);
	}
	else if(sel_algorithm == 2)
		switch_ctrl_bits = runRouteCon(nodes_l, nodes_r, map_node_l, map_node_r, network_size, data_parallelism, debug);
	
	vector<vector<NODE *> > subnetworks = getSubNetworks(nodes_l, nodes_r);
	vector<map<int, NODE *> > s2_map = getNewMap(nodes_l, nodes_r);
	
	vector<NODE *> mem_l = subnetworks[0];
	vector<NODE *> mem_r = subnetworks[1];

	vector<NODE *> mem_up_l, mem_down_l;
	vector<NODE *> mem_up_r, mem_down_r;

	map<int, NODE *> s2_map_l = s2_map[0];
	map<int, NODE *> s2_map_r = s2_map[1];

	mem_up_l.insert(mem_up_l.begin(),mem_l.begin(),mem_l.begin()+mem_l.size()/2);
	mem_down_l.insert(mem_down_l.begin(),mem_l.begin()+mem_l.size()/2,mem_l.end());

	mem_up_r.insert(mem_up_r.begin(),mem_r.begin(),mem_r.begin()+mem_r.size()/2);
	mem_down_r.insert(mem_down_r.begin(),mem_r.begin()+mem_r.size()/2,mem_r.end());
	
	//addr_up, addr_down: upper memory addresses, lower memory addresses
	vector<int> addr_up, addr_down;		

	for(unsigned int i=0; i<mem_up_l.size(); i++)
	{
	  	int addr_mem_up_r = s2_map_l[mem_up_r[i]->readvalue()]->idx_location;
		addr_up.push_back(addr_mem_up_r);
		//cout<<"  "<<addr_mem_up_r;

		int addr_mem_down_r = s2_map_l[mem_down_r[i]->readvalue()]->idx_location - mem_up_l.size();
		addr_down.push_back(addr_mem_down_r);
		//cout<<"  "<<addr_mem_down_r<<endl;
	}

    //temp str for file name
	char net_size[10];
	char stride_[10];
	char p_[10];
	//itoa(nw_size,net_size,10);
	sprintf(net_size,"%d",nw_size);
	sprintf(stride_,"%d",stride);
	sprintf(p_,"%d",p);
	
	char file_n[40] = "ctrl_";
	strcat(file_n,p_);
	strcat(file_n,"_");
	strcat(file_n,stride_);
	strcat(file_n,"_");
	strcat(file_n,net_size);
	
	if(print_sub_files == 1){
	    ofstream out(file_n);
	    //When dp = 4, for top network, net_size_ = nw_size, and data_paral = dp;
	    //When dp = 4, for sub network, net_size_ = 2*nw_size, and data_paral = dp/2;
        
	    int data_paral = data_parallelism/(network_size/nw_size);
	    out<<"##For network with a size:"<<nw_size<<endl;
	    out<<"##Stride:"<<stride<<endl;
	    out<<"##Sub Network Data Parallelism:"<<data_paral<<endl;
	    out<<"##The first stage"<<endl;
	    for(int j=0; j<data_paral/2; j++){
	    	out<<"##The switch "<<j<<endl;
	      for(unsigned int  i=j; i<switch_ctrl_bits[0].size(); i=i+data_paral/2){
	         out<<" "<<switch_ctrl_bits[0][i];
	      }
	      out<<endl;
	    }
	    out<<"##The last stage"<<endl;
	    //for(int i=0; i<switch_ctrl_bits[1].size(); i++){
	    //   out<<" "<<switch_ctrl_bits[1][i];
	    //}
	    for(int j=0; j<data_paral/2; j++){
	      out<<"##The switch "<<j<<endl;
	      for(unsigned int i=j; i<switch_ctrl_bits[1].size(); i=i+data_paral/2){
	         out<<" "<<switch_ctrl_bits[1][i];
	      }
	      out<<endl;
	    }
	    out<<"##The addresses here may not be used"<<endl;
	    out<<"##The upper addresses"<<endl;
	    for(unsigned int i=0; i<addr_up.size(); i++){
	       out<<" "<<addr_up[i];
	    }
	    out<<endl;
	    out<<"##The lower addresses"<<endl;
	    for(unsigned int i=0; i<addr_down.size(); i++){
	       out<<" "<<addr_down[i];
	    }
	    out<<endl;

	    out.close();
	}
	
	//return the control information for input/output stages and memory stage
	NODEMAP node_map_inst; // = NODEMAP();
	node_map_inst.switch_ctrl = switch_ctrl_bits;
	node_map_inst.addr_up = addr_up;
	node_map_inst.addr_down = addr_down;
	//node_map_inst.data_parallelism = data_paral;
	node_map_inst.decomp_stage = idx_level;
	//dp = 4, p = 1,2,3
	node_map_inst.idx_file = p; 
	node_map_inst.map_size = nw_size;
	
	return node_map_inst;
}


vector<vector<bool> > runRoute(vector<NODE *> nodes_l
                             ,vector<NODE *> nodes_r
							 ,map<int, NODE *> map_node_l
							 ,map<int, NODE *> map_node_r
							 ,int start_i)
{
	bool routed_all = 0;
	int i = start_i, end = 0;
	NODE * left; 
	NODE * right;
	int location = 0;
	int left_nb = 0;
	int right_nb = 0;

	//route the first switch stage and the last switch stage of the given network
	while(!end)
	{
	  unsigned int iii = 0;
	  //left: ith node on the left side, right: having the same value of left
	  left =  nodes_l[i];	
	  right = map_node_r[nodes_l[i]->readvalue()];
	  location = right->idx_location;
	  
	  if(i % 2 == 0)
	     left_nb = i+1;
	  else
		 left_nb = i-1;

	  if(!checkNodeRoute(left)){
	    if((nodes_l[left_nb]->upper == 1) && (nodes_l[left_nb]->lower == 0))
	    	left->lower = 1;
	    else if((nodes_l[left_nb]->lower == 1) && (nodes_l[left_nb]->upper == 0))
	    	left->upper = 1;
	    else if((nodes_l[left_nb]->upper == 0) && (nodes_l[left_nb]->lower == 0)){
	    	//left->upper = 1;
		  if(right->lower ==1){
		    left->lower = 1;  //nodes_l[left_nb]->upper=1;
		  }
          else if(right->upper ==1){
	        left->upper = 1;  //nodes_l[left_nb]->lower=0;
		  }else
			left->upper = 1;  
		} 
		else{ 
			//left->upper = 1;
	    	debug<<"Error: node "<<left_nb<<"on the left";
	    }		
	  }
	  else{
		  //cout<<"Inside?"<<endl;
			for(; iii<nodes_l.size(); iii++)
			{
			  if(!checkNodeRoute(nodes_l[iii]))
				  i = iii;
			}
			if(checkRouted(&nodes_l) && checkRouted(&nodes_r))
				break;
			if(!checkRouted(&nodes_l))
			    continue;
			else{
			    for(unsigned int j=0 ; j<nodes_r.size(); j++)
			   {
			      if(!checkNodeRoute(nodes_r[j])){
				      location = j;
					  right = nodes_r[j];
					  left = nodes_l[right->readvalue()];
					  break;
				  }
			    }
			}
	  }
	  	  
	   if(location % 2 == 0)
	  {
	     right_nb = location+1;
	  }else{
		 right_nb = location-1;
	  }

	  if(!checkNodeRoute(right)){
	      if((nodes_r[right_nb]->upper == 1) && (nodes_r[right_nb]->lower == 0))
	      	right->lower = 1;
	      else if((nodes_r[right_nb]->upper == 0) && (nodes_r[right_nb]->lower == 1))
	      	right->upper = 1;
	      else if((nodes_r[right_nb]->upper == 0) && (nodes_r[right_nb]->lower == 0)){
	      	//right->upper = 1;
		    if(left->lower ==1){
		      right->lower = 1;  nodes_r[right_nb]->upper = 1; 
		    }
            else if(left->upper ==1){
	          right->upper = 1;  nodes_r[right_nb]->lower = 1;
		    }
		    else{
		      right->upper = 1;  nodes_r[right_nb]->lower = 1;
		    }
		  }
	      else{ 
	       	debug<<"Error: node"<<(right_nb)<<"on the left";
	      }
	  }

	  right = nodes_r[right_nb];
	  left = nodes_l[right->readvalue()];
	  i = right->readvalue();
	  
	  if((i) % 2 == 0)
	  {
	     left_nb = i+1;
	  }else{
		 left_nb = i-1;
	  }
	  
	  //
	  if(!checkNodeRoute(left)){
	    if((nodes_l[left_nb]->upper == 1) && (nodes_l[left_nb]->lower == 0))
	    	left->lower = 1;
	    else if((nodes_l[left_nb]->upper == 0) && (nodes_l[left_nb]->lower == 1))
	    	left->upper = 1;
	    else if((nodes_l[left_nb]->upper == 0) && (nodes_l[left_nb]->lower == 0)){
	    	//left->upper = 1;
		  if(right->lower ==1){
		    left->lower = 1;  //nodes_l[left_nb]->upper=1;
		  }
          else if(right->upper ==1){
	        left->upper = 1;  //nodes_l[left_nb]->lower=0;
		  }
		  else{ 
		    left->upper = 1;  //nodes_l[left_nb]->lower=0;
		  }
	    }
	    else{ 
	    	debug<<"Error: node "<<left_nb<<"on the left";
	    }
	  }
	  
	  i = left_nb;
	  routed_all = checkRouted(&nodes_r);
	  if(routed_all)
	  {
	  end = 1;
	  }
	}
	//
	vector<bool> ctrl_bit_l, ctrl_bit_r;
	vector<vector<bool> > ctrl_bits;

	for(unsigned int kk=0; kk<nodes_l.size(); kk+=2)
	{
	  bool ctrl_l = getSwitchCtrl(nodes_l[kk],nodes_l[kk+1]);
	  bool ctrl_r = getSwitchCtrl(nodes_r[kk],nodes_r[kk+1]);
	  ctrl_bit_l.push_back(ctrl_l);
	  ctrl_bit_r.push_back(ctrl_r);
	}

	ctrl_bits.push_back(ctrl_bit_l);
	ctrl_bits.push_back(ctrl_bit_r);
	return ctrl_bits;
}


bool checkRouted(vector<NODE *> *nodes)
{
  bool routed = 1;
  vector<NODE *> test = *nodes;
  vector<NODE *>::iterator i = test.begin();
  
  for(; i != test.end(); i++)
  {
    if(((*i)->upper==0)&&((*i)->lower==0))  
	{
		routed = 0;
	}
	//cout<<"test["<<i<<"] "<<"upper "<<test[i]->upper<<endl;
	//cout<<"test["<<i<<"] "<<"lower "<<test[i]->lower<<endl;
  }

  return routed;
}

bool getSwitchCtrl(NODE * node, NODE * node_nb)
{
  bool ctrl = 0; // 1:cross, 0: no cross

  //node->lower=1, go to upper side;
  if((node->lower ==1) &&(node_nb->upper ==1))
	  ctrl = 1;
  else if((node->upper ==1) && (node_nb->lower ==1))
	  ctrl = 0;
  else
	  debug<<"This pair of node is not routed yet!"<<endl;

  return ctrl;
}

//
bool checkNodeRoute(NODE * node)
{
	bool routed = 0;
	if(node->upper == 1)
		routed = 1;
	else if(node->lower == 1)
		routed = 1;

	return routed;
}


//after the routing of the first and last stages
//get the inputs and outputs of the next two networks with size of n/2
vector<vector<NODE *> > getSubNetworks(vector<NODE *> nodes_l
                                      ,vector<NODE *> nodes_r)
{
  int network_size = nodes_l.size();
  vector<NODE *> nodes_l_up, nodes_l_down;
  vector<NODE *> nodes_r_up, nodes_r_down;
  vector<NODE *> nodes_l_(nodes_l_up.size() + nodes_r_up.size());
  vector<NODE *> nodes_r_(nodes_l_down.size() + nodes_r_down.size());
  vector<vector<NODE *> > nodes_new;

  for(int i=0; i<network_size; i++ )
  {
    if(nodes_l[i]->upper){
		//nodes_l[i]->upper = 0;
		nodes_l_up.push_back(nodes_l[i]);
	}
	else if(nodes_l[i]->lower){
		//nodes_l[i]->lower = 0;
		nodes_l_down.push_back(nodes_l[i]);
	}else{
		debug<<"The previous stage route is not finished"<<endl;
	}

	if(nodes_r[i]->upper){
		//nodes_r[i]->upper = 0;
		nodes_r_up.push_back(nodes_r[i]);
	}
	else if(nodes_r[i]->lower){
		//nodes_r[i]->lower = 0;
		nodes_r_down.push_back(nodes_r[i]);
	}else{
		debug<<"The previous stage route is not finished"<<endl;
	}
  }

  nodes_l_.insert(nodes_l_.begin(),nodes_l_up.begin(),nodes_l_up.end());
  nodes_l_.insert(nodes_l_.end(),nodes_l_down.begin(),nodes_l_down.end());
  nodes_r_.insert(nodes_r_.begin(),nodes_r_up.begin(),nodes_r_up.end()); 
  nodes_r_.insert(nodes_r_.end(),nodes_r_down.begin(),nodes_r_down.end());   

  for(unsigned int i =0; i<nodes_l_.size(); i++)
  {
    nodes_l_[i]->idx_location = i;
	nodes_r_[i]->idx_location = i;  
  }
 
  nodes_new.push_back(nodes_l_);
  nodes_new.push_back(nodes_r_);
  return nodes_new;
}

//
void rstRoute(vector<NODE *> nodes)
{
  for(unsigned int i=0; i<nodes.size(); i++)
  {
    nodes[i]->upper = 0;
	nodes[i]->lower = 0;
  }
}

//
vector<map<int, NODE *> > getNewMap(vector<NODE *> nodes_l
                                 ,vector<NODE *> nodes_r)
{
	map<int, NODE *> map_l, map_r;
	vector<map<int, NODE *> > new_m;
	
	for(unsigned int i=0; i < nodes_l.size(); i++)
	{	  	  
	  map_l.insert(pair<int, NODE *>(nodes_l[i]->readvalue(),nodes_l[i]));	  
	  map_r.insert(pair<int, NODE *>(nodes_r[i]->readvalue(),nodes_r[i]));
    }

	new_m.push_back(map_l);	
	new_m.push_back(map_r);	

	return new_m;
}

void rstNodeIdx(vector<NODE *> node)
{
  for(unsigned int i=0; i<node.size(); i++)
  {
	  node[i]->idx_location = i;
  }
}

//Route the input and output based on switch configurations, and then relink
void relinkSubNetworks(vector<NODE *> nodes_l_up
               ,vector<NODE *> nodes_r_up
			   ,map<int, NODE *> map_node_l
			   ,map<int, NODE *> map_node_r)
{
  vector<vector<NODE *> > div_nodes;
  
  //
  for(unsigned int i=0; i<nodes_l_up.size(); i++)
  {
	  NODE * node_r = map_node_r[nodes_l_up[i]->readvalue()];
	  nodes_l_up[i]->setvalue(i);
	  node_r->setvalue(i);  
  }
  rstNodeIdx(nodes_l_up);
  rstNodeIdx(nodes_r_up);

  //div_nodes.push_back(nodes_l_up);
  //div_nodes.push_back(nodes_r_up);
}


//Use the routed benes network to print out the control bits
void printCtrl(vector<NODEMAP *> node_maps)
{
	char file_name[50] ="ctrl_per_";
	char g_idx[20];
	std::sprintf(g_idx,"%d",global_idx);
	std::strcat(file_name, g_idx);

	//int num_int_stages = log2(double(data_parallelism));
	int num_int_stages = int( log(double(data_parallelism))/log(2.0));
	int num_switch_per_stage = data_parallelism/2;
	int num_bits_per_switch = network_size/data_parallelism;
	//int num_addresses_per_mem = num_bits_per_switch;
	
	SPNCTRL spn_ctrl;
	spn_ctrl = getCtrlBits(node_maps);
	
	ofstream ctrlFiles(file_name);	
	if(!ctrlFiles) return;
	
	ctrlFiles<<"#Input size: "<<network_size<<endl;
	ctrlFiles<<"#Data parallelism: "<<data_parallelism<<endl;	
    ctrlFiles<<"#Stride: "<<stride_g<<endl;	 	
 	ctrlFiles<<"#Switch ctrl in input stages:"<<endl;
	
	//left:4,3,2,1,0; right:0,1,2,3,4
	//when i=0, call stage (num_int_stages - 1);	
	for(int i=0; i<num_int_stages; i++)
	{
	    
		//int stage_idx = num_int_stages - 1 - i;
		int stage_idx = i;
		ctrlFiles<<"#Stage "<<stage_idx<<":"<<endl;
		for(int j=0; j<num_switch_per_stage; j++)
		{
			ctrlFiles<<"#Switch "<<j<<": ";
			for(int k=0; k<num_bits_per_switch; k++)
				ctrlFiles<<spn_ctrl.lsb[i][j][k]<<" ";
			ctrlFiles<<endl;
		}
		//ctrlFiles<<endl;
	}	
	
	//ctrlFile<<
	ctrlFiles<<"#Switch ctrl in output stages:"<<endl;
	//when i=0, call stage (num_int_stages - 1);	
	for(int i=0; i<num_int_stages; i++)
	{
		//int stage_idx = num_int_stages - 1 - i;
		int stage_idx = i;
		ctrlFiles<<"#Stage "<<stage_idx<<":"<<endl;
		for(int j=0; j<num_switch_per_stage; j++)
		{
			ctrlFiles<<"#Switch "<<j<<": ";
			for(int k=0; k<num_bits_per_switch; k++)
				ctrlFiles<<spn_ctrl.lsb[i][j][k]<<" ";
			ctrlFiles<<endl;
		}
		//ctrlFiles<<endl;
	}
	
	//Memory addresses
	ctrlFiles<<"#Memory addresses: "<<endl;
	for(int i=0; i<data_parallelism; i++)
	{
		ctrlFiles<<"#Memory block "<<i<<": "<<endl;
		for(unsigned int  j=0; j<spn_ctrl.mem_addr[i].size(); j++)
		{
			ctrlFiles<<hex<<spn_ctrl.mem_addr[i][j]<<" ";
		}
		ctrlFiles<<endl;
	}
			
	return;
}


//Use the routed benes network to print out the control bits
SPNCTRL getCtrlBits(vector<NODEMAP *> node_maps)
{
	int num_int_stages = int( log(double(data_parallelism))/log(2.0));
	//int num_int_stages = log2(double(data_parallelism));
	int num_subnetworks = node_maps.size();
		
	vector<vector<NODEMAP *> > node_maps_tmp;
	node_maps_tmp.resize(num_int_stages);
	
	//decompose is based on depth first, here maps are rearranged stage by stage
	for(int i=0; i<num_subnetworks; i++)
	{
	    //left:4,3,2,1,0; right:0,1,2,3,4
		//cout<<"decomp_stage:"<<(node_maps[i]->decomp_stage)<<endl;
		vector<NODEMAP *> * maps_tmp;
		maps_tmp = &node_maps_tmp[(node_maps[i]->decomp_stage)];
		//node_maps_tmp[(node_maps[i]->decomp_stage)].push_back(node_maps[i]);
		(*maps_tmp).push_back(node_maps[i]);
	}
	
	//Store all left/right stage switch bits
	vector<vector<vector<bool> > > lsb;
	vector<vector<vector<bool> > > rsb;
	vector<vector<int> > mem_addr;
		
	for(int i=num_int_stages-1; i>-1; i--)
	{
		//ctrlFiles<<"###Switch bits in left stage "<<i<<": "<<endl;
		//lsb: ctrl bits in a left stage ; rsb: ctrl bits in a rigth stage
		vector<vector<bool> > lsb_stage;
		vector<vector<bool> > rsb_stage;
		vector<int> mem_addr_per;
		
		vector<NODEMAP *> map_tmp = node_maps_tmp[i];
		int num_submaps = map_tmp.size();
		//a subnetwork includes ctrl bits of dp/(2*num_submaps) switches
		int num_switch_per_sn = (data_parallelism)/(2*num_submaps);
		int num_bits_per_switch = network_size/data_parallelism;
		
		for(int l=0; l<num_submaps; l++)
		{
			//stores the (left/rigth) ctrl bits of switches of a subnetwork
			vector<vector<bool> > lcb_per_sn; // = map_tmp[l].switch_ctrl[0];
			vector<vector<bool> > rcb_per_sn; 
			//stores the (left) ctrl bits of a subnetwork
			vector<bool> left_bits_sn = map_tmp[l]->switch_ctrl[0];
			vector<bool> right_bits_sn = map_tmp[l]->switch_ctrl[1];
			
			lcb_per_sn.resize(num_switch_per_sn);
			rcb_per_sn.resize(num_switch_per_sn);
			
			for(int  m=0; m<num_switch_per_sn; m++)
				for(int n=0; n<num_bits_per_switch; n++)
				{
					int bit_idx = m + n*num_switch_per_sn;
					lcb_per_sn[m].push_back(left_bits_sn[bit_idx]);
					rcb_per_sn[m].push_back(right_bits_sn[bit_idx]);
				}
			
			lsb_stage.insert(lsb_stage.end(),lcb_per_sn.begin(),lcb_per_sn.end());
			rsb_stage.insert(rsb_stage.end(),rcb_per_sn.begin(),rcb_per_sn.end());
			
			//get the memory addresses		
		    if(i == 0)
		    {
		    	mem_addr.push_back(getCompleteAddrSeq(map_tmp[l]->addr_up));				
				mem_addr.push_back(getCompleteAddrSeq(map_tmp[l]->addr_down));
		    	//when stride_g == -1, print increasing addresses
				//if(stride_g == 0){
		    	//    mem_addr.push_back(getCompleteAddrSeq(map_tmp[l]->addr_up));				
				//    mem_addr.push_back(getCompleteAddrSeq(map_tmp[l]->addr_down));
				//}else{
				//	vector<int> addr_tmp;
				//	for(int i=0; i<map_tmp[0]->addr_up.size()/2; i++)
				//		addr_tmp.push_back(i);
				//    mem_addr.push_back(addr_tmp);				
				//    mem_addr.push_back(addr_tmp);
				//}
		    }
		}

        lsb.push_back(lsb_stage);		
		rsb.push_back(rsb_stage);

	}	
    
	SPNCTRL spn_ctrl; // = new SPNCTRL();
    spn_ctrl.lsb = lsb;
    spn_ctrl.rsb = rsb;
    spn_ctrl.mem_addr = mem_addr;
	
	return spn_ctrl;
}


vector<int> getCompleteAddrSeq(vector<int> mem_addr_vec)
{
	int num_addr_seq = 1;
	
	vector<int> result;
	vector<int> tmp_vec_a = mem_addr_vec;
	vector<int> tmp_vec_b = mem_addr_vec;
	
	//int i = 0;
	while(num_addr_seq < 7)
	{
		for(unsigned int  j=0; j<mem_addr_vec.size(); j++)
		{
			result.push_back(tmp_vec_a[j]);
			tmp_vec_b[j]=(tmp_vec_a[mem_addr_vec[j]]);
		}
		if(areVecsEqual(tmp_vec_b, mem_addr_vec))
			break;
		else
			num_addr_seq++;
		tmp_vec_a = tmp_vec_b;
	}

	if(num_addr_seq <= 16/int(log(double(network_size/data_parallelism))/log(2.0)))
		return result;
	else
		return mem_addr_vec;
}