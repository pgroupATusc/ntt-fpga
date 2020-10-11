#!/usr/bin/python3

import getopt
import sys
import copy
import math
import collections

def genTest(size, dp):
	inVec = [i for i in range(size)]
	inVec2D = [[] for i in range(dp)]

	return 0
    
  
def speicalVec(size):
    stride = 2
    stride_ = size/4
    vec1 = []
    vec2 = []
    
    for i in range(size):
        vec1.append(((i*stride)/(size)) + ((i*stride)%(size)))
        
    for i in range(size/2):
        vec2.append(vec1[((i*stride_)/(size/2)) + ((i*stride_)%(size/2))])
        
    for i in range(size/2):
        vec2.append(vec1[((i*stride_)/(size/2)) + ((i*stride_)%(size/2))+size/2])
    
    print vec2
    
    return vec2
  

  

speicalVec(16)