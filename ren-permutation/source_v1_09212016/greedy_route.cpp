#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "greedy_route.h"
#include "per_func.h"

static int network_size;
static int data_parallelism;

//route the benes network without any constraints
int greedyRoute(int net_size
               ,int dp
			   ,int stride
			   ,vector<int> output)
{
	vector<int> input = vecGen(net_size, -1);
	int p = log2(double(dp/2));  //number of tree levels 
	std::cout<<"dp: "<<dp<<std::endl;
	std::cout<<"p: "<<p<<std::endl;
	network_size = net_size;
	data_parallelism = dp;
	
	//input: input values; output: output values; p: num of tree levels
	buildAndRoute(input, output, stride, p);
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
	for(int i=0; i < val_l_node.size(); i++){
		NODE * node_l_new = new NODE();
		NODE * node_r_new = new NODE();
		nodes_l.push_back(node_l_new);
		nodes_r.push_back(node_r_new);
	}

	//build the map between left node and right node
	for(int i=0; i < val_l_node.size(); i++)
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
	int num_files = 2*p+1;

	routeLooping(nodes_l,nodes_r,map_node_l,map_node_r,nw_size,stride, p, &num_files);
	
	for(int k=0; k < nodes_l.size(); k++){
		delete nodes_l[k];
		delete nodes_r[k];
	} 

}

//idx_level: index of levels in the tree
void routeLooping(vector<NODE *> nodes_l
                 ,vector<NODE *> nodes_r
				 ,map<int, NODE *> map_node_l
				 ,map<int, NODE *> map_node_r
				 ,int nw_size
				 ,int stride
				 ,int idx_level
				 ,int *num_files
				 )
{
    std::cout<<"idx_level: "<<idx_level<<std::endl;
	routeOneTime(nodes_l,nodes_r,map_node_l,map_node_r,nw_size,stride, *num_files);
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
    
	    routeLooping(nodes_l_up,nodes_r_up,map_up[0],map_up[1],nw_size/2,stride,idx_level-1, num_files);
	    routeLooping(nodes_l_down,nodes_r_down,map_down[0],map_down[1],nw_size/2,stride,idx_level-1, num_files);
	}else{
	    return;
	}
}


void routeOneTime(vector<NODE *> nodes_l
                 ,vector<NODE *> nodes_r
				 ,map<int, NODE *> map_node_l
				 ,map<int, NODE *> map_node_r
				 ,int nw_size
				 ,int stride
				 ,int p)
{
	rstRoute(nodes_l);
	rstRoute(nodes_r);
	vector<vector<bool> > stage1 = runRoute(nodes_l, nodes_r, map_node_l, map_node_r);
	vector<vector<NODE *> > stage2 = getSubNetworks(nodes_l, nodes_r);
	vector<map<int, NODE *> > s2_map = getNewMap(nodes_l, nodes_r);
	
	vector<NODE *> mem_l = stage2[0];
	vector<NODE *> mem_r = stage2[1];

	vector<NODE *> mem_up_l, mem_down_l;
	vector<NODE *> mem_up_r, mem_down_r;

	map<int, NODE *> s2_map_l = s2_map[0];
	map<int, NODE *> s2_map_r = s2_map[1];

	mem_up_l.insert(mem_up_l.begin(),mem_l.begin(),mem_l.begin()+mem_l.size()/2);
	mem_down_l.insert(mem_down_l.begin(),mem_l.begin()+mem_l.size()/2,mem_l.end());

	mem_up_r.insert(mem_up_r.begin(),mem_r.begin(),mem_r.begin()+mem_r.size()/2);
	mem_down_r.insert(mem_down_r.begin(),mem_r.begin()+mem_r.size()/2,mem_r.end());
	
	vector<int> addr_up, addr_down;		

	for(int i=0; i<mem_up_l.size(); i++)
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
	//itoa(stride,stride_,10);
	//itoa(p,p_,10);
	
	char file_n[40] = "ctrl_";
	strcat(file_n,net_size);
	strcat(file_n,"_");
	strcat(file_n,stride_);
	strcat(file_n,"_");
	strcat(file_n,p_);
	ofstream out(file_n);
	if(!out) return;

	//When dp = 4, for top network, net_size_ = nw_size, and data_paral = dp;
	//When dp = 4, for sub network, net_size_ = 2*nw_size, and data_paral = dp/2;

	int data_paral = data_parallelism/(network_size/nw_size);
	out<<"##For network with a size:"<<nw_size<<endl;
	out<<"##Stride:"<<stride<<endl;
	out<<"##Sub Network Data Parallelism:"<<data_paral<<endl;
	out<<"##The first stage"<<endl;
	for(int j=0; j<data_paral/2; j++){
		out<<"##The switch "<<j<<endl;
	  for(int i=j; i<stage1[0].size(); i=i+data_paral/2){
	     out<<" "<<stage1[0][i];
	  }
	  out<<endl;
	}
	out<<"##The last stage"<<endl;
	//for(int i=0; i<stage1[1].size(); i++){
	//   out<<" "<<stage1[1][i];
	//}
	for(int j=0; j<data_paral/2; j++){
	  out<<"##The switch "<<j<<endl;
	  for(int i=j; i<stage1[1].size(); i=i+data_paral/2){
	     out<<" "<<stage1[1][i];
	  }
	  out<<endl;
	}
	out<<"##The addresses here may not be used"<<endl;
	out<<"##The upper addresses"<<endl;
	for(int i=0; i<addr_up.size(); i++){
	   out<<" "<<addr_up[i];
	}
	out<<endl;
	out<<"##The lower addresses"<<endl;
	for(int i=0; i<addr_down.size(); i++){
	   out<<" "<<addr_down[i];
	}
	out<<endl;

	out.close();
	return;
}


