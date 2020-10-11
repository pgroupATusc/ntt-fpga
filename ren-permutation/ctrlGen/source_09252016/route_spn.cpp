//******************************
//******************************
//*****Author: Ren Chen*********
//*****Date: 08/12/2016*********
//******************************
//******************************
//******************************


#include <iostream>
#include <vector>
#include <map>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <time.h>
#include "node.h"
#include "per_func.h"
#include "file_func.h"
#include "map.h"
#include "greedy_route.h"
#include "mem_route.h"
#include "con_route.h"

using namespace std;

//
#define DEBUG 1

int main(int argc, char * argv [])
 {	
	//clock variables
    clock_t t1,t2;
	t1 = clock();

	//input parameters
	int net_size, stride, dp, ra_sel;   //data_parallelism
    vector<int> output; 
	 
	//input
    #if DEBUG == 1
	    net_size = 16;
	    dp = 4; 
	    stride = 4;
	    ra_sel = 0;
	    output = vecGen(net_size, stride);
	#else
	  if(argc == 5){
	    net_size = atoi(argv[1]);
	    dp = atoi(argv[2]); 
	    stride = atoi(argv[3]);
	    ra_sel = atoi(argv[4]);
	    output = vecGen(net_size, stride);
	  }
	  else if(argc == 4){
	    output = readFile(argv[1]);
	    dp = atoi(argv[2]);
	    stride = 0;
	    ra_sel = atoi(argv[3]);
	  }
	  else{
        cout<<"Wrong command"<<endl; 
	    cout<<"Input example 0: exe networkSize dataParallelism stride/0 routingAlgorithm"<<endl;
	    cout<<"Input example 1: exe filename dataParallelism routingAlgorithm"<<endl;
	    cout<<"Routing algorithm selection:"<<endl;
	    cout<<"0: greedy algorithm"<<endl;
	    cout<<"1: efficient memory addressing"<<endl;
	    cout<<"2: interconnection optimal"<<endl;
	    return 0;
	  }  
    #endif


	if(ra_sel == 0){
	  greedyRoute(net_size, dp, stride, output, 0);
	}
	else if(ra_sel == 1){
	  memRoute(net_size, dp, stride, output);
	}
	else if(ra_sel == 2){
	  conRoute(net_size, dp, stride, output);
	}
	
	//Display run time
	t2 = clock();
	float seconds = (float(t2)-float(t1))/CLOCKS_PER_SEC;
	cout<<"Runtime: "<<seconds<<" sec"<<endl;
	//system ("pause");

	return 0;
}

