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
#define DEBUG 0

int main(int argc, char * argv [])
 {	
	//clock variables
    clock_t t1,t2;
	t1 = clock();

	//input parameters
	int net_size, stride, dp, ra_sel, ofile_idx, print_subs;   //data_parallelism
    vector<int> output; 
	 
	//input
    #if DEBUG == 1
	    net_size = 256;
	    dp = 4; 
	    stride = 16;
	    ra_sel = 0;
		print_subs = 1;
	    output = vecGen(net_size, stride);

		greedyRoute(net_size, dp, stride, output, 0, ra_sel, print_subs);
	#else
	  if(argc == 7){
	    net_size = atoi(argv[1]);
	    dp = atoi(argv[2]); 
	    stride = atoi(argv[3]);
	    ra_sel = atoi(argv[4]);
		ofile_idx = atoi(argv[5]);
		print_subs = atoi(argv[6]);
	    output = vecGen(net_size, stride);

		greedyRoute(net_size, dp, stride, output, ofile_idx, ra_sel, print_subs);
	  }
	  else if(argc == 6){
	    output = readFile(argv[1]);
		net_size = output.size();
	    dp = atoi(argv[2]);
	    stride = 0;
	    ra_sel = atoi(argv[3]);
		ofile_idx = atoi(argv[4]);
		print_subs = atoi(argv[5]);

		greedyRoute(net_size, dp, stride, output, ofile_idx, ra_sel, print_subs);
	  }
	  else{
        cout<<"Wrong command"<<endl; 
	    cout<<"Input example 0: exe networkSize dataParallelism stride/0 routingAlgorithm perIdx debugInfo"<<endl;
	    cout<<"Input example 1: exe filename dataParallelism routingAlgorithm perIdx debugInfo"<<endl;
	    cout<<"Routing algorithm selection:"<<endl;
	    cout<<"0: greedy algorithm"<<endl;
	    cout<<"1: efficient memory addressing"<<endl;
	    cout<<"2: interconnection optimal"<<endl;
	    return 0;
	  }  
    #endif
	
	//Display run time
	t2 = clock();
	float seconds = (float(t2)-float(t1))/CLOCKS_PER_SEC;
	cout<<"Runtime: "<<seconds<<" sec"<<endl;
	//system ("pause");

	return 0;
}

