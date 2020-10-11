#!/usr/bin/python3
#Generate permutation verilog implementation
#Author: Ren Chen
#Date: Aug/12/2016

import getopt
import sys
import copy
import math
import memGen
import gressGen
import subprocess

g_SizeN, g_dp, g_stride, g_perIdx, g_raSel = 0, 0, 0, 0, 0

#Get arguments
def getArgs():
    args = sys.argv[1:]
    if len(args) < 5:
        assert (False), "Wrong command\nFormat: inputSize, dp, stride, raSel, perIdx"
    inputSize = args[0]
    dp = args[1]       ##dp: data parallelism 
    stride = args[2]   
    raSel = args[3]    ##raSel: opt algorithm to be used 
    perIdx = args[4]   ##perIdx: unique idx of the permutation

    return inputSize, dp, stride, perIdx, raSel

def getCtrl(inputSize, dp, stride, perIdx, raSel):
    #inputSize, dp, stride, perIdx, raSel = getArgs()
    printDebugInfo = "0"
    ##run perGen to get the permutation result
    subprocess.call(["../ctrlGen/perGen", str(inputSize), str(dp), str(stride), str(raSel), str(perIdx), printDebugInfo])
    
    ##Read ctrl file
    fileName = "ctrl_per_"+str(perIdx)
    numIntStage = int(math.log(float(dp),2.0))
    numSwitchPerStage = int(dp)/2
    numCtrlBitsPerSwitch = int(inputSize)/int(dp)  
    numMem = int(dp)

    ##control bit vectors for ingress stage
    ingressStageBits =  [[[0 for k in xrange(numCtrlBitsPerSwitch)]   \
                             for j in xrange(numSwitchPerStage)]  \
                             for i in xrange(numIntStage)]
    ##control bit vectors for egress stage
    egressStageBits =   [[[0 for k in xrange(numCtrlBitsPerSwitch)]   \
                             for j in xrange(numSwitchPerStage)]  \
                             for i in xrange(numIntStage)]
    memAddr = [[] for k in range(0,numMem)]
                             
    with open(fileName, 'r') as fileIn:
        for i in xrange(4):
            fileIn.readline()
        ##Read ctrl bits for input ingress stage 
        for i in range(0, numIntStage):
            fileIn.readline()
            for j in range(0, numSwitchPerStage):
                lineIn = fileIn.readline().strip('\r\n')
                lineInVec = lineIn.split(':')
                strVec = lineInVec[1].split(' ')
                #print strVec    
                numVec = [int(element,16) for element in strVec if element]
                ingressStageBits[i][j] = numVec
        fileIn.readline()    

        #print ingressStageBits   
        ##Read ctrl bits for output egress stage 
        for i in range(0, numIntStage):
            fileIn.readline()
            for j in range(0, numSwitchPerStage):
                lineIn = fileIn.readline().strip('\r\n')
                lineInVec = lineIn.split(':')
                strVec = lineInVec[1].split(' ')
                numVec = [int(element,16) for element in strVec if element]
                egressStageBits[i][j] = numVec
        fileIn.readline()     
        #print egressStageBits  
        ##Read memory addresses 
        for i in range(0, numMem):
            fileIn.readline()
            lineIn = fileIn.readline().strip('\r\n')
            strVec = lineIn.split(' ')
            numVec = [int(element,16) for element in strVec if element]
            memAddr[i] = numVec     
        #print memAddr
    return ingressStageBits, egressStageBits, memAddr
    
    
