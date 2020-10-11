#!/usr/bin/python3
#getCtrlBits.py
#Date: Sep/7/2016

import copy
import getopt
import sys
import math

def getArgs():
    args = sys.argv[1:]
    inSize = args[0]
    ##stride = 0 as default
    stride = args[1]   
    dp = args[2]
    return inSize, stride, dp
    
##  Subnetworks

class SubNetwork:
  
    def __init__(self, size, stride, dp):
        
        self.size = size
        self.stride = stride
        self.dp = dp
        self.leftSwBits = []
        self.rigthSwBits = []
        self.upMemAddr = [] 
        self.lowMemAddr = []

 
def readCtrlBitsFile(fileName):
    with open(fileName, 'r') as inputFile: 
        input = inputFIle.read().splitlines()
    
    
        

    