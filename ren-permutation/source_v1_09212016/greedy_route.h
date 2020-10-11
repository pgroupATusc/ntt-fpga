#ifndef GREEDY_ROUTE_H
#define GREEDY_ROUTE_H

#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include "node.h"
using namespace std;

//
int greedyRoute(int net_size, int dp, int stride, vector<int> output);

//
void buildAndRoute(vector<int> val_l_node
                  ,vector<int> val_r_node
				  ,int stride, int p);

//  
void routeLooping(vector<NODE *> nodes_l
                    ,vector<NODE *> nodes_r
					,map<int, NODE *> map_node_l
					,map<int, NODE *> map_node_r
					,int nw_size
					,int stride
					,int idx_level
					,int *num_files);					
					
//generate
void routeOneTime(vector<NODE *> nodes_l
                    , vector<NODE *> nodes_r
					, map<int, NODE *> map_node_l
					, map<int, NODE *> map_node_r
					, int nw_size
					, int stride, int p);

//connect
vector<vector<bool> > runRoute(vector<NODE *> nodes_l
                              ,vector<NODE *> nodes_r
							  ,map<int, NODE *> map_node_l
							  ,map<int, NODE *> map_node_r);

//
bool checkRouted(vector<NODE *> *nodes);

//
bool getSwitchCtrl(NODE * node
               ,NODE * node_nb);

//
bool checkNodeRoute(NODE * node);

//
vector<vector<NODE *> > getSubNetworks(vector<NODE *> nodes_l
                                      ,vector<NODE *> nodes_r);

//
vector<map<int, NODE *> > getNewMap(vector<NODE *> nodes_l
                                 ,vector<NODE *> nodes_r);

//
void rstNodeIdx(vector<NODE *> node);

//
void relinkSubNetworks(vector<NODE *> nodes_l_up
                      ,vector<NODE *> nodes_r_up
			          ,map<int, NODE *> map_node_l
			          ,map<int, NODE *> map_node_r);

//
void rstRoute(vector<NODE *> nodes);


#endif