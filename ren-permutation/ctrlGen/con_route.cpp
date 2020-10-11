#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "con_route.h"
#include "greedy_route.h"
#include "per_func.h"
#include "mem_route.h"

vector<vector<bool> > runRouteCon(vector<NODE *> nodes_l
                                 ,vector<NODE *> nodes_r
							     ,map<int, NODE *> map_node_l
							     ,map<int, NODE *> map_node_r
								 ,int network_size
								 ,int data_parallelism
								 ,ofstream & debug)
{
	//bool routed_all = 0;
	//vector<bool> ctrl_bit_l, ctrl_bit_r;
	vector<vector<bool> > ctrl_bits;
	//record the i value resulting in minimum num of switches
	int min_idx = 0;
	//record maximum number of null switches
	int max_num_ns = 0;
	//number of submaps in current stage
	int num_submaps_stage = network_size/nodes_l.size();
	int num_switch_per_sn = (data_parallelism)/(2*num_submaps_stage);
	int num_bits_per_switch = network_size/data_parallelism;

	//vector<int> idx_unique_routing = getUniqIdx(nodes_l, nodes_r , map_node_l , map_node_r);
	
	//cout<<"Num of idx resulting in unique routing is: "<<idx_unique_routing.size()<<endl;
		
	//initial a connect
	for(int i=0; i<nodes_l.size(); i++)
	//for(int i=0; i<nodes_l.size(); i++)
	{
		int idx = i;
		//int idx = i;
		//Temporary result used for routing only
		vector<NODE *> nodes_l_tmp;
        vector<NODE *> nodes_r_tmp;
		map<int, NODE *> map_node_l_tmp;
	    map<int, NODE *> map_node_r_tmp;
		
		//map_node_l_tmp.insert(map_node_l.begin(),map_node_l.end());
		//map_node_r_tmp.insert(map_node_r.begin(),map_node_r.end());
		map<int, NODE *>::iterator it_l = map_node_l.begin();
		map<int, NODE *>::iterator it_r = map_node_r.begin();	
		
		for(int j=0; j<nodes_l.size(); j++)
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
		
		ctrl_bits = runRoute(nodes_l_tmp, nodes_r_tmp, map_node_l_tmp, map_node_r_tmp, idx);
		
		//stores the (left/rigth) ctrl bits of switches of a subnetwork
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
		
		if(num_null_switch >= max_num_ns)
		{
			max_num_ns = num_null_switch;
			min_idx = idx;
		}		
        
		debug<<"The num of null switches is: "<<num_null_switch<<endl;
		
		it_l = map_node_l_tmp.begin();
		it_r = map_node_r_tmp.begin();	
		
        for(int k=0; k < nodes_l_tmp.size(); k++){
		    delete nodes_l_tmp[k];
		    delete nodes_r_tmp[k];
			delete it_l->second;
			delete it_r->second;
			advance(it_l,1);		
			advance(it_r,1);
	    } 		
	}

	debug<<"The value of min_idx is: "<<min_idx<<endl;
	ctrl_bits = runRoute(nodes_l, nodes_r, map_node_l, map_node_r, min_idx);
		
	return ctrl_bits;
}

bool isNullSwitch(vector<bool> ctrl_bits)
{
	bool abit = ctrl_bits[0];
	bool is_null = 1;
	
	for(int i=0; i<ctrl_bits.size(); i++)
		if(ctrl_bits[i] != abit)
			is_null = 0;
	
	return is_null;
}