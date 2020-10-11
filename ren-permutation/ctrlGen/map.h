#ifndef NODEMAP_H
#define NODEMAP_H

#include <iostream>
#include <vector>
#include <map>
#include <fstream>
#include "node.h"
using namespace std;

//A nodemap has many data element
class NODEMAP
{
public:
	NODEMAP(void);
	NODEMAP(const NODEMAP &cp);
	~NODEMAP();
	//control bits for input stage and output stage
	vector<vector<bool> > switch_ctrl;   
	//memory addresses for upper memory and lower memory
    vector<int> addr_up, addr_down;	

    //Stage index for decomposition
	//int data_parallelsim;
	int decomp_stage;	
	int idx_file;
	int map_size;
};


class BENES: public NODEMAP
{
public:
    BENES(void);
private:
    
};


class CLOS: public NODEMAP
{
public:
    CLOS(void);
private:
    int s1,s2;
};

//
class SPNCTRL
{
public:
	SPNCTRL(void);
	//control bits for input stages and output stages
	vector<vector<vector<bool> > > lsb;
	vector<vector<vector<bool> > > rsb;
	 
	//memory addresses for all dp memory blocks
    vector<vector<int> > mem_addr; 
};

#endif