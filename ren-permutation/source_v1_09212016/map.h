#ifndef NODEMAP_H
#define NODEMAP_H

#include <iostream>
#include <vector>
#include <map>
#include <fstream>
using namespace std;
#include "node.h"

//A nodemap has many data element
class NODEMAP
{
public:
	NODEMAP(void);
	//
	vector<vector<NODE *> > nodes_l;   
    vector<vector<NODE *> > nodes_r;
    vector<map<int, NODE *> > map_l;   
    vector<map<int, NODE *> > map_r;
	
private:
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

#endif