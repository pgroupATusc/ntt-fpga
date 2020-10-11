#include <iostream>
#include <vector>
#include <map>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <time.h>
#include "per_func.h"
#include "map.h"
#include "node.h"
#include "mem_route.h"
#include "con_route.h"
#include "greedy_route.h"

static int num_submaps_stage;
static int num_switch_per_sn;
static int num_bits_per_switch;

//Optimize the memory address sequence
vector<vector<bool> > runRouteMem(vector<NODE *> nodes_l
                                 ,vector<NODE *> nodes_r
							     ,map<int, NODE *> map_node_l
							     ,map<int, NODE *> map_node_r
								 ,int network_size
								 ,int data_parallelism)
{
	vector<vector<bool> > ctrl_bits;
	vector<vector<int> > mem_addr_vec;
	//record the i value resulting in maximum num of RAS (regular address sequence)
	int max_ns_idx = 0;
	int min_ras_idx = 0;
	//idx of i resulting both minum null switch and max ras
	int optimal_idx = 0;

	//record maximum number of null switches
	int min_num_ras = 0; 
	int max_num_ns = 0;
	
	//number of submaps in current stage
	num_submaps_stage = network_size/nodes_l.size();
	num_switch_per_sn = (data_parallelism)/(2*num_submaps_stage);
	num_bits_per_switch = network_size/data_parallelism;
	
	vector<int> idx_unique_routing = getUniqIdx(nodes_l, nodes_r ,map_node_l ,map_node_r);
	
	cout<<"Num of idx resulting in unique routing is: "<<idx_unique_routing.size()<<endl;

	for(unsigned int i=0; i<idx_unique_routing.size(); i++)
	{
		int idx = idx_unique_routing[i];
		//Temporary result used for routing only
		vector<NODE *> nodes_l_tmp;
        vector<NODE *> nodes_r_tmp;
		map<int, NODE *> map_node_l_tmp;
	    map<int, NODE *> map_node_r_tmp;
		map<int, NODE *>::iterator it_l = map_node_l.begin();
		map<int, NODE *>::iterator it_r = map_node_r.begin();	
		
		for(unsigned int j=0; j<nodes_l.size(); j++)
		{			
			NODE * node_l = new NODE(*nodes_l[j]);
			nodes_l_tmp.push_back(node_l);
			NODE * node_r = new NODE(*nodes_r[j]);
			nodes_r_tmp.push_back(node_r);
			
            NODE * node_l_map = new NODE(*(it_l->second));
            map_node_l_tmp.insert(pair<int, NODE *>(it_l->first, node_l_map));			
			NODE * node_r_map = new NODE(*(it_r->second));
			map_node_r_tmp.insert(pair<int, NODE *>(it_r->first, node_r_map));		

			advance(it_l,1);		
			advance(it_r,1);
		}
		
		//Route to get the ctrl bits of input&output stage switches
		ctrl_bits = runRoute(nodes_l_tmp, nodes_r_tmp, map_node_l_tmp, map_node_r_tmp, idx);
		
		//Get the memory addresses based on the routing results
		mem_addr_vec = getMemAddr(nodes_l_tmp, nodes_r_tmp);
		
		//stores the (left/rigth) ctrl bits of switches of a subnetwork
		int num_null_switch = getNullSwithNum(ctrl_bits);
		
		//num_mem_seq = upper ms + lower ms;
		int num_mem_seq = getNumAddrSeq(mem_addr_vec[0]) + getNumAddrSeq(mem_addr_vec[1]);
		
		if(num_null_switch >= max_num_ns){
			max_num_ns = num_null_switch;
			max_ns_idx = idx; 
		}		
		if(num_mem_seq <= min_num_ras){
			min_num_ras = num_mem_seq;
			min_ras_idx = idx; 			
		}
		
		if (max_ns_idx == min_ras_idx)
			optimal_idx = idx;
		        
		cout<<"The num of null switches is: "<<num_null_switch<<endl;
		cout<<"The num of memory address sequences is: "<<num_mem_seq<<endl;
		
		it_l = map_node_l_tmp.begin();
		it_r = map_node_r_tmp.begin();			
        for(unsigned  int k=0; k < nodes_l_tmp.size(); k++){
		    delete nodes_l_tmp[k];
		    delete nodes_r_tmp[k];
			delete it_l->second;
			delete it_r->second;
			advance(it_l,1);		
			advance(it_r,1);
	    } 		
	}

	cout<<"The value of max_ns_idx is: "<<max_ns_idx<<endl;
	cout<<"The value of min_ras_idx is: "<<min_ras_idx<<endl;
	cout<<"The value of optimal_idx is: "<<optimal_idx<<endl;
	
	ctrl_bits = runRoute(nodes_l, nodes_r, map_node_l, map_node_r, optimal_idx);
		
	return ctrl_bits;
}


