#!/usr/bin/python3


import math

#with open("input.txt", "r") as inFile:
#	strIn = inFile.readline().strip('\r\n')
#	vecIn = strIn.split(" ")
#	data = [int(x, 16) for x in vecIn if x] 
#	vecCmp = [i for i in range(len(data))]
#	vecPer = [data[x] for x in data]
#	print vecCmp
#	print vecPer
#	if vecCmp == vecPer:
#		print "Mapping correct"#


vec = [i for i in range(4096)]
vecOut = [int(bin(x)[2:].zfill(int(math.log(4096,2)))[::-1],2) for x in vec]
print(vecOut)
