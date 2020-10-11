#include "node.h"
#include "per_func.h"
#include <algorithm>

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
  return vec;
}


//generate a stride permuted vector
vector<int> strideVecGen(int size, int stride)
{
  vector<int> vec_per;

  for(int i=0; i<size; i++)
  {
    vec_per.push_back(((i*stride)/(size)) + ((i*stride)%(size)));
    cout<< ((i*stride)/(size)) + ((i*stride)%(size))<<",";
  }
  cout<<endl;
  
  return vec_per;
}

//generate a bit reversal vector
vector<int> bitRevVecGen(int size)
{
  vector<string> vec;
  vector<int> res;
  int len = int(log2(size));

  for(int i=0; i<size; i++)
  {
    string tmp = bitset<32>(i).to_string();
	  vec.push_back(tmp.substr(tmp.size() - len));
    //cout<<tmp.substr(tmp.size() - len)<<",";
	}
  //cout<<endl;

  for(int i=0; i<size; i++)
    std::reverse(vec[i].begin(), vec[i].end());
		  
  for(int i=0; i<size; i++)
  {
    int x = int(bitset<32>(vec[i]).to_ulong());
    res.push_back(x);
    //cout << x<<",";;
  }
  //cout<<endl;

  return res;
}