vector<vector<int> > getMemAddr(vector<NODE *> nodes_l
                               ,vector<NODE *> nodes_r)
{
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

		int addr_mem_down_r = s2_map_l[mem_down_r[i]->readvalue()]->idx_location - mem_up_l.size();
		addr_down.push_back(addr_mem_down_r);
	}
	
	vector<vector<int> > addr_vec;
	addr_vec.push_back(addr_up);
	addr_vec.push_back(addr_down);
	return addr_vec;
}


int getNullSwithNum(vector<vector<bool> > ctrl_bits)
{
	vector<vector<bool> > lcb_per_sn; // = map_tmp[l].switch_ctrl[0];
	vector<vector<bool> > rcb_per_sn; 
	//stores the (left) ctrl bits of a subnetwork
	vector<bool> left_bits_sn = ctrl_bits[0];
	vector<bool> right_bits_sn = ctrl_bits[1];
    int num_null_switch = 0;		
	
	lcb_per_sn.resize(num_switch_per_sn);
	rcb_per_sn.resize(num_switch_per_sn);
	
	for(int m=0; m<num_switch_per_sn; m++)
		for(int n=0; n<num_bits_per_switch; n++)
		{
			int bit_idx = m + n*num_switch_per_sn;
			lcb_per_sn[m].push_back(left_bits_sn[bit_idx]);
			rcb_per_sn[m].push_back(right_bits_sn[bit_idx]);
		}
	
	for(int m=0; m<num_switch_per_sn; m++)
	{
		if(isNullSwitch(lcb_per_sn[m]))
			num_null_switch++;
		if(isNullSwitch(rcb_per_sn[m]))
			num_null_switch++;
	}
	
	return num_null_switch;
}

int getNumAddrSeq(vector<int> mem_addr_vec)
{
	int num_addr_seq = 1;
	
	vector<int> tmp_vec_a = mem_addr_vec;
	vector<int> tmp_vec_b = mem_addr_vec ;
	
	//int i = 0;
	while(num_addr_seq < 8)
	{
		for(unsigned int j=0; j<mem_addr_vec.size(); j++)
		{
			tmp_vec_b[j]=(tmp_vec_a[mem_addr_vec[j]]);
		}
		if(areVecsEqual(tmp_vec_b, mem_addr_vec))
			break;
		else
			num_addr_seq++;
		tmp_vec_a = tmp_vec_b;
	}

	return num_addr_seq;
}


bool areVecsEqual(vector<int> in_a, vector<int> in_b)
{
	bool equal = 1;
	for(unsigned int i=0; i<in_a.size(); i++)
	{
		if(in_a[i] != in_b[i])
			equal = 0;
	}
	return equal;
}

//Only a few indices may result different routing
vector<int> getUniqIdx(vector<NODE *> nodes_l
                      ,vector<NODE *> nodes_r
					  ,map<int, NODE *> map_node_l
					  ,map<int, NODE *> map_node_r)
{
	vector<int> idx(nodes_l.size());
	for(unsigned int i=0; i<nodes_l.size(); i++)
		idx[i] = 1;
	
	//default routing: upper = 1
	for(unsigned int i=0; i<nodes_l.size(); i++){
		//node_l[0] -> node_r -> idx_r
		if(idx[i] == 0)
			continue;
		int i_near_idx = (i%2) ? i-1 :i+1;
		int left_new_idx = i;
		while(left_new_idx != i_near_idx){			
		    int right_idx = map_node_r[left_new_idx]->idx_location;
		    int right_near_idx = (right_idx%2) ? right_idx-1 :right_idx+1;
		    //right_near_node -> left_node
		    left_new_idx = nodes_r[right_near_idx]->readvalue();
		    if(left_new_idx != i_near_idx){
		    	idx[left_new_idx] = 0;
				//update left idx using its near idx
				left_new_idx = (left_new_idx%2) ? left_new_idx-1 :left_new_idx+1;
			}
		}
	}

    //get idx of left nodes resulting in uniqe routing results
    vector<int> idx_unique;
    for(unsigned int i=0; i<nodes_l.size(); i++)
		if(idx[i] == 1)	
			idx_unique.push_back(i);
	
	return idx_unique;
}