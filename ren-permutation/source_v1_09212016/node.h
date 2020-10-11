#ifndef NODE_H
#define NODE_H

#include <iostream>
#include <vector>
#include <map>
#include <fstream>
using namespace std;


//a node is a data element
class NODE
{
public:
	//routed to upper level or the lower level 
	bool upper;     
	bool lower;
	//left side of right side in the routing network
	bool side;
	//vertical location index
	int idx_location;
	//set the value of the node
	void setvalue(int val);
	int readvalue(void);
	NODE(void);
private:
	int value;
};

#endif