vector<vector<bool> > runRoute(vector<NODE *> nodes_l
                             ,vector<NODE *> nodes_r
							 ,map<int, NODE *> map_node_l
							 ,map<int, NODE *> map_node_r)
{
	bool routed_all = 0;

	//initial a connect
	int i = 0, end = 0;
	NODE * left; 
	NODE * right;
	int location = 0;
	//int next_loc = 0;
	int left_nb = 0;
	int right_nb = 0;

	//cout<<"Enter the while loop"<<endl;

	//route the first switch stage and the last switch stage of the given network
	while(!end)
	{
	  int iii = 0;
	  left =  nodes_l[i];	
	  right = map_node_r[nodes_l[i]->readvalue()];
	  location = right->idx_location;

	  //cout<<"still running"<<iii<<endl;
	  if(i % 2 == 0)
	  {
	     left_nb = i+1;
	  }else{
		 left_nb = i-1;
	  }
	 //cout<<"still running 2 "<<i<<endl;
	 //cout<<"still running upper of node "<<i<<": "<<nodes_l[i]->upper<<endl;
	 //cout<<"start left node "<<i<<": "<<checkNodeRoute(left)<<endl;

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
	    	cout<<"Error: node "<<left_nb<<"on the left";
	    }		
	  }
	  else{
		  //cout<<"Inside?"<<endl;
			for(; iii<nodes_l.size(); iii++)
			{
			  if(!checkNodeRoute(nodes_l[iii]))
				  i = iii;
			}
			//if(iii == nodes_l.size())
			//	break;
			if(checkRouted(&nodes_l))
				break;
			//cout<<"value of iii?"<<iii<<endl;
			continue;
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
	     	cout<<"Error: node"<<(right_nb)<<"on the left";
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
	    	cout<<"Error: node "<<left_nb<<"on the left";
	    }
	  }
	  
	  //location = right->idx_location;
	  //right->lower = 1;

	  i = left_nb;
	  //i = next_loc;

	  //check_routed(&nodes_l);
	  routed_all = checkRouted(&nodes_r);
	  if(routed_all)
	  {
	  end = 1;
	  //cout<<"finished one stage"<<endl;
	  }
	  //nodes_l[]
	}
	//
	vector<bool> ctrl_bit_l, ctrl_bit_r;
	vector<vector<bool> > ctrl_bits;

	for(int kk=0; kk<nodes_l.size(); kk+=2)
	{
	  bool ctrl_l = getSwitchCtrl(nodes_l[kk],nodes_l[kk+1]);
	  bool ctrl_r = getSwitchCtrl(nodes_r[kk],nodes_r[kk+1]);
	  ctrl_bit_l.push_back(ctrl_l);
	  ctrl_bit_r.push_back(ctrl_r);
	}

	ctrl_bits.push_back(ctrl_bit_l);
	ctrl_bits.push_back(ctrl_bit_r);

	/*for(int k=0; k < nodes_l.size(); k++){
		delete nodes_l[k];
		delete nodes_r[k];
	} */
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

  if((node->lower ==1) &&(node_nb->upper ==1))
	  ctrl = 1;
  else if((node->upper ==1) && (node_nb->lower ==1))
	  ctrl = 0;
  else
	  cout<<"This pair of node is not routed yet!"<<endl;

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
		cout<<"The previous stage route is not finished"<<endl;
	}

	if(nodes_r[i]->upper){
		//nodes_r[i]->upper = 0;
		nodes_r_up.push_back(nodes_r[i]);
	}
	else if(nodes_r[i]->lower){
		//nodes_r[i]->lower = 0;
		nodes_r_down.push_back(nodes_r[i]);
	}else{
		cout<<"The previous stage route is not finished"<<endl;
	}
  }

  nodes_l_.insert(nodes_l_.begin(),nodes_l_up.begin(),nodes_l_up.end());
  nodes_l_.insert(nodes_l_.end(),nodes_l_down.begin(),nodes_l_down.end());
  nodes_r_.insert(nodes_r_.begin(),nodes_r_up.begin(),nodes_r_up.end()); 
  nodes_r_.insert(nodes_r_.end(),nodes_r_down.begin(),nodes_r_down.end());   


  for(int i =0; i<nodes_l_.size(); i++)
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
  for(int i=0; i<nodes.size(); i++)
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
	
	for(int i=0; i < nodes_l.size(); i++)
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
  for(int i=0; i<node.size(); i++)
  {
	  node[i]->idx_location = i;
  }
}

//
void relinkSubNetworks(vector<NODE *> nodes_l_up
               ,vector<NODE *> nodes_r_up
			   ,map<int, NODE *> map_node_l
			   ,map<int, NODE *> map_node_r)
{
  vector<vector<NODE *> > div_nodes;
  
  //
  for(int i=0; i<nodes_l_up.size(); i++)
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