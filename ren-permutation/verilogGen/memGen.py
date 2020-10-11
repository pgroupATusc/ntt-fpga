#!/usr/bin/python3
#Generate verilog implementation of memory stage in SPN 
#Author: Ren Chen
#Date: Aug/19/2016

import getopt
import sys
import copy
import math
import collections

###A list port names or name prefix
addrRomNamePre = "addr_rom_"
addrRomCtrlModuleName = "addr_rom_ctrl_"
addrMemGenModuleName = "mem_addr_gen_"
addrMemCtrlModuleName = "mem_addr_ctrl_"
memStageName = "mem_stage_dp"
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

#Generate a 1-to-2 switch
def gen1to2Switch(fileName, dataWidth):
    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module switch")
        wrFile.write("_" + str(1))
        wrFile.write("_" + str(2))
        wrFile.write("(\n")

    #Generate multiport names
    genMultiPortName(fileName, 1, "inData", False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    #Generate multiport names
    genMultiPortName(fileName, 2, "outData", False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    
    with open(fileName, 'a') as wrFile:
        wrFile.write("ctrl                            \n")
        wrFile.write(");                              \n  ")
        wrFile.write("parameter DATA_WIDTH = ")
        wrFile.write(str(dataWidth))
        wrFile.write(";                                \n  ")       
        wrFile.write("input ctrl;                   \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] ")

    genMultiPortName(fileName, 1, "inData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("output [DATA_WIDTH-1:0] ")
  
    genMultiPortName(fileName, 2, "outData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireIn ["+str(1-1)+":0];              \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireOut ["+str(2-1)+":0];              \n  \n  ")
        ##Connect wireIn with inData
        for i in range(0, 1):
            wrFile.write("assign wireIn["+str(i)+"] = inData_"+str(i)+";    \n  ")
        wrFile.write("\n  ")
        #Connect wireIn with wireOut
        wrFile.write("assign wireOut[0] = (!ctrl) ? wireIn[0] : 0;    \n  ")
        wrFile.write("assign wireOut[1] = (ctrl) ? wireIn[0] : 0;     \n  ")

        wrFile.write("\n  ")
        for i in range(0, 2):
            wrFile.write("assign outData_"+str(i)+" = wireOut["+str(i)+"];    \n  ")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")


#Generate a 2-to-1 switch
def gen2to1Switch(fileName, dataWidth):
    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module switch")
        wrFile.write("_" + str(2))
        wrFile.write("_" + str(1))
        wrFile.write("(\n")

    #Generate multiport names
    genMultiPortName(fileName, 2, "inData", False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    #Generate multiport names
    genMultiPortName(fileName, 1, "outData", False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    
    with open(fileName, 'a') as wrFile:
        wrFile.write("ctrl                             \n")
        wrFile.write(");                               \n  ")
        wrFile.write("parameter DATA_WIDTH = ")
        wrFile.write(str(dataWidth))
        wrFile.write(";                                \n  ")       
        wrFile.write("input ctrl;                      \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] ")

    genMultiPortName(fileName, 2, "inData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("output [DATA_WIDTH-1:0] ")
  
    genMultiPortName(fileName, 1, "outData", True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireIn ["+str(2-1)+":0];              \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] wireOut ["+str(1-1)+":0];              \n  \n  ")
        ##Connect wireIn with inData
        for i in range(0, 2):
            wrFile.write("assign wireIn["+str(i)+"] = inData_"+str(i)+";    \n  ")
        wrFile.write("\n  ")
        #Connect wireIn with wireOut
        wrFile.write("assign wireOut[0] = (!ctrl) ? wireIn[0] : wireIn[1];    \n  ")

        wrFile.write("\n  ")
        #Connect wireOut with OutData
        for i in range(0, 1):
            wrFile.write("assign outData_"+str(i)+" = wireOut["+str(i)+"];    \n  ")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")


#Generate multi-port names
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


##Generate rom memory for updating memory address
def genAddrRom(fileName, dp, sizeN, addrVec, memIdx):
    vecSize = len(addrVec)  ##vecSize = inpnut size / dp

    romAddrWidth = int(math.ceil(math.log(vecSize, 2.0)))
    dataWidth = romAddrWidth

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module  "+addrRomNamePre+"dp")
        wrFile.write(str(dp))
        wrFile.write("_mem")
        wrFile.write(str(memIdx))
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
        wrFile.write("input ["+str(romAddrWidth-1)+":0] addr;                        \n  ")
        wrFile.write("output reg ["+str(dataWidth-1)+":0] data;        \n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        if(vecSize * dataWidth >= 256 * 16):
            wrFile.write("// synthesis attribute rom_style of data is \"block\" \n  ")
        else:
            wrFile.write("// synthesis attribute rom_style of data is \"distributed\" \n  ")
        wrFile.write("\n  ")
        #Update ctrl_out cycle by cycle
        wrFile.write("always@(posedge clk)             \n  ")
        wrFile.write("begin                            \n    ")
        wrFile.write("if(rst) begin                    \n      ")
        wrFile.write("data <= "+str(dataWidth)+"'b0;    \n      ")
        wrFile.write("end\n    ")
        wrFile.write("else begin                        \n      ")
        wrFile.write("if (en)                           \n        ")
        wrFile.write("case(addr)                        \n          ")
        for i in range(0, vecSize):
            tmpStr = bin(int(i))[2:].zfill(romAddrWidth)
            #tmpDataStr = (convVecToBinStr(addrVec[i]))
            tmpDataStr = bin(addrVec[i])[2:].zfill(dataWidth)
            wrFile.write(str(romAddrWidth)+"'b"+tmpStr+": data <= "+str(dataWidth)+"'b"+tmpDataStr+"; \n          ")
        wrFile.write("default: data <= "+str(dataWidth)+"'b0"+"; \n        ")
        wrFile.write("endcase\n    ")
        wrFile.write("end\n  ")
        wrFile.write("end                              \n")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")  


    return addrRomNamePre+"dp"+ str(dp)+ "_mem"+ str(memIdx)


##Generate control module for addr rom
def genAddrGen(fileName, dp, sizeN, addrVec, perIdx):
    ##vecSize = x * sizeN/dp
    romAddrWidth = []
    for i in range(0,dp):
        vecSize = len(addrVec[i])
        romAddrWidth.append( int(math.ceil(math.log(vecSize, 2.0))) )

    sameSizeMap = {}
    count_tmp = 0
    for i in range(0, dp):
        if romAddrWidth[i] not in sameSizeMap.keys() :
            sameSizeMap[romAddrWidth[i]] = count_tmp
            count_tmp = count_tmp + 1 

    numWireGroup = len(sameSizeMap)
    wireGroupIdx = []
    for i in range(0, dp):
        wireGroupIdx.append(sameSizeMap[romAddrWidth[i]])

    ##ramSize = sizeN/dp
    ramSize = sizeN/dp
    addrRamWidth = int(math.ceil(math.log(ramSize, 2.0)))

    addrRomNames = []
    for memIdx in range(0, dp):
        addrRomNames.append(genAddrRom(fileName, dp, sizeN, addrVec[memIdx], memIdx))

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module  "+addrRomCtrlModuleName+"dp")
        wrFile.write(str(dp))
        wrFile.write("_per")
        wrFile.write(str(perIdx))
        wrFile.write("(\n")
        wrFile.write(inStartPortName+",                          \n")
        wrFile.write("wen_out,                         \n")
        wrFile.write("out_start,                         \n")
        for i in range(0,dp):
            wrFile.write("rom_out_"+str(i)+",                         \n")
        wrFile.write("clk,                             \n")
        wrFile.write("rst                              \n")
        wrFile.write(");                               \n  ")
        #wrFile.write("parameter DATA_WIDTH = ")
        #wrFile.write(str(dataWidth))
        #wrFile.write(";                                \n  ")       
        wrFile.write("input "+inStartPortName+", clk, rst;                   \n  ")
        for i in range(0,dp):
            wrFile.write("output ["+str(romAddrWidth[i]-1)+":0] rom_out_"+str(i)+";            \n  ")
        wrFile.write("output wen_out;\n  output out_start;\n  ")
        wrFile.write("\n  ")
        for i in range(0,numWireGroup):
            wrFile.write("reg ["+str(sameSizeMap.keys()[i]-1)+":0] rom_addr_"+str(i)+";        \n  ")
        wrFile.write("reg [1:0] state;        \n  ")
        wrFile.write("\n  ")
        for i in range(0,dp):
            wrFile.write(addrRomNames[i] +  " addr_rom_inst_" +  str(i) + "(.en(1'b1),.clk(clk),.rst(rst),"
                         + ".addr(rom_addr_"+str(sameSizeMap[romAddrWidth[i]])+"),.data(rom_out_"+str(i)+")); \n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("assign wen_out = state[0];        \n  ")
        ##when the rom addr = 0, 4, out_start = 1, when max_rom_addr = 7
        wrFile.write("assign out_start = (state == 2'b01) && (rom_addr_0["+str(addrRamWidth-1)+":0] == {"+str(addrRamWidth)+"{1'b0}}); \n"  ) 
        wrFile.write("\n  ")
        #Update ctrl_out cycle by cycle
        wrFile.write("always@(posedge clk)             \n  ")
        wrFile.write("begin                            \n    ")
        wrFile.write("if(rst) begin                    \n      ")
        for i in range(0, numWireGroup):
            wrFile.write("rom_addr_"+str(i)+" <= "+str(sameSizeMap.keys()[i])+"'b0;    \n      ")
        wrFile.write("state <= 1'b0;            \n      ")
        wrFile.write("end\n    ")
        wrFile.write("else begin                        \n      ")
        ##Make sure in_start has been registered
        wrFile.write("case (state)              \n        ")
        wrFile.write("2'b00: begin              \n          ")
        for i in range(0, numWireGroup):    
            wrFile.write("rom_addr_"+str(i)+" <= "+str(sameSizeMap.keys()[i])+"'b0;   \n          ")
        wrFile.write("if ("+inStartPortName+")  begin              \n            ")
        wrFile.write("state <= 2'b01;              \n            ")
        for i in range(0, numWireGroup):    
            wrFile.write("rom_addr_"+str(i)+" <= rom_addr_"+str(i)+" + 1;    \n          ")
        wrFile.write("end\n        ")
        wrFile.write("end\n        ")
        wrFile.write("2'b01: begin              \n          ")
        for i in range(0, numWireGroup):    
            wrFile.write("rom_addr_"+str(i)+" <= rom_addr_"+str(i)+" + 1;    \n          ")
        wrFile.write("if (rom_addr_0 == {"+str(addrRamWidth)+"{1'b0}})  begin \n            ")
        wrFile.write("state <= 2'b11;              \n          ")
        wrFile.write("end\n        ")
        wrFile.write("end\n        ")
        wrFile.write("2'b11: begin              \n          ")
        for i in range(0, numWireGroup):    
            wrFile.write("rom_addr_"+str(i)+" <= rom_addr_"+str(i)+" + 1;    \n          ")
        wrFile.write("if ("+inStartPortName+")  begin              \n            ")
        wrFile.write("state <= 2'b01;              \n          ")
        wrFile.write("end\n          ")
        wrFile.write("else if (rom_addr_0 == {"+str(addrRamWidth)+"{1'b0}})  begin \n            ")
        wrFile.write("state <= 2'b00;              \n          ")
        wrFile.write("end\n        ")
        wrFile.write("end\n        ")
        wrFile.write("default: state <= 2'b00;       \n      ")
        wrFile.write("endcase\n    ")
        wrFile.write("end\n  ")
        wrFile.write("end                              \n")
        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")    

    return addrRomCtrlModuleName+"dp"+str(dp)+"_per"+str(perIdx)


def genTopMemAddr(fileName, dp, sizeN, addrVec, perIdx, memIdx):
    assert(len(addrVec) == sizeN/dp)
    addrWidth = int(math.ceil(math.log(sizeN/dp, 2.0)))
    width_a_0 = int(math.ceil(math.log(dp, 2.0))) if int(math.ceil(math.log(dp, 2.0))) < addrWidth else addrWidth
    width_a_1 = (addrWidth - width_a_0) % 4 if addrWidth > width_a_0 else 0
    width_a_2 = (addrWidth - width_a_0 - width_a_1)

    word_width = 4
    num_words = width_a_2/4 
    is_valid_ms_word_high = (width_a_0 > 0)
    only_use_a0 = (width_a_1 == 0)
    num_cycles_per_update = [0 for i in range(num_words)]  ##ms_word: most significant word
    ncpu_addr_a1, ncpu_addr_a0 = 0, 0   ##ncpu: number of cycles pere update

    ##ms_word_high -> no bit rev, others -> bit rev
    ##calculate num_cycles_per_update for the least significant words
    ##width of ms_word_high = log(dp,2)
    offset = width_a_0 + width_a_1
    if num_words >= 1:
        init_val = [bin(addrVec[0])[2:].zfill(addrWidth)[offset+i*word_width:offset+(i+1)*word_width-1]   \
                      for i in range(num_words)]
        for j in range(1, len(addrVec)):
            val = [bin(addrVec[j])[2:].zfill(addrWidth)[offset+i*word_width:offset+(i+1)*word_width-1]    \
                      for i in range(num_words)]
            for k in range(num_words):
                if (val[k] != init_val[k]) and num_cycles_per_update[k] == 0:
                    num_cycles_per_update[k] = j

    ##calculate num_cycles_per_update for the most significant word
    ##!!!Needs to update, here we assume addrWidth = 2*constant
    start = 0
    end_a0 = width_a_0
    end_a1 = width_a_0 + width_a_1
    ##4'b1100  high: 11, low: 00
    init_val_a0 = bin(addrVec[0])[2:].zfill(addrWidth)[start: end_a0]
    init_val_a1 = bin(addrVec[0])[2:].zfill(addrWidth)[end_a0: end_a1]
    for j in range(1, len(addrVec)):
        val_a0 = bin(addrVec[j])[2:].zfill(addrWidth)[start: end_a0]
        val_a1 = bin(addrVec[j])[2:].zfill(addrWidth)[end_a0: end_a1]
        if (val_a0 != init_val_a0) and ncpu_addr_a0 == 0:
                ncpu_addr_a0 = j
        if (val_a1 != init_val_a1) and ncpu_addr_a1 == 0:
                ncpu_addr_a1 = j
                

    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module  "+addrMemGenModuleName+"dp")
        wrFile.write(str(dp))
        wrFile.write("_mem"+str(memIdx))
        wrFile.write("_per"+str(perIdx))
        wrFile.write("(\n")
        ##bit width = addrWidth
        wrFile.write("counter_in,                              \n")
        wrFile.write("clk,                             \n")
        wrFile.write("rst,                             \n")
        wrFile.write("addr_out                            \n")
        wrFile.write(");                               \n  ")     
        wrFile.write("input clk, rst;                           \n  ")
        wrFile.write("input ["+str(addrWidth-1)+":0] counter_in;      \n  ")
        wrFile.write("output ["+str(addrWidth-1)+":0] addr_out;      \n\n  ")


        ##wrFile.write("wire ["+str(addrWidth-1)+":0] addr_out_w;      \n  ")
        if num_words >= 1:
            ##wrFile.write("reg ["+str(word_width-1)+":0] word_counter ["+str(num_words-2)+":0];      \n  ")
            wrFile.write("wire ["+str(word_width-1)+":0] word_counter_w ["+str(num_words-1)+":0];      \n  ")
        if not only_use_a0:
            ##wrFile.write("reg ["+str(word_width/2-1)+":0] ms_word_high;      \n  ")
            wrFile.write("wire ["+str(width_a_1-1)+":0] addr_a1;      \n  ")
        ##wrFile.write("reg ["+str(word_width/2-1)+":0] ms_word_low;      \n  ")
        wrFile.write("wire ["+str(width_a_0-1)+":0] addr_a0;      \n  ")

        if num_words >= 1:
            for i in range(num_words):
                start = i*word_width
                end = (i+1)*word_width
                ##Note here the index is not i
                str_r = ["word_counter_w["+str(num_words-1-i)+"]["+str(j)+"]" for j in range(word_width)]
                wrFile.write("assign addr_out["+str(end-1)+":"+str(start)+"] = {"+','.join(str_r)+"};    \n  ")
        
        ##wrFile.write("assign addr_a0 = ms_word_low;    \n  ")
        if not only_use_a0:
            str_r = ["addr_a1["+str(i)+"]" for i in range(width_a_1)]
            start = word_width*num_words
            end = start + width_a_1
            wrFile.write("assign addr_out["+str(end-1)+":"+str(start)+"] = {"+','.join(str_r)+"};   \n  ")
        
        start = word_width*num_words+width_a_1
        end = addrWidth
        wrFile.write("assign addr_out["+str(end-1)+":"+str(start)+"] = addr_a0["+str(width_a_0-1)+":0];   \n  ")


    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        if num_words >= 1:
            for i in range(num_words):
                bit = int(math.ceil(math.log(num_cycles_per_update[i], 2.0)))
                wrFile.write("assign word_counter_w["+str(i)+"] = counter_in["+str(word_width+bit-1)+":"+str(bit)+"];  \n  ")
    
        #to update most significant word lower two bits
        #print "ncpu_addr_a0: ",ncpu_addr_a0
        #print "g_n, g_p", sizeN, dp

        bit_ms_word_a0 = int(math.ceil(math.log(ncpu_addr_a0, 2.0)))
        wrFile.write("assign addr_a0 = counter_in["+str(bit_ms_word_a0+width_a_0-1)+":"+str(bit_ms_word_a0)+"]; \n  ")
        
        if not only_use_a0:
            bit_ms_word_a1 = int(math.ceil(math.log(ncpu_addr_a1, 2.0)))
            wrFile.write("assign addr_a1 = counter_in["+str(bit_ms_word_a1+width_a_1-1)+":"+str(bit_ms_word_a1)+"]; \n    ")
        wrFile.write("\n")

    ##with open(fileName, 'a') as wrFile:
    ##    wrFile.write("\n  ")
    ##    #Update ctrl_out cycle by cycle
    ##    wrFile.write("always@(posedge clk)             \n  ")
    ##    wrFile.write("begin                            \n    ")
    ##    wrFile.write("if(rst) begin                    \n      ")
    ##    if num_words >= 2:
    ##        for i in range(num_words-1):
    ##            wrFile.write("word_counter["+str(i)+"] <= "+str(word_width)+"'b0;    \n      ")
    ##    wrFile.write("ms_word_low <= "+str(word_width/2)+"'b0;    \n      ")
    ##    if not only_use_a0:
    ##        wrFile.write("ms_word_high <= "+str(word_width/2)+"'b0;    \n      ")
    ##    wrFile.write("end\n    ")
    ##    wrFile.write("else begin                        \n      ")
    ##    if num_words >= 2:
    ##        for i in range(num_words-1):
    ##            bit = int(math.ceil(math.log(num_cycles_per_update[i], 2.0)))
    ##            wrFile.write("word_counter["+str(i)+"] <= (counter_in["+str(bit-1)+":0] == {"+str(bit)+"{1'b1}}) + word_counter["+str(i)+"];  \n      ")
    ##
    ##    bit_ms_word_l = int(math.ceil(math.log(ncpu_addr_a0, 2.0)))
    ##    bit_ms_word_h = int(math.ceil(math.log(ncpu_addr_a1, 2.0)))
    ##    if ncpu_addr_a0 > 1:
    ##        wrFile.write("ms_word_low <= (counter_in["+str(bit_ms_word_l-1)+":0] == {"+str(bit_ms_word_l)+"{1'b1}}) + ms_word_low; \n      ")
    ##    else:
    ##        wrFile.write("ms_word_low <= counter_in["+str(word_width/2-1)+":0];   \n      ")
    ##    if not only_use_a0:
    ##        if ncpu_addr_a1 > 1:
    ##            wrFile.write("ms_word_high <= (counter_in["+str(bit_ms_word_h-1)+":0] == {"+str(bit_ms_word_h)+"{1'b1}}) + ms_word_high; \n      ")
    ##        else:
    ##            wrFile.write("ms_word_high <= counter_in["+str(word_width/2-1)+":0];   \n      ")
    ##    wrFile.write("end\n  ")
    ##    wrFile.write("end                              \n")
    ##    wrFile.write("\n")


        wrFile.write("endmodule                        \n\n")  

    return addrMemGenModuleName+"dp"+ str(dp)+ "_mem"+ str(memIdx) + "_per" + str(perIdx)


##Generate optimized control module for addr rom
##Specifically for bit reversal only
def genAddrAutoGen(fileName, dp, sizeN, addrVec, perIdx):
    ##vecSize = x * sizeN/dp
    addrWidth = int(math.ceil(math.log(sizeN/dp, 2.0)))
    rawAddrVec = [[addrVec[i][j] for j in range(sizeN/dp)] for i in range(len(addrVec))]
    log2dp = int(math.ceil(math.log(dp,2)))

    ##Generate top memory addr gen module
    topMemAddrGenName = genTopMemAddr(fileName, dp, sizeN, rawAddrVec[0], perIdx, 0)

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module  "+addrMemCtrlModuleName+"dp")
        wrFile.write(str(dp))
        wrFile.write("_per"+str(perIdx))
        wrFile.write("(\n")
        wrFile.write(inStartPortName+",                          \n")
        wrFile.write("counter_in,                         \n")
        wrFile.write("wen_out,                         \n")
        wrFile.write("out_start,                         \n")
        for i in range(0,dp):
            wrFile.write("mem_addr_out_"+str(i)+",                         \n")
        wrFile.write("clk,                             \n")
        wrFile.write("rst                              \n")
        wrFile.write(");                               \n  ")
        #wrFile.write("parameter DATA_WIDTH = ")
        #wrFile.write(str(dataWidth))
        #wrFile.write(";                                \n  ")       
        wrFile.write("input "+inStartPortName+", clk, rst;                   \n  ")
        wrFile.write("input ["+str(addrWidth-1)+":0] counter_in; \n  ")
        for i in range(0,dp):
            wrFile.write("output ["+str(addrWidth-1)+":0] mem_addr_out_"+str(i)+";            \n  ")
        wrFile.write("output wen_out;\n  output reg out_start;\n  ")
        wrFile.write("\n  ")
        
        #wrFile.write("reg ["+str(addrWidth-1)+":0] counter;        \n  ")
        wrFile.write("reg [1:0] state;        \n  ")
        wrFile.write("reg flag;        \n\n  ")

        for i in range(0,dp):
            wrFile.write("wire ["+str(addrWidth-1)+":0] mem_addr_out_tmp_"+str(i)+";   \n  ")
        wrFile.write("wire ["+str(addrWidth-1)+":0] mem_addr_out_w;        \n  ")

        ##Case 1: 
        if addrWidth >= log2dp:
            wrFile.write("wire ["+str(log2dp-1)+":0] mem_addr_out_w_h;        \n  ")
        else:
            wrFile.write("wire ["+str(1-1)+":0] mem_addr_out_w_h;        \n  ")

        ##make sure addr width greater than log2dp
        if addrWidth > log2dp:
            wrFile.write("wire ["+str(addrWidth-log2dp-1)+":0] mem_addr_out_w_l;        \n  ")
        wrFile.write("\n  ")

        wrFile.write(topMemAddrGenName +  " top_mem_addr_gen_inst (.clk(clk),.rst(rst),"
                         + ".addr_out(mem_addr_out_w), .counter_in(counter_in)); \n\n  ")

        if addrWidth >= log2dp:
            wrFile.write("assign mem_addr_out_w_h = mem_addr_out_w["+str(addrWidth-1) +  ":" +   \
                                                str(addrWidth-log2dp) + "];        \n  ")
        else:
            wrFile.write("assign mem_addr_out_w_h = mem_addr_out_w[0:0];        \n  ")

        if addrWidth > log2dp:
            wrFile.write("assign mem_addr_out_w_l = mem_addr_out_w["+str(addrWidth-log2dp-1) + ":0];   \n  ")

        ##Case 1:
        ##Mem block 0, addr: 0 1 2 3
        ##Mem block 1, addr: 1 0 3 2
        ##Mem block 2, addr: 2 3 0 1
        ##Mem blovk 3, addr: 3 2 1 0
        ##Case 2:
        ##Mem block 0, addr: 0 1 
        ##Mem block 1, addr: 0 1 
        ##Mem block 2, addr: 1 0 
        ##Mem blovk 3, addr: 1 0 
        
        ##Case 1:
        if addrWidth >= log2dp:
            for i in range(0,dp):
                bin_width = log2dp
                vec_i = list(bin(i)[2:].zfill(bin_width))
                str_i = list()
                for j in range(len(vec_i))[::-1]:
                    new_bit = "~mem_addr_out_w_h["+str(j)+"]" if vec_i[len(vec_i)-1-j]=='1' else "mem_addr_out_w_h["+str(j)+"]" 
                    str_i.append(new_bit)
                if addrWidth > log2dp:
                    str_i.append("mem_addr_out_w_l")
                wrFile.write("assign mem_addr_out_tmp_"+str(i)+" = {"+','.join(str_i)+"}; \n  ")
        ##Case 2:
        else:
            cycle_num = 2**(log2dp - addrWidth)
            bin_width = addrWidth
            for i in range(0, dp/cycle_num):
                for k in range(cycle_num):
                    vec_i = list(bin(i)[2:].zfill(bin_width))
                    str_i = list()
                    for j in range(len(vec_i))[::-1]:
                        new_bit = "~mem_addr_out_w["+str(j)+"]" if vec_i[len(vec_i)-1-j]=='1' else "mem_addr_out_w["+str(j)+"]" 
                        str_i.append(new_bit)
                    wrFile.write("assign mem_addr_out_tmp_"+str(i*cycle_num+k)+" = {"+','.join(str_i)+"}; \n  ")


        for i in range(0,dp):
             wrFile.write("assign mem_addr_out_"+str(i)+" = ((flag == 1'b0) ? mem_addr_out_tmp_"+str(i)+" : counter_in); \n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("assign wen_out = state[0];        \n  ")
        ##when the rom addr = 0, 4, out_start = 1, when max_rom_addr = 7
        wrFile.write("always@(posedge clk)             \n  ")
        wrFile.write("begin                            \n    ")
        wrFile.write("if(rst) begin                    \n      ")
        wrFile.write("out_start <= 1'b0; \n"  ) 
        wrFile.write("end\n    ")
        wrFile.write("else begin                        \n      ")
        wrFile.write("out_start <= (state == 2'b01) && (counter_in["+str(addrWidth-1)+":0] == {"+str(addrWidth)+"{1'b1}}); \n"  ) 
        wrFile.write("end                              \n")
        wrFile.write("end                              \n")
        wrFile.write("\n  ")
        #Update ctrl_out cycle by cycle
        wrFile.write("always@(posedge clk)             \n  ")
        wrFile.write("begin                            \n    ")
        wrFile.write("if(rst) begin                    \n      ")
        #wrFile.write("counter <= "+str(addrWidth)+"'b0;      \n      ")
        wrFile.write("state <= 2'b0;            \n      ")
        wrFile.write("flag <= 1'b0;            \n      ")
        wrFile.write("end\n    ")
        wrFile.write("else begin                        \n      ")
        ##Make sure in_start has been registered
        wrFile.write("case (state)              \n        ")
        wrFile.write("2'b00: begin              \n          ") 
        #wrFile.write("counter <= "+str(addrWidth)+"'b0;      \n          ")
        wrFile.write("if ("+inStartPortName+")  begin              \n            ")
        wrFile.write("state <= 2'b01;              \n            ")
        wrFile.write("end\n        ")
        wrFile.write("end\n        ")
        wrFile.write("2'b01: begin              \n          ")
        #wrFile.write("counter <= counter + 1'b1;       \n          ")
        wrFile.write("if (!in_start && counter_in == {"+str(addrWidth)+"{1'b1}})  begin \n            ")
        wrFile.write("state <= 2'b11;              \n          ")
        wrFile.write("end\n          ")
        wrFile.write("if (counter_in == {"+str(addrWidth)+"{1'b1}})  begin \n            ")
        wrFile.write("flag <= !flag;              \n          ")
        wrFile.write("end\n        ")
        wrFile.write("end\n        ")
        wrFile.write("2'b11: begin              \n          ")
        #wrFile.write("counter <= counter + 1'b1;       \n          ")
        wrFile.write("if (counter_in == {"+str(addrWidth)+"{1'b1}})  begin \n            ")
        wrFile.write("state <= 2'b00;              \n          ")
        wrFile.write("end\n        ")
        wrFile.write("end\n        ")
        wrFile.write("default: state <= 2'b00;       \n      ")
        wrFile.write("endcase\n    ")
        wrFile.write("end\n  ")
        wrFile.write("end                              \n")
        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")    

    return addrMemCtrlModuleName+"dp"+str(dp)+"_per"+str(perIdx)


def convVecToBinStr(vecIn):
    size = len(vecIn)
    tmpStr = ""
    ##reverse the order
    for i in range(size-1, -1, -1):
        tmpStr += str(vecIn[i])
    return tmpStr


##Generate memory blocks in the middle stage
##SP: single port RAM
def genDataSPRam(fileName, dp, sizeN, dataWidth, ramStyle):
    memSize = sizeN / dp
    addrWidth = int(math.ceil(math.log(memSize, 2.0)))

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module  "+ramStyle)
        wrFile.write("(\n")
        wrFile.write("wen,                              \n")
        if(ramStyle == "block_ram_sp"):
            wrFile.write("en,                              \n")
        wrFile.write("clk,                             \n")
        wrFile.write("addr,                            \n")
        wrFile.write("din,                            \n")
        wrFile.write("dout                             \n")
        wrFile.write(");                               \n  ")
        wrFile.write("parameter DATA_WIDTH = ")
        wrFile.write(str(dataWidth))
        wrFile.write(";                                \n  ")    
        wrFile.write("parameter ADDR_WIDTH = ")
        wrFile.write(str(addrWidth))
        wrFile.write(";                                \n  ")     
        wrFile.write("parameter RAM_SIZE = 1 << ADDR_WIDTH")
        wrFile.write(";                                \n  ")      
        wrFile.write("input wen, clk;                   \n  ")
        if(ramStyle == "block_ram_sp"):
            wrFile.write("input en;                              \n  ")
        wrFile.write("input [ADDR_WIDTH-1:0] addr;                        \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] din;                        \n  ")
        wrFile.write("output ")
        if(ramStyle == "block_ram_sp"):
            wrFile.write("reg ")
        wrFile.write("[DATA_WIDTH-1:0] dout;        \n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("reg [DATA_WIDTH-1:0] ram[RAM_SIZE-1:0];        \n  ")
        wrFile.write("\n  ")
        #Update ctrl_out cycle by cycle
        wrFile.write("always@(posedge clk)             \n  ")
        wrFile.write("begin                            \n    ")
        if(ramStyle == "block_ram_sp"):
            wrFile.write("// synthesis attribute ram_style of ram is \"block\" \n  ")
            wrFile.write("if(en) begin                    \n      ")
            wrFile.write("if(wen)                         \n        ")
            wrFile.write("ram[addr] <= din ;              \n      ")
            wrFile.write("dout <= ram[addr];              \n  ")
            wrFile.write("end\n  ")
            wrFile.write("end                             \n  ")
        elif(ramStyle == "dist_ram_sp"):
            wrFile.write("// synthesis attribute ram_style of ram is \"distributed\" \n  ")
            wrFile.write("if(wen)                         \n      ")
            wrFile.write("ram[addr] <= din ;              \n  ")
            wrFile.write("end                             \n \n  ")
            wrFile.write("assign dout = ram[addr];         \n  ")


        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")


#Generate dual-port ram
def genDataDPRam(fileName, dp, sizeN, dataWidth, ramStyle):
    memSize = sizeN / dp
    addrWidth = int(math.ceil(math.log(memSize, 2.0)))

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")                    
        wrFile.write("module  "+ramStyle)
        wrFile.write("(\n")
        wrFile.write("wen,                              \n")
        if(ramStyle == "block_ram_dp"):
            wrFile.write("en,                              \n")
        wrFile.write("clk,                             \n")
        wrFile.write("addr_r,                            \n")
        wrFile.write("addr_w,                            \n")
        wrFile.write("din,                            \n")
        wrFile.write("dout                             \n")
        wrFile.write(");                               \n  ")
        wrFile.write("parameter DATA_WIDTH = ")
        wrFile.write(str(dataWidth))
        wrFile.write(";                                \n  ")    
        wrFile.write("parameter ADDR_WIDTH = ")
        wrFile.write(str(addrWidth))
        wrFile.write(";                                \n  ")     
        wrFile.write("parameter RAM_SIZE = 1 << ADDR_WIDTH")
        wrFile.write(";                                \n  ")      
        wrFile.write("input wen, clk;                   \n  ")
        if(ramStyle == "block_ram_dp"):
            wrFile.write("input en;                              \n  ")
        wrFile.write("input [ADDR_WIDTH-1:0] addr_r;                        \n  ")
        wrFile.write("input [ADDR_WIDTH-1:0] addr_w;                        \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] din;                        \n  ")
        wrFile.write("output ")
        if(ramStyle == "block_ram_dp"):
            wrFile.write("reg ")
        wrFile.write("[DATA_WIDTH-1:0] dout;        \n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("reg [DATA_WIDTH-1:0] ram[RAM_SIZE-1:0];        \n  ")
        wrFile.write("\n  ")
        #Update ctrl_out cycle by cycle
        wrFile.write("always@(posedge clk)             \n  ")
        wrFile.write("begin                            \n    ")
        if(ramStyle == "block_ram_dp"):
            wrFile.write("// synthesis attribute ram_style of ram is \"block\" \n  ")
            wrFile.write("if(en) begin                    \n      ")
            wrFile.write("if(wen)                         \n        ")
            wrFile.write("ram[addr_w] <= din ;              \n      ")
            wrFile.write("dout <= ram[addr_r];              \n  ")
            wrFile.write("end\n  ")
            wrFile.write("end                             \n  ")
        elif(ramStyle == "dist_ram_dp"):
            wrFile.write("// synthesis attribute ram_style of ram is \"distributed\" \n  ")
            wrFile.write("if(wen)                         \n      ")
            wrFile.write("ram[addr_w] <= din ;              \n  ")
            wrFile.write("end                             \n \n  ")
            wrFile.write("assign dout = ram[addr_r];         \n  ")


        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")



def getPortStyle(dp, sizeN, addrVec):
    portStyle = []
    incVec = [i for i in range(sizeN/dp)]
    for vec in addrVec:
        if(len(vec) > sizeN/dp or vec==incVec):
            portStyle.append("sp")
        elif (len(vec) == sizeN/dp):
            portStyle.append("sp")
        else:
            portStyle.append("sp")
    return portStyle

##Generate memory stage
def genMemStage(fileName, dp, sizeN, stride, dataWidth, addrVec, regOut, perIdx):
    ##max size of data buffers
    maxMemSize = sizeN/dp
    maxWidth = int(math.ceil(math.log(maxMemSize, 2.0)))
    memSize = []; addrWidth = []

    for i in range(dp):
        ##s = len(addrVec[i])%maxMemSize if len(addrVec[i])<maxMemSize else len(addrVec[i])
        memSize.append(maxMemSize)
        addrWidth.append(int(math.ceil(math.log(memSize[-1], 2.0))))

    ##Here mem size could be half of maxMemSize
    ##for i in range(dp):
    ##    s = len(addrVec[i])%maxMemSize if len(addrVec[i])<maxMemSize else len(addrVec[i])
    ##    memSize.append(s)
    ##    addrWidth.append(int(math.ceil(math.log(memSize[-1], 2.0))))

    moduleName = ""
    ##Use addr vecotors to decide RAM port style
    portStyle = getPortStyle(dp, sizeN, addrVec)

    ##some rams could share counters for addr update
    #counterModuleName = [] ##collections.defaultdict(list)
    #for i in range(dp):
    #    if "counter_"+str(memSize[i]) in counterModuleName:
    #        counterModuleName.append("counter_"+str(memSize[i]) )
    #    else:
    #        counterModuleName.append(genCounter(fileName, memSize[i]))

    #addrGenModuleName = []
    #for memIdx in range(0, dp):
    if stride != 0:
        addrGenModuleName = genAddrGen(fileName, dp, sizeN, addrVec, perIdx)
    else:
        addrGenModuleName = genAddrAutoGen(fileName, dp, sizeN, addrVec, perIdx)

    ##Generate address generator modules
    #for memIdx in range(0, dp):
    #    genAddrGen(fileName, dp, sizeN, addrVec[memIdx], memIdx)

    #Gen connection module
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n")   
        moduleName = memStageName + str(dp) ##??+  
        if(regOut):
            moduleName += "_r"     
        wrFile.write("module "+moduleName)
        wrFile.write("(\n")

    #Generate multiport names
    genMultiPortName(fileName, dp, inDataNamePre, False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")
    #Generate multiport names
    genMultiPortName(fileName, dp, outDataNamePre, False)
    with open(fileName, 'a') as wrFile:
        wrFile.write(",\n")

    with open(fileName, 'a') as wrFile:
        wrFile.write(inStartPortName+",                        \n")
        wrFile.write(outStartPortName+",                       \n")
        #wrFile.write("ctrl,                            \n")
        #for i in range(0,dp):
        #    wrFile.write(inDataNamePre+str(i)+",                       \n")
        #for i in range(0,dp):
        #    wrFile.write(outDataNamePre+str(i)+",                       \n")
        wrFile.write("clk,                             \n")
        wrFile.write("counter_in,                             \n")
        wrFile.write("rst                              \n")
        wrFile.write(");                               \n  ")
        wrFile.write("parameter DATA_WIDTH = ")
        wrFile.write(str(dataWidth))
        wrFile.write(";                                \n  ")       
        wrFile.write("input "+inStartPortName+", clk, rst;                   \n  ")
        wrFile.write("input ["+str(maxWidth)+"-1:0] counter_in;        \n  ")
        wrFile.write("input [DATA_WIDTH-1:0] ")

    ##input ports
    genMultiPortName(fileName, dp, inDataNamePre, True)
    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")

    with open(fileName, 'a') as wrFile:
        if(not regOut):
            wrFile.write("output [DATA_WIDTH-1:0] ")
        else:
            wrFile.write("output reg [DATA_WIDTH-1:0] ")

    ##output ports
    genMultiPortName(fileName, dp, outDataNamePre, True)

    with open(fileName, 'a') as wrFile:
        wrFile.write(";\n  ")
        if(not regOut):
            wrFile.write("output "+outStartPortName+"; ")
        else:
            wrFile.write("output reg "+outStartPortName+"; ")
        wrFile.write("\n  ")

    ##Wires
    with open(fileName, 'a') as wrFile:
        wrFile.write("\n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] "+wireInName+" ["+str(dp-1)+":0];              \n  ")
        wrFile.write("wire [DATA_WIDTH-1:0] "+wireOutName+" ["+str(dp-1)+":0];              \n  \n  ")
        wrFile.write("wire wen_wire;              \n  ")
        wrFile.write("wire out_start_wire;              \n  ")
        ##Connect wireIn with inData
        for i in range(0, dp):
            wrFile.write("assign "+wireInName+"["+str(i)+"] = "+inDataNamePre+"_"+str(i)+";    \n  ")
        wrFile.write("\n  ")

    with open(fileName, 'a') as wrFile:
        for i in range(0, dp):
            if(portStyle[i] == "sp"):
                wrFile.write("wire ["+str(addrWidth[i]-1)+":0] addr_wire_"+str(i)+";        \n\n  ")
            elif(portStyle[i] == "dp"):
                wrFile.write("wire ["+str(addrWidth[i]-1)+":0] addr_w_wire_"+str(i)+";        \n\n  ")
        if "dp" in portStyle:
            ##??only one write_addr, several read_addr?
            wrFile.write("wire ["+str(addrWidth[i]-1)+":0] addr_r_wire_"+str(0)+";        \n\n  ")
            #wrFile.write("wire wen_wire_"+str(i)+";        \n\n  ")
            ##Generate counter module
            #wrFile.write(counterModuleName[i]+" counter_inst(")
            #wrFile.write("."+inStartPortName+"("+inStartPortName+"), ")
            #wrFile.write(".counter_out(addr_r_wire_0), ")
            #wrFile.write(".clk(clk), .rst(rst));\n\n  ")
            wrFile.write("assign addr_r_wire_"+str(0)+" = counter_in;        \n\n  ")


    with open(fileName, 'a') as wrFile:
        ##Gen several memory blocks
        ramStyle = ""
        if (((sizeN/dp) * dataWidth) >= 256*16):
            ramStyle = "block_ram_"
        else:
            ramStyle = "dist_ram_"
        ##ramStyle += portStyle 

        ##Generate ram address generator module
        wrFile.write(addrGenModuleName+" addr_gen_inst(")
        wrFile.write("."+inStartPortName+"("+inStartPortName+"), ")
        wrFile.write(".counter_in(counter_in), ")
        wrFile.write(".wen_out(wen_wire), ")
        wrFile.write(".out_start(out_start_wire), ")
        if stride != 0:
            for i in range(0,dp):
                if(portStyle[i] == "sp"):
                    wrFile.write(".rom_out_"+str(i)+"(addr_wire_"+str(i)+"), ")
                elif(portStyle[i] == "dp"):
                    wrFile.write(".rom_out_"+str(i)+"(addr_w_wire_"+str(i)+"), ")
        else:
            for i in range(0,dp):
                wrFile.write(".mem_addr_out_"+str(i)+"(addr_wire_"+str(i)+"), ")
        wrFile.write(".clk(clk), .rst(rst));\n\n  ")

    ##Generate dp/2 memory instances
    with open(fileName, 'a') as wrFile:
        for i in range(0, dp):
            ramModuleName = ramStyle + portStyle[i]
            if(portStyle[i] == "sp"):
                ##Generate single-port memory blocks
                wrFile.write(ramModuleName+" #(")
                wrFile.write(".DATA_WIDTH("+str(dataWidth)+"), ")
                wrFile.write(".ADDR_WIDTH("+str(addrWidth[i])+")) \n        ")
                wrFile.write(" ram_inst_"+str(i)+"(")
                wrFile.write(".wen(wen_wire), ")
                if(ramModuleName == "block_ram_sp"):
                    wrFile.write(".en(1'b1), ")
                wrFile.write(".addr(addr_wire_"+str(i)+"), ")
                wrFile.write(".din("+wireInName+"["+str(i)+"]), ")
                wrFile.write(".dout("+wireOutName+"["+str(i)+"]), ")
                wrFile.write(".clk(clk) );\n\n  ")
                
            elif(portStyle[i] == "dp"):
                wrFile.write(ramModuleName+" #(")
                wrFile.write(".DATA_WIDTH("+str(dataWidth)+"), ")
                wrFile.write(".ADDR_WIDTH("+str(addrWidth[i])+")) \n        ")
                wrFile.write(" ram_inst_"+str(i)+"(")
                wrFile.write(".wen(wen_wire), ")
                if(ramModuleName == "block_ram_dp"):
                    wrFile.write(".en(1'b1), ")
                wrFile.write(".addr_r(addr_r_wire_"+str(0)+"), ")
                wrFile.write(".addr_w(addr_w_wire_"+str(i)+"), ")
                wrFile.write(".din("+wireInName+"["+str(i)+"]), ")
                wrFile.write(".dout("+wireOutName+"["+str(i)+"]), ")
                wrFile.write(".clk(clk) );\n\n  ")


        wrFile.write("\n  ")
        #Connect wireOut with OutData
        # wrFile.write("reg wen_out_r; \n\n  ")
        # wrFile.write("always@(posedge clk)             \n  ")
        # wrFile.write("begin                            \n    ")
        # wrFile.write("wen_out_r <=  wen_wire           \n  ")
        # wrFile.write("end                            \n\n  ")

        if(regOut):
            wrFile.write("always@(posedge clk)             \n  ")
            wrFile.write("begin                            \n    ")
            wrFile.write("if(rst) begin                    \n      ")
            for i in range(0, dp):
                wrFile.write(outDataNamePre+"_"+str(i)+" <= 0;    \n      ")
            wrFile.write(outStartPortName+" <= 1'b0;              \n      ")
            wrFile.write("end\n    ")
            wrFile.write("else begin                        \n      ")
            for i in range(0, dp):
                wrFile.write(outDataNamePre+"_"+str(i)+" <= "+wireOutName+"["+str(i)+"];    \n      ")
            wrFile.write(outStartPortName+" <= out_start_wire;    \n      ")
            wrFile.write("end\n  ")
            wrFile.write("end                              \n")
        else:
            for i in range(0, dp):
                wrFile.write("assign "+outDataNamePre+"_"+str(i)+" = "+wireOutName+"["+str(i)+"];    \n  ")
            wrFile.write("assign "+outStartPortName+" = out_start_wire;    \n  ")

        wrFile.write("\n")
        wrFile.write("endmodule                        \n\n")

    return moduleName


################################
##genMuxReg("mux_reg")

##genWireCon(fileName, stageIdx, dp, lOrR, dataWidth, regOut)
##genWireCon("genWire.v", 2, 16, "l", 16, True)
##gen2to2Switch("gen2to2Switch.v", 16, True)
##genSwitchesStage("stageSwitches.v", 2, 16, "l", 16, True)

###################Test2
#ctrlIn = []
#for i in range(0, 8):
#    vec = [0,i%2,0,1]
#    ctrlIn.append(vec)
#
#genSwitchCtrl("switchCtrl.v", 1, 8, "l", ctrlIn ) 


#######Test3
#dp = 4
#regOutSwitch = []
#regOutWireCon = []
#for i in range(0, int(math.log(dp,2))):
#    a, b = 1, 0
#    regOutSwitch.append(a)
#    regOutWireCon.append(b)

#genStagesBlock("rightBlock.v", dp, "R", 8, regOutSwitch, regOutWireCon, True)


######Test4
#addrVec = []
#addrVec.append([0,2,1,3])
#addrVec.append([0,2,1,3,0,3,2,1])
#addrVec.append([0,2,1,3,0,3,2,1,0,1,3,2])
#addrVec.append([0,2,1,3])
#portStyle = ["dp","sp","sp","dp"]
#regOut = False
##genMemStage(fileName, dp, sizeN, dataWidth, addrVec, regOut)
##for i in [2,4,8,16,32]:
#i = 2
#genMemStage("memStage_p"+str(i)+".v", i, 256, 16, addrVec, regOut)
