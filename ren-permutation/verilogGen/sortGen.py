#!/usr/bin/python3
#!/bin/sh
#Generate bitonic sorting Verilog implementation
#Author: Ren Chen

import getopt
import math
#import perGen

##idx: sort_stage_idx (1~log_{2}n), p: data parallelism, n: problem_size
##Reference: pipelined radix-2k feedforward FFT architecture
def genPerVec(p, n, res):
	log_n = int(math.log(n,2))
	log_p = int(math.log(p,2))
	log_n_by_p = int(math.log(n/p,2))

	for i in range(1,log_n+1):
		vec_idx_y_a = [j for j in range(log_n-i,min(log_n-i+log_p, log_n))]
		vec_idx_y_b = [j for j in range(log_n-i-1,log_n_by_p-1,-1)] if len(vec_idx_y_a) < log_p else []
		vec_idx_y = vec_idx_y_a + vec_idx_y_b

		vec_idx_x_a = [j for j in range(min(log_n_by_p, log_n-i))] if i < log_n else []
		vec_idx_x_b = [j for j in range(vec_idx_y[-1]+1,log_n)] if len(vec_idx_x_a) < log_n_by_p else []
		vec_idx_x = vec_idx_x_a + vec_idx_x_b

		vec_idx = vec_idx_y + vec_idx_x
		vec_idx_dict = {vec_idx[j]:j for j in range(len(vec_idx))}

		vec_zero_to_n = [bin(j)[2:].zfill(log_n)[::-1] for j in range(n)]
		vec = []
		for x_str in vec_zero_to_n:
			val_str = ''.join([x_str[vec_idx_dict[j]] for j in range(len(x_str))[::-1]])
			val = int(val_str,2)
			vec.append(val)
		res.append(vec)


def genPerMap(p, n, res):
	log_n = int(math.log(n,2))
	log_p = int(math.log(p,2))
	log_n_by_p = int(math.log(n/p,2))

	vec_idx = []
	genPerVec(p, n, vec_idx)
	pre_idx_vec = [i for i in range(n)]

	for i in range(log_n):
		cur_idx_vec = vec_idx[i]
		pre_idx_dict= { pre_idx_vec[j]:j for j in range(len(pre_idx_vec)) }
		map_vec = [ pre_idx_dict[x] for x in cur_idx_vec ]
		#print map_vec
		res.append(map_vec)
		pre_idx_vec = cur_idx_vec
	#print res


vec = []
#genPerVec(4,16,res)
genPerMap(8,64,vec)
for x in vec:
	print x
