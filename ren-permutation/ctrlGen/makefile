#Makefile for "permutation generator" c++ applicaiton
#Created by Ren Chen 08/12/2016

#Compiler
CC = g++

#Compile-time flags
CFLAGS = -Wall -g

#Directories containing header files
INCLUDES = -I~/GoogleDrive/code/permutation/source

#Library paths in addition to /usr/lib
LFLAGS = -L../lib

#Libraries to link into executable:
LIBS = -lm

#Define the C++ source files
SRCS =  route_spn.cpp         \
	con_route.cpp         \
	file_func.cpp         \
	greedy_route.cpp      \
	map.o mem_route.cpp   \
	node.cpp              \
	per_func.cpp 

#Define the object files
OBJS = $(SRCS:.cpp=.o)

#Define the executable file
MAIN = perGen

###########
.PHONY: depend clean

all: $(MAIN)
     
$(MAIN): $(OBJS) 
	$(CC) $(CFLAGS) $(INCLUDES) -o $(MAIN) $(OBJS) $(LFLAGS) $(LIBS)
    
#Rule for building .o from .cpp     
.cpp.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	$(RM) *.o *~ $(MAIN)
    
depend: $(SRCS)
	makedepend $(INCLUDES) $^
    
# DO NOT DELETE THIS LINE -- make depend needs it
    
