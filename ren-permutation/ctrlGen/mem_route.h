#ifndef MEM_ROUTE_H
#define MEM_ROUTE_H

#include <iostream>
#include <vector>
#include <map>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <time.h>
#include "per_func.h"


vector<vector<bool> > runRouteMem(vector<NODE *> nodes_l
                             ,vector<NODE *> nodes_r
							 ,map<int, NODE *> map_node_l
							 ,map<int, NODE *> map_node_r
							 ,int network_size
							 ,int data_parallelism);
							 
vector<vector<int> > getMemAddr(vector<NODE *> nodes_l
                               ,vector<NODE *> nodes_r);
							   
int getNullSwithNum(vector<vector<bool> > ctrl_bits);

int getNumAddrSeq(vector<int> mem_addr_vec);

bool areVecsEqual(vector<int> in_a, vector<int> in_b);

vector<int> getUniqIdx(vector<NODE *> nodes_l
                      ,vector<NODE *> nodes_r
					  ,map<int, NODE *> map_node_l
					  ,map<int, NODE *> map_node_r);

#endif