#Generate permutation implementation
def genPer(args):
    g_SizeN, g_dp, g_stride, g_perIdx, g_raSel, dataWidth, regOut = args
    fileName = "per_n" + str(g_SizeN) + "_p" + str(g_dp) + "_idx" + str(g_perIdx) + ".v"
    ##Get control information 
    ingressStageBits, egressStageBits, memAddr = getCtrl(g_SizeN, g_dp, g_stride, g_perIdx, g_raSel)
    dp = g_dp

    #########################
    ###Generate basic blocks
    with open(fileName, 'w') as wrFile:
        wrFile.write("\n")
    gressGen.gen2to2Switch(fileName, dataWidth, False)
    
    #memGen.gen1to2Switch(fileName, dataWidth)
    #memGen.gen2to1Switch(fileName, dataWidth)

    memGen.genDataSPRam(fileName, dp, g_SizeN, dataWidth, "block_ram_sp")
    memGen.genDataSPRam(fileName, dp, g_SizeN, dataWidth, "dist_ram_sp")

    memGen.genDataDPRam(fileName, dp, g_SizeN, dataWidth, "block_ram_dp")
    memGen.genDataDPRam(fileName, dp, g_SizeN, dataWidth, "dist_ram_dp")

    ##Connect wireIn with LB, RB, MemStage
    regOutSwitch, regOutWireCon = [], []
    ##Determine if register one switch stage or one wire stage
    for i in range(0, int(math.log(dp,2))):
        a, b = 0, 0
        ##Currently, to simplify switch control, only one pipeline stage enabled
        if(i == int(math.log(dp,2))-1):
            regOutSwitch.append(a)
        else:
            regOutSwitch.append(b)      
        regOutWireCon.append(b)
        
    nameLB = gressGen.genStagesBlock(fileName, dp, g_stride, g_SizeN/g_dp, "L", dataWidth, ingressStageBits,   \
                                     regOutSwitch, regOutWireCon, False, g_perIdx)

    nameRB = gressGen.genStagesBlock(fileName, dp, g_stride, g_SizeN/g_dp, "R", dataWidth, egressStageBits, 
                                     regOutSwitch[::-1], regOutWireCon, False, g_perIdx)

    nameMemStage = memGen.genMemStage(fileName, dp, g_SizeN, g_stride, dataWidth, memAddr, regOut, g_perIdx)

    #Gen permutation module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module per_dp")
        wrFile.write(str(dp))
        wrFile.write("_" + str(g_perIdx))
        if(regOut):
            wrFile.write("_r")
        wrFile.write("(\n")

    #Generate multiport names
    genMultiPortName(fileName, dp, "inData", False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    #Generate multiport names
    genMultiPortName(fileName, dp, "outData", False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    
    with open(fileName, 'a') as wrFile:
        wrFile.write("in_start,                        \n")
        wrFile.write("out_start,                       \n")
        wrFile.write("clk,                             \n")
        wrFile.write("rst                              \n")
        wrFile.write(");                               \n  ")
        wrFile.write("parameter DATA_WIDTH = ")
        wrFile.write(str(dataWidth))
        wrFile.write(";                                \n  ")       
        wrFile.write("input in_start, clk, rst;        \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] ")

    genMultiPortName(fileName, dp, "inData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        if(not regOut):
            wrFile.write("output [DATA_WIDTH-1:0] ")
        else:
            wrFile.write("output reg [DATA_WIDTH-1:0] ")
  
    genMultiPortName(fileName, dp, "outData", True)

    with open(fileName, 'a') as wrFile:
        wrFile.write("; \n  ")
        if(not regOut):
            wrFile.write("output out_start; ")
        else:
            wrFile.write("output reg out_start; ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireIn ["+str(dp-1)+":0];                  \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireOut ["+str(dp-1)+":0];                 \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireOut_LB ["+str(dp-1)+":0];              \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireIn_RB ["+str(dp-1)+":0];               \n  ")
        wrFile.write("wire out_start_LB;               \n  ")
        wrFile.write("wire out_start_MemStage;               \n  ")
        wrFile.write("wire out_start_RB;               \n\n  ")
        
        ##Connect wireIn with inData
        for i in range(0, dp):
            wrFile.write("assign wireIn["+str(i)+"] = inData_"+str(i)+";    \n  ")
        wrFile.write("\n  ")
        
        #Connect wireIn with ingress Stage
        wrFile.write(nameLB+" "+ nameLB+"_inst(")
        for j in range(0, dp):  
            wrFile.write(".inData_"+str(j)+"(wireIn["+str(j)+"]), ")
        for j in range(0, dp):
            wrFile.write(".outData_"+str(j)+"(wireOut_LB["+str(j)+"]), ")
        wrFile.write(".in_start(in_start), ")
        wrFile.write(".out_start(out_start_LB), ")
        wrFile.write(".clk(clk), .rst(rst));\n  \n  ")

        #Connect ingress Stage with memory stage
        wrFile.write(nameMemStage+" "+ nameMemStage+"_inst(")
        for j in range(0, dp):  
            wrFile.write(".inData_"+str(j)+"(wireOut_LB["+str(j)+"]), ")
        for j in range(0, dp):
            wrFile.write(".outData_"+str(j)+"(wireIn_RB["+str(j)+"]), ")
        wrFile.write(".in_start(out_start_LB), ")
        wrFile.write(".out_start(out_start_MemStage), ")
        wrFile.write(".clk(clk), .rst(rst));\n  \n  ")
        
        #Connect memory stage with egress stage
        wrFile.write(nameRB+" "+ nameRB+"_inst(")
        for j in range(0, dp):  
            wrFile.write(".inData_"+str(j)+"(wireIn_RB["+str(j)+"]), ")
        for j in range(0, dp):
            wrFile.write(".outData_"+str(j)+"(wireOut["+str(j)+"]), ")
        wrFile.write(".in_start(out_start_MemStage), ")
        wrFile.write(".out_start(out_start_RB), ")
        wrFile.write(".clk(clk), .rst(rst));\n  \n  ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        #Connect wireOut with OutData
        if(regOut):
            wrFile.write("always@(posedge clk)             \n  ")
            wrFile.write("begin                            \n    ")
            wrFile.write("if(rst) begin                    \n      ")
            for i in range(0, dp):
                wrFile.write("outData_"+str(i)+" <= 0;    \n      ")
            wrFile.write("out_start <= 1'b0;    \n      ")
            wrFile.write("end\n    ")
            wrFile.write("else begin                        \n      ")
            for i in range(0, dp):
                wrFile.write("outData_"+str(i)+" <= wireOut["+str(i)+"];    \n      ")
            wrFile.write("out_start <= out_start_RB;    \n      ")
            wrFile.write("end\n  ")
            wrFile.write("end                              \n")
        else:
            for i in range(0, dp):
                wrFile.write("assign outData_"+str(i)+" = wireOut["+str(i)+"];    \n  ")
            wrFile.write("assign out_start = out_start_RB;    \n  ")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")


#Generate multi port names
def genMultiPortName(fileName, numPorts, namePre, addTabs):
    with open(fileName, 'a') as wrFile:
        for i in range(0, numPorts):
            wrFile.write(namePre)
            wrFile.write("_")
            wrFile.write(str(i))
            if(i == numPorts - 1):
                wrFile.write("")
            else:
                wrFile.write(",\n")
                if(addTabs):
                    wrFile.write("      ")
            

#Get output idx after stride permutation
def mapStridePer(inSize, inIdx, stride):
    outIdx = (int)(inIdx/stride) + (int)(inIdx % stride) * (int)(inSize/stride)
    return outIdx


################################
##genMuxReg("mux_reg")

##genWireCon(fileName, stageIdx, dp, lOrR, dataWidth, regOut)
##genWireCon("genWire.v", 2, 16, "l", 16, True)
##gen2to2Switch("gen2to2Switch.v", 16, True)
##genSwitchesStage("stageSwitches.v", 2, 16, "l", 16, True)

##Test2
#ctrlIn = []
#for i in range(0, 8):
#    vec = [0,i%2,0,1]
#    ctrlIn.append(vec)
#
#genSwitchCtrl("switchCtrl.v", 1, 8, "l", ctrlIn ) 

dp = 4
regOutSwitch = []
regOutWireCon = []
for i in range(0, int(math.log(dp,2))):
    a, b = 1, 0
    regOutSwitch.append(a)
    regOutWireCon.append(b)

#genStagesBlock("leftBlock.v", dp, "L", 8, regOutSwitch, regOutWireCon, True)
#genStagesBlock("rightBlock.v", dp, "R", 8, regOutSwitch, regOutWireCon, True)
#for i in [2,4,8,16,32]:
#g_SizeN, g_dp, g_stride, g_perIdx, g_raSel, dataWidth, regOut = args
for i in range(6):
    args = [16*(4**i), 4, 0, i, 0, 32, False]
    genPer(args)
#genPer([16*16, 4, 16, 256, 0, 16, True])

#genPer([64,2,0,642,0,16,False])
