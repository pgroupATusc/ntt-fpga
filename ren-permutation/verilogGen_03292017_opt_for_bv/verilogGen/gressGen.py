#!/usr/bin/python3
#Generate permutation verilog implementation
#Author: Ren Chen
#Date: Aug/12/2016

import getopt
import sys
import copy
import math

optCon = True
inDataNamePre = "inData"
outDataNamePre = "outData"
wireInName = "wire_in"
wireOutName = "wire_out"
switch2x2Name = "switch_2_2"
inStartPortName = "in_start"
outStartPortName = "out_start"

#Get arguments
def getArgs():
    args = sys.argv[1:]
    inputSize = args[0]
    stride = args[1]
    dp = args[2]  ##dp: data parallelism
    return inputSize,stride,dp


#Generate a 2-to-2 switch
def gen2to2Switch(fileName, dataWidth, regOut):
    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module switch")
        wrFile.write("_" + str(2))
        wrFile.write("_" + str(2))
        if(regOut):
            wrFile.write("_r")
        wrFile.write("(\n")

    #Generate multiport names
    genMultiPortName(fileName, 2, "inData", False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    #Generate multiport names
    genMultiPortName(fileName, 2, "outData", False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    
    with open(fileName, 'a') as wrFile:
        wrFile.write("ctrl,                            \n")
        wrFile.write("clk,                             \n")
        wrFile.write("rst                              \n")
        wrFile.write(");                               \n  ")
        wrFile.write("parameter DATA_WIDTH = ")
        wrFile.write(str(dataWidth))
        wrFile.write(";                                \n  ")       
        wrFile.write("input ctrl, clk, rst;                   \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] ")

    genMultiPortName(fileName, 2, "inData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        if(not regOut):
            wrFile.write("output [DATA_WIDTH-1:0] ")
        else:
            wrFile.write("output reg [DATA_WIDTH-1:0] ")
  
    genMultiPortName(fileName, 2, "outData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireIn ["+str(2-1)+":0];              \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireOut ["+str(2-1)+":0];              \n  \n  ")
        ##Connect wireIn with inData
        for i in range(0, 2):
            wrFile.write("assign wireIn["+str(i)+"] = inData_"+str(i)+";    \n  ")
        wrFile.write("\n  ")
        #Connect wireIn with wireOut
        wrFile.write("assign wireOut[0] = (!ctrl) ? wireIn[0] : wireIn[1];    \n  ")
        wrFile.write("assign wireOut[1] = (!ctrl) ? wireIn[1] : wireIn[0];    \n  ")

        wrFile.write("\n  ")
        #Connect wireOut with OutData
        if(regOut):
            wrFile.write("always@(posedge clk)             \n  ")
            wrFile.write("begin                            \n    ")
            wrFile.write("if(rst) begin                    \n      ")
            for i in range(0, 2):
                wrFile.write("outData_"+str(i)+" <= 0;    \n      ")
            wrFile.write("end\n    ")
            wrFile.write("else begin                        \n      ")
            for i in range(0, 2):
                wrFile.write("outData_"+str(i)+" <= wireOut["+str(i)+"];    \n      ")
            wrFile.write("end\n  ")
            wrFile.write("end                              \n")
        else:
            for i in range(0, 2):
                wrFile.write("assign outData_"+str(i)+" = wireOut["+str(i)+"];    \n  ")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")


#Generate wire connetions in SPN.LB
def genWireCon(fileName, stageIdx, dp, lOrR, dataWidth, regOut):
    inWireIdx = [i for i in range(0, dp)]
    outWireIdx = [0 for i in range(0,dp)]
    ##dp, stageIdx, lOrR determine a unique wire con
    moduleName = "wireCon_dp"+str(dp)+"_st"+str(stageIdx)+"_"+lOrR

    #Get wireIdx in the output vector
    for i in range(0, 2**stageIdx):
        inSize = dp/(2**stageIdx)
        for j in range (0, inSize):
            arrayIdx = i*inSize + j
            if(lOrR == "L"):
                ###For connections in LB
                outWireIdx[arrayIdx] = mapStridePer(inSize, j, 2)
            else:
                ###For connections in RB
                outWireIdx[arrayIdx] = mapStridePer(inSize, j, inSize/2)
            outWireIdx[arrayIdx] += i*inSize

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module "+moduleName)
        if(regOut):
            wrFile.write("_r")
            moduleName = moduleName + "_r"
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
        wrFile.write("wire [DATA_WIDTH-1:0] wireIn ["+str(dp-1)+":0];              \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireOut ["+str(dp-1)+":0];              \n  \n  ")
        ##Connect wireIn with inData
        for i in range(0, dp):
            wrFile.write("assign wireIn["+str(i)+"] = inData_"+str(i)+";    \n  ")
        wrFile.write("\n  ")
        #Connect wireIn with wireOut
        for i in range(0, dp):
            wrFile.write("assign wireOut["+str(i)+"] = wireIn["+str(outWireIdx[i])+"];    \n  ")

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
            wrFile.write("out_start <= in_start;    \n      ")
            wrFile.write("end\n  ")
            wrFile.write("end                              \n")
        else:
            for i in range(0, dp):
                wrFile.write("assign outData_"+str(i)+" = wireOut["+str(i)+"];    \n  ")
            wrFile.write("assign out_start = in_start;    \n  ")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")

    return moduleName

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


#Generate a stage of switches based on ctrl bits
def genSwitchesStage(fileName, dp, lOrR, dataWidth, regOut, nullVec, stageIdx, perIdx):
    #Gen 2to2 switch module
    #gen2to2Switch(fileName, dataWidth, False)
    moduleName = "switches_stage_st"+str(stageIdx)+"_"+str(perIdx)+"_"+lOrR

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module "+moduleName)
        if(regOut):
            wrFile.write("_r")
            moduleName = moduleName + "_r"
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
        wrFile.write("ctrl,                            \n")
        wrFile.write("clk,                             \n")
        wrFile.write("rst                              \n")
        wrFile.write(");                               \n  ")
        wrFile.write("parameter DATA_WIDTH = ")
        wrFile.write(str(dataWidth))
        wrFile.write(";                                \n  ")       
        wrFile.write("input in_start, clk, rst;                   \n  ")
        wrFile.write("input ["+str(dp/2)+"-1:0] ctrl;        \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] ")

    ##input ports
    genMultiPortName(fileName, dp, "inData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        if(not regOut):
            wrFile.write("output [DATA_WIDTH-1:0] ")
        else:
            wrFile.write("output reg [DATA_WIDTH-1:0] ")

    ##output ports
    genMultiPortName(fileName, dp, "outData", True)

    with open(fileName, 'a') as wrFile:
        wrFile.write("; \n  ")
        if(not regOut):
            wrFile.write("output out_start; ")
        else:
            wrFile.write("output reg out_start; ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireIn ["+str(dp-1)+":0];              \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireOut ["+str(dp-1)+":0];              \n  \n  ")
        ##Connect wireIn with inData
        for i in range(0, dp):
            wrFile.write("assign wireIn["+str(i)+"] = inData_"+str(i)+";    \n  ")
        wrFile.write("\n  ")

        ##Gen several 2-to-2 switches
        for i in range(0, dp/2):
            if(nullVec[i] == 0):
                wrFile.write("switch_2_2 switch_inst_"+str(i)+"(")
                wrFile.write(".inData_0(wireIn["+str(i*2)+"]), ")
                wrFile.write(".inData_1(wireIn["+str(i*2+1)+"]), ")
                wrFile.write(".outData_0(wireOut["+str(i*2)+"]), ")
                wrFile.write(".outData_1(wireOut["+str(i*2+1)+"]), ")
                wrFile.write(".ctrl(ctrl["+str(i)+"]), ")
                wrFile.write(".clk(clk), .rst(rst));\n  ")
            ##cross state
            elif(nullVec[i] == 1):
                wrFile.write("assign wireOut["+str(i*2)+"] = wireIn["+str(i*2+1)+"]; ")
                wrFile.write("assign wireOut["+str(i*2+1)+"]= wireIn["+str(i*2)+"]; ")
            ##pass state
            elif(nullVec[i] == 2):
                wrFile.write("assign wireOut["+str(i*2+1)+"] = wireIn["+str(i*2+1)+"]; ")
                wrFile.write("assign wireOut["+str(i*2)+"]= wireIn["+str(i*2)+"]; ")

        wrFile.write("\n  ")
        #Connect wireOut with OutData
        if(regOut):
            wrFile.write("always@(posedge clk)             \n  ")
            wrFile.write("begin                            \n    ")
            wrFile.write("if(rst) begin                    \n      ")
            for i in range(0, dp):
                wrFile.write("outData_"+str(i)+" <= 0;    \n      ")
            wrFile.write("out_start <= 1'b0;              \n      ")
            wrFile.write("end\n    ")
            wrFile.write("else begin                        \n      ")
            for i in range(0, dp):
                wrFile.write("outData_"+str(i)+" <= wireOut["+str(i)+"];    \n      ")
            wrFile.write("out_start <= in_start;    \n      ")
            wrFile.write("end\n  ")
            wrFile.write("end                              \n")
        else:
            for i in range(0, dp):
                wrFile.write("assign outData_"+str(i)+" = wireOut["+str(i)+"];    \n  ")
            wrFile.write("assign out_start = in_start;    \n  ")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")   

    return moduleName

##Generate rom memory for switch control
def genCtrlRom(fileName, stageIdx, dp, lOrR, ctrlVec, perIdx):
    vecSize = len(ctrlVec)  ##vecSize = dp/2
    addrWidth = int(math.ceil(math.log(len(ctrlVec[0]), 2.0)))  #addrWidth = log2(input size/(dp/2))
    moduleName = "ctrl_rom_dp"+str(dp)+"_st"+str(stageIdx)+"_per"+str(perIdx)+lOrR

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module "+moduleName)
        wrFile.write("(\n")
        wrFile.write("en,                              \n")
        wrFile.write("clk,                             \n")
        wrFile.write("rst,                             \n")
        wrFile.write("addr,                            \n")
        wrFile.write("data                             \n")
        wrFile.write(");                               \n  ")
        #wrFile.write("parameter DATA_WIDTH = ")
        #wrFile.write(str(dataWidth))
        #wrFile.write(";                                \n  ")       
        wrFile.write("input en, clk, rst;                   \n  ")
        wrFile.write("input ["+str(addrWidth-1)+":0] addr;                        \n  ")
        wrFile.write("output reg ["+str(dp/2-1)+":0] data;        \n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        if(vecSize * dp >= 256 * 16):
            wrFile.write("// synthesis attribute rom_style of data is \"block\" \n  ")
        else:
            wrFile.write("// synthesis attribute rom_style of data is \"distributed\"  \n  ")
        #Update ctrl_out cycle by cycle
        wrFile.write("always@(posedge clk)             \n  ")
        wrFile.write("begin                            \n    ")
        wrFile.write("if(rst) begin                    \n      ")
        wrFile.write("data <= "+str(dp/2)+"'b0;    \n      ")
        wrFile.write("end\n    ")
        wrFile.write("else begin                        \n      ")
        wrFile.write("if (en)                           \n        ")
        wrFile.write("case(addr)                        \n          ")
        for i in range(0, len(ctrlVec[0])):
            tmpStr = bin(int(i))[2:].zfill(addrWidth)
            tmpDataStr = (convVecToBinStr([x[i] for x in ctrlVec]))
            wrFile.write(str(addrWidth)+"'b"+tmpStr+": data <= "+str(dp/2)+"'b"+tmpDataStr+"; \n          ")
        wrFile.write("default: data <= "+str(dp/2)+"'b0"+"; \n        ")
        wrFile.write("endcase\n    ")
        wrFile.write("end\n  ")
        wrFile.write("end                              \n\n")
        wrFile.write("endmodule                        \n\n")  

    return moduleName

def convVecToBinStr(vecIn):
    size = len(vecIn)
    tmpStr = ""
    ##reverse the order
    for i in range(size-1, -1, -1):
        tmpStr += str(vecIn[i])
    return tmpStr

##Generate control part for updating control rom
def genSwitchCtrl(fileName, stageIdx, dp, lOrR, ctrlVec, perIdx):
    vecSize = len(ctrlVec)
    addrWidth = int(math.ceil(math.log(len(ctrlVec[0]), 2.0)))
    moduleName = "switch_ctrl_dp"+str(dp)+"_st"+str(stageIdx)+"_per"+str(perIdx)+lOrR
    #print "debug:",str(perIdx)

    nameCtrlRom = genCtrlRom(fileName, stageIdx, dp, lOrR, ctrlVec, perIdx)

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module "+ moduleName)
        wrFile.write("(\n")
        wrFile.write("in_start,                          \n")
        wrFile.write("ctrl_out,                        \n")
        wrFile.write("clk,                             \n")
        wrFile.write("rst                              \n")
        wrFile.write(");                               \n  ")
        #wrFile.write("parameter DATA_WIDTH = ")
        #wrFile.write(str(dataWidth))
        #wrFile.write(";                                \n  ")       
        wrFile.write("input in_start, clk, rst;                   \n  ")
        wrFile.write("output ["+str(dp/2-1)+":0] ctrl_out;        \n  ")
        wrFile.write("\n  ")
        wrFile.write("reg ["+str(addrWidth-1)+":0] addr;        \n  ")
        wrFile.write("reg state;        \n  ")
        wrFile.write("\n  ")
        wrFile.write(nameCtrlRom +  \
                     " ctrl_rom_inst(.en(1'b1),.clk(clk),.rst(rst),.addr(addr),.data(ctrl_out)); \n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        #Update ctrl_out cycle by cycle
        wrFile.write("always@(posedge clk)             \n  ")
        wrFile.write("begin                            \n    ")
        wrFile.write("if(rst) begin                    \n      ")
        wrFile.write("addr <= "+str(addrWidth)+"'b0;    \n      ")
        wrFile.write("state <= 1'b0;            \n      ")
        wrFile.write("end\n    ")
        wrFile.write("else begin                        \n      ")
        ##Make sure ctrl_in has been registered
        wrFile.write("case(state)                \n        ")
        wrFile.write("1'b0: begin                \n          ")
        wrFile.write("addr <= "+str(addrWidth)+"'b0;         \n          ")
        wrFile.write("if (in_start) begin                     \n            ")
        wrFile.write("state <= 1'b1;                 \n            ")
        wrFile.write("addr <= addr + 1;         \n          ")
        wrFile.write("end                                    \n        ")
        wrFile.write("end                                    \n        ")
        wrFile.write("1'b1: begin               \n          ")
        wrFile.write("addr <= addr + 1;         \n          ")
        wrFile.write("if (addr == {"+str(addrWidth)+"{1'b1}}) begin         \n            ")
        wrFile.write("state <= 1'b0;                 \n          ")
        wrFile.write("end\n        ")
        wrFile.write("end                              \n      ")
        wrFile.write("endcase                              \n    ")
        wrFile.write("end\n  ")
        wrFile.write("end                              \n")
        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")    

    return moduleName

##Generate Ingress Stage or Egress Stage
##regOutSwitch and regOutWireCon are data vectors
def genStagesBlock(fileName, dp, g_stride, g_latency, lOrR, dataWidth, ctrlIn3D, regOutSwitch, regOutWireCon, regOut, perIdx):
    #print "Debug1:", str(perIdx)
    #Gen 2to2 switch module
    #gen2to2Switch(fileName, dataWidth, False)

    ##Calculate number of pipeline stages
    numPipelineStages = 0
    for i in range(0, len(regOutSwitch)):
        if(regOutSwitch[i] == 1):
            numPipelineStages = numPipelineStages + 1
    for i in range(0, len(regOutWireCon)):
        if(regOutWireCon[i] == 1):
            numPipelineStages = numPipelineStages + 1
    if regOut:
        numPipelineStages = numPipelineStages + 1

    ###Needs to replace
    ##ctrlIn3D = []
    ##for i in range(0, int(math.log(dp,2))):
    ##    ctrlIn2D = []
    ##    for j in range(0, 8):
    ##        ctrlIn1D = []
    ##        for k in range(0, dp/2):
    ##            ctrlIn1D.append((j+k)%2)
    ##        ctrlIn2D.append(ctrlIn1D)
    ##    ctrlIn3D.append(ctrlIn2D)

    ##Get switch stage
    swithStageNames = ["" for k in xrange(int(math.log(dp,2)))]
    switchesCtrlNames = ["" for k in xrange(int(math.log(dp,2)))]
    wireConStageNames = ["" for k in xrange(int(math.log(dp,2)))]

    for stageIdx in range(0, int(math.log(dp,2))):
        #nullVec: size of dp/2, 0:a switch, 1: cross state, 2:pass state
        nullVec = [0 for i in xrange(dp/2)]
        for i in range(0,dp/2):
            if(all(element == 1 for element in ctrlIn3D[stageIdx][i])):
                nullVec[i] = 1
            elif(all(element == 0 for element in ctrlIn3D[stageIdx][i])):
                nullVec[i] = 2
            else:
                nullVec[i] = 0
        
        swithStageNames[stageIdx] = genSwitchesStage(fileName, dp, lOrR, dataWidth, regOutSwitch[stageIdx], nullVec, stageIdx, perIdx)
        ##Generate control for swiches
        if g_stride != 0:
            switchesCtrlNames[stageIdx] = genSwitchCtrl(fileName, stageIdx, dp, lOrR, ctrlIn3D[stageIdx], perIdx)
        ##Generate wire connection stages
        wireConStageNames[stageIdx] = genWireCon(fileName, stageIdx, dp, lOrR, dataWidth, regOutWireCon[stageIdx])

    tmpStr = "ingress" if(lOrR == "L") else "egress"

    moduleName = tmpStr + "Stage_p" + str(dp)
    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module " + moduleName)
        #wrFile.write("_" + lOrR)
        #wrFile.write("_")
        #wrFile.write(str(stageIdx))
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
        wrFile.write("input in_start, clk, rst;                   \n  ")
        ##wrFile.write("input ["+str(dp/2)+"-1:0] ctrl;        \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] ")

    ##input ports
    genMultiPortName(fileName, dp, "inData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        if(not regOut):
            wrFile.write("output [DATA_WIDTH-1:0] ")
        else:
            wrFile.write("output reg [DATA_WIDTH-1:0] ")

    ##output ports
    genMultiPortName(fileName, dp, "outData", True)

    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")
        if(not regOut):
            wrFile.write("output out_start; ")
        else:
            wrFile.write("output reg out_start; ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        #wrFile.write("reg ["+str(numPipelineStages-1)+":0] in_start_r;      \n  ")
        wrFile.write("\n  ")
        wrFile.write("wire out_start_w; \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireIn ["+str(dp-1)+":0];              \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireOut ["+str(dp-1)+":0];              \n  \n  ")
        ##Connect wireIn with inData
        for i in range(0, dp):
            wrFile.write("assign wireIn["+str(i)+"] = inData_"+str(i)+";    \n  ")
        wrFile.write("\n  ")

        ##Gen log(p,2) stages of switches and wires
        ##Left: switch->wire->switch->wire
        ##Right: wire->switch->wire->switch

        for i in range(0, int(math.log(dp,2))):
            stageIdx = int(math.log(dp,2)) - 1 - i if lOrR == "R" else i
            wrFile.write("wire in_start_stage"+str(stageIdx)+";\n  ")
            ##wires between switch stage and wire connection stage
            wrFile.write("wire con_in_start_stage"+str(stageIdx)+";\n\n  ")


        for i in range(0, int(math.log(dp,2))):
            tmpWireInStr, tmpWireOutStr = "", ""
            stageIdx = int(math.log(dp,2)) - 1 - i if lOrR == "R" else i

            if(lOrR == "L"):
                tmpWireInStr = "wire_con_in_stage"
                tmpWireOutStr = "wire_con_out_stage"
            elif(lOrR == "R"):
                tmpWireInStr = "wire_switch_in_stage"
                tmpWireOutStr = "wire_switch_out_stage"

            wrFile.write("wire [DATA_WIDTH-1:0] "+tmpWireInStr+str(stageIdx)+"["+str(dp-1)+":0];\n  ")
            wrFile.write("wire [DATA_WIDTH-1:0] "+tmpWireOutStr+str(stageIdx)+"["+str(dp-1)+":0];\n  ")
            wrFile.write("wire ["+str(int(dp/2-1))+":0] wire_ctrl_stage"+str(stageIdx)+";\n\n  ")

            #######################
            ##stage of switches
            wrFile.write(swithStageNames[stageIdx])
            ##if(regOutSwitch[stageIdx] == 1): wrFile.write("_r")
            
            wrFile.write(" switch_stage_"+str(stageIdx)+"(\n        ")
            ##FPL16 for reference
            if(lOrR == "L"):
                for j in range(0, dp):  
                    if(stageIdx == 0):   
                        wrFile.write(".inData_"+str(j)+"(wireIn["+str(j)+"]), ")
                    else:
                        wrFile.write(".inData_"+str(j)+"("+tmpWireOutStr+str(stageIdx-1)+"["+str(j)+"]), ")
                wrFile.write("\n        ")
                for j in range(0, dp):
                    wrFile.write(".outData_"+str(j)+"("+tmpWireInStr+str(stageIdx)+"["+str(j)+"]), ")
                wrFile.write("\n        ")
            elif(lOrR == "R"):
                for j in range(0, dp):  
                    wrFile.write(".inData_"+str(j)+"("+tmpWireInStr+str(stageIdx)+"["+str(j)+"]), ")
                wrFile.write("\n        ")
                for j in range(0, dp):
                    if(stageIdx == 0):
                        wrFile.write(".outData_"+str(j)+"(wireOut["+str(j)+"]), ")
                    else:
                        wrFile.write(".outData_"+str(j)+"("+tmpWireOutStr+str(stageIdx)+"["+str(j)+"]), ")
                wrFile.write("\n        ")

            if(lOrR == "L"):
                wrFile.write(".in_start(in_start_stage"+str(stageIdx)+"), ")
                wrFile.write(".out_start(con_in_start_stage"+str(stageIdx)+"), ")
            elif(lOrR == "R"):
                wrFile.write(".in_start(con_in_start_stage"+str(stageIdx)+"), ")
                if(stageIdx == 0):
                    wrFile.write(".out_start(out_start_w), ")
                else:
                    wrFile.write(".out_start(in_start_stage"+str(stageIdx-1)+"), ")
            wrFile.write(".ctrl(wire_ctrl_stage"+str(stageIdx)+"), ")
            wrFile.write(".clk(clk), .rst(rst));\n  ")

            ##########################
            ##stage of wire connection
            wrFile.write("\n  ")
            ##wrFile.write("wireCon_"+str(dp)+"_"+lOrR+"_"+str(stageIdx))
            wrFile.write(wireConStageNames[stageIdx])
            if(regOutWireCon[stageIdx] == 1):
                wrFile.write("_r")
            wrFile.write(" wire_stage_"+str(stageIdx)+"(")
            wrFile.write("\n        ")

            if(lOrR == "R"):
                for j in range(0, dp):  
                    if(stageIdx == int(math.log(dp,2)) - 1):   
                        wrFile.write(".inData_"+str(j)+"(wireIn["+str(j)+"]), ")
                    else:
                        wrFile.write(".inData_"+str(j)+"("+tmpWireOutStr+str(stageIdx+1)+"["+str(j)+"]), ")
                wrFile.write("\n        ")
                for j in range(0, dp):
                    wrFile.write(".outData_"+str(j)+"("+tmpWireInStr+str(stageIdx)+"["+str(j)+"]), ")
                wrFile.write("\n        ")
            elif(lOrR == "L"):
                for j in range(0, dp):  
                    wrFile.write(".inData_"+str(j)+"("+tmpWireInStr+str(stageIdx)+"["+str(j)+"]), ")
                wrFile.write("\n        ")
                for j in range(0, dp):
                    if(stageIdx == int(math.log(dp,2)) - 1):
                        wrFile.write(".outData_"+str(j)+"(wireOut["+str(j)+"]), ")
                    else:
                        wrFile.write(".outData_"+str(j)+"("+tmpWireOutStr+str(stageIdx)+"["+str(j)+"]), ")
                wrFile.write("\n        ")

            if(lOrR == "L"):
                wrFile.write(".in_start(con_in_start_stage"+str(stageIdx)+"), ")
                if(stageIdx == int(math.log(dp,2)) - 1): 
                    wrFile.write(".out_start(out_start_w), ")
                else:
                    wrFile.write(".out_start(in_start_stage"+str(stageIdx+1)+"), ")
            elif(lOrR == "R"):
                wrFile.write(".in_start(in_start_stage"+str(stageIdx)+"), ")
                wrFile.write(".out_start(con_in_start_stage"+str(stageIdx)+"), ")
            wrFile.write(".clk(clk), .rst(rst)); \n\n  ")

            #########################
            ##stage of control roms
            ##For bit reversal, a counter could be used for control
            if g_stride == 0:
                wrFile.write("\n  ")
                if i == 0:
                    wrFile.write("wire ["+str(int(math.log(g_latency,2))-1)+":0] counter_out_w;\n  ")
                    wrFile.write("counter_"+str(g_latency))
                    wrFile.write(" switch_ctrl"+"(")
                    if lOrR == "L":
                        wrFile.write(".in_start(in_start_stage0),")
                    else:
                        wrFile.write(".in_start(in_start_stage"+str(int(math.log(dp,2.0)) - 1)+"),")
                    wrFile.write(" .counter_out(counter_out_w), .clk(clk), .rst(rst));\n\n  ")
                ##i=0, reverse ctrl one time for stageIdx
                for i in range(dp/2):
                    wrFile.write("assign wire_ctrl_stage"+str(stageIdx)+"["+str(i)+"] = counter_out_w["+str(int(math.log(g_latency,2)-stageIdx-1))+"]; \n  ")
            else:
                wrFile.write("\n  ")
                ##wrFile.write("switchCtrl_"+str(dp)+"_"+lOrR+"_"+str(stageIdx))
                wrFile.write(switchesCtrlNames[stageIdx])
                wrFile.write(" switch_ctrl_stage_"+str(stageIdx)+"(")
                tmpStr = ""
                if(lOrR == "L"):
                    # if(stageIdx == 0):
                    #     tmpStr = "in_start"
                    # ##Here assumes stage_w0, stage_w1, stage_w2,...,stage_w(numPipelineStages-1) are pipelined
                    # elif(stageIdx >= numPipelineStages):
                    #     tmpStr = "in_start_r[numPipelineStages - 1]"
                    # else:
                    #     tmpStr = "in_start_r["+str(stageIdx - 1)+"]"
                     wrFile.write(".in_start(in_start_stage"+str(stageIdx)+"),")
                elif(lOrR == "R"):
                    wrFile.write(".in_start(con_in_start_stage"+str(stageIdx)+"),")
                wrFile.write(".ctrl_out(wire_ctrl_stage"+str(stageIdx)+"),")
                wrFile.write(".clk(clk), .rst(rst));\n\n  ")

        wrFile.write("\n  ")
        if(lOrR == "L"):
            wrFile.write("assign in_start_stage0 = in_start;    \n  ")
        else:
            wrFile.write("assign in_start_stage"+ str(int(math.log(dp,2))-1) +" = in_start;    \n  ")

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
            wrFile.write("out_start <= out_start_w;    \n      ")
            wrFile.write("end\n  ")
            wrFile.write("end                              \n")
        else:
            for i in range(0, dp):
                wrFile.write("assign outData_"+str(i)+" = wireOut["+str(i)+"];    \n  ")
            wrFile.write("assign out_start = out_start_w;    \n  ")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")    

    return moduleName
##Generate Egress Stage


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

#dp = 4
#regOutSwitch = []
#regOutWireCon = []
#for i in range(0, int(math.log(dp,2))):
#    a, b = 1, 0
#    regOutSwitch.append(a)
#    regOutWireCon.append(b)

#genStagesBlock("leftBlock.v", dp, "L", 8, regOutSwitch, regOutWireCon, True)
#genStagesBlock("rightBlock.v", dp, "R", 8, regOutSwitch, regOutWireCon, True)

