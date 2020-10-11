#include "node.h"
#include "per_func.h"

//generate a vector
vector<int> vecGen(int size, int stride)
{
  vector<int> vec;

  for(int i=0; i<size; i++)
	vec.push_back(i);

  if(stride == 0)
    return bitRevVecGen(size);
  else if (stride == -1)
    return vec;
  else if (stride > 1)
    return strideVecGen(size,stride);	
  else
    std::cout<<"Error"<<std::endl;
}

//generate a stride permuted vector
vector<int> strideVecGen(int size, int stride)
{
  vector<int> vec_per;

  for(int i=0; i<size; i++)
    vec_per.push_back(((i*stride)/(size)) + ((i*stride)%(size)));
  
  return vec_per;
}

//generate a bit reversal vector
vector<int> bitRevVecGen(int size)
{
  int stride = 2;
  int stride_ = size/4;
  vector<int> vec1,vec2;

  for(int i=0; i<size; i++)
	vec1.push_back(((i*stride)/(size)) + ((i*stride)%(size)));
		  
  for(int i=0; i<size/2; i++)
    vec2.push_back(vec1[((i*stride_)/(size/2)) + ((i*stride_)%(size/2))]);
		  
  for(int i=0; i<size/2; i++)
    vec2.push_back(vec1[((i*stride_)/(size/2)) + ((i*stride_)%(size/2))+size/2]);

  return vec2;
}