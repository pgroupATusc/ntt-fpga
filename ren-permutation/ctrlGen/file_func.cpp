#include "file_func.h"

vector<int> readFile(char * file_pt)
{
  char* file_name = file_pt;
  
  ifstream input_vec(file_name);
  int data_word;
  vector<int> output;
  
  if(input_vec.is_open()){
    while(input_vec >> data_word){
      output.push_back(data_word);
    }
  }else{
    cout<<"Cannot open input file: "<<(*file_pt)<<endl;
    return output;
  }

  return output;  
}