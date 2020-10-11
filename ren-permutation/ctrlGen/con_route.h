#ifndef CON_ROUTE_H
#define CON_ROUTE_H

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


vector<vector<bool> > runRouteCon(vector<NODE *> nodes_l
                             ,vector<NODE *> nodes_r
							 ,map<int, NODE *> map_node_l
							 ,map<int, NODE *> map_node_r
							 ,int network_size
							 ,int data_parallelism
							 ,ofstream& debug);

bool isNullSwitch(vector<bool> ctrl_bits);

#endif