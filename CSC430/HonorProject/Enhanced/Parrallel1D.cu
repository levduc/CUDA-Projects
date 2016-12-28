#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <algorithm>
#include <stdio.h>
#include <fcntl.h>
#include <time.h>
#define NS_PER_SEC (1000*1000*1000)
using namespace std;

int base[12];
int base7[21];
int base8[24];
int base11[33];
int base12[36];
int base13[39];
int base14[42];

inline unsigned long int monotonicTime(void)
{
  //const unsigned long int NS_PER_SEC = 1000 * 1000 * 1000;
  struct timespec now;
  clock_gettime(CLOCK_MONOTONIC, &now);
  return now.tv_sec * NS_PER_SEC + now.tv_nsec;
}

void loadData()
{
 //base 3*4
	base[0]=1;
	base[3]=4;
	base[6]=7;
	base[9]=10;
	base[1]=8;
	base[4]=11;
	base[7]=2;
	base[10]=5;
	base[2]=3;
	base[5]=6;
	base[8]=9;
	base[11]=12;

    //base 3*7
    	base7[0]=1;
	base7[3]=14;
	base7[6]=17;
	base7[9]=20;
	base7[12]=9;
	base7[15]=4;
	base7[18]=7;
	base7[1]=16;
	base7[4]=19;
	base7[7]=12;
	base7[10]=3;
	base7[13]=6;
	base7[16]=21;
	base7[19]=10;
	base7[2]=13;
	base7[5]=2;
	base7[8]=15;
	base7[11]=18;
	base7[14]=11;
	base7[17]=8;
	base7[20]=5;
    //base 3*8
    	base8[0]=1;
	base8[3]=16;
	base8[6]=3;
	base8[9]=22;
	base8[12]=19;
	base8[15]=12;
	base8[18]=7;
	base8[21]=10;
	base8[1]=4;
	base8[4]=21;
	base8[7]=18;
	base8[10]=15;
	base8[13]=6;
	base8[16]=9;
	base8[19]=24;
	base8[22]=13;
	base8[2]=17;
	base8[5]=2;
	base8[8]=5;
	base8[11]=20;
	base8[14]=23;
	base8[17]=14;
	base8[20]=11;
	base8[23]=8;
    //base 3*11
    for(int x = 0; x < 33; x++)
    {
            if(x < 12)
            base11[x] = base[x];            
            else
            base11[x] = base7[x-12]+3*4;     
    }
    //base 3*12
    for(int x = 0; x < 36; x++)
    {
            if(x<12)
            base12[x] = base[x];
            else
            base12[x] = base8[x-12]+3*4;
    }
    //board 3*13
    	base13[0]=1;
	base13[3]=4;
	base13[6]=13;
	base13[9]=16;
	base13[12]=21;
	base13[15]=8;
	base13[18]=23;
	base13[21]=18;
	base13[24]=35;
	base13[27]=38;
	base13[30]=27;
	base13[33]=32;
	base13[36]=29;
	base13[1]=12;
	base13[4]=15;
	base13[7]=6;
	base13[10]=3;
	base13[13]=10;
	base13[16]=17;
	base13[19]=20;
	base13[22]=37;
	base13[25]=24;
	base13[28]=33;
	base13[31]=30;
	base13[34]=39;
	base13[37]=26;
	base13[2]=5;
	base13[5]=2;
	base13[8]=11;
	base13[11]=14;
	base13[14]=7;
	base13[17]=22;
	base13[20]=9;
	base13[23]=34;
	base13[26]=19;
	base13[29]=36;
	base13[32]=25;
	base13[35]=28;
	base13[38]=31;
    //base 3*14
    for(int x = 0; x < 42; x++)
    {	
            if(x < 21)
                base14[x] = base7[x];
            else
               base14[x] = base7[x-21]+3*7;         
    }
}

int blockOfFour(int n) // getting num blocks of four in each stripe.
{
    if(n < 11)
    {
	return 0;
    }
    else
    {
        int num = 0;
        switch(n%4)
        {
	    case 0:
	       num = (n-8);
	       break;
	    case 1:
	       num = (n-13);
	       break;
	    case 2:
	       num = (n-14);
	       break;
	    case 3:
	       num = (n-7);
	       break;
        }
	return num;
    }		
}
__device__ int gpuBlockOfFour(int n)
{
    if(n < 11)
    {
	return 0;
    }
    else
    {
        int num = 0;
        switch(n%4)
        {
	    case 0:
	       num = (n-8);
	       break;
	    case 1:
	       num = (n-13);
	       break;
	    case 2:
	       num = (n-14);
	       break;
	    case 3:
	       num = (n-7);
	       break;
        }
	return num;
    }		
}

__global__ void solveBoard(int* base, int* base7, int* base8, int* base11, int* base12, int* base13, int* base14, int* board, int* runTime, int n)
{
    clock_t start_time = clock();
    switch(n % 3)
    {	
	case 0: // for all board size that is divisibe by 3
	int BaseOfFour = gpuBlockOfFour(n)/4;
	int blockOfFour = gpuBlockOfFour(n);
	   for (int x = 0; x < 3; x++)
	   {
	       for(int y = 0; y < n; y++)
	       {
		    if(y < gpuBlockOfFour(n))
		    {
			int temp = y/4;	
			//for(int i = 0; i < n; i+= 6) // parrallel here if(threadIdx.x%2 == 0) i = threadIdx*6
			//{
			if(threadIdx.x % 2 == 0)
			{
			    int i =  threadIdx.x*3;
			    //int stride = threadIdx.x;			    	
			    board[(x+i)+n*y] = base[x+(y%4)*3]+ temp*12 + 3*n*threadIdx.x;
			    if(x+3+i < n)
			    	board[(x+3+i)+n*(n-y-1)] = base[x+(y%4)*3]+ temp*12 + 3*n*(threadIdx.x+1);
			}
			//}
		    }
		    else
		    {
			//for(int i = 0 ; i < n; i+= 6) // parallel here
			//{
			if(threadIdx.x % 2 == 0)
			{
			    int i =  threadIdx.x*3;
			    //int stride = i/3;
			    if(n % 4 == 0)
			    {
			    	board[(x+i)+n*y] = base8[x+(y-blockOfFour)*3]+BaseOfFour*12 + 3*n*threadIdx.x;
				board[(x+3+i)+n*(n-y-1)] = base8[x+(y-blockOfFour)*3]+ BaseOfFour*12 + 3*n*(threadIdx.x+1);
			    }
 			    if(n % 4 == 1)
			    {
			    	board[(x+i)+n*y] = base13[x+(y-blockOfFour)*3]+ BaseOfFour * 12 + 3*n*threadIdx.x;
				if(x+3+i < n)
				   board[(x+3+i)+ n*(n-y-1)] = base13[x+(y-blockOfFour)*3]+ BaseOfFour * 12 + 3*n*(threadIdx.x+1);
			    }
			    if(n % 4 == 2)
			    {
			    	board[(x+i)+ n*y] = base14[x+(y-blockOfFour)*3]+ BaseOfFour * 12 + 3*n*threadIdx.x;
				if(x+3+i < n)
				   board[(x+3+i)+n*(n-y-1)] = base14[x+(y-blockOfFour)*3]+ BaseOfFour * 12 + 3*n*(threadIdx.x+1);
			    }
			    if(n % 4 == 3)
			    {
			    	board[(x+i)+n*y] = base7[x+(y-blockOfFour)*3]+ BaseOfFour * 12 + 3*n*threadIdx.x;
				if(x+3+i < n)
				   board[(x+3+i)+n*(n-y-1)] = base7[x+(y-blockOfFour)*3]+ BaseOfFour * 12 + 3*n*(threadIdx.x+1);
			    }
			}
		    }
	       }   
	   }
	   break; 
    }
    clock_t stop_time = clock();
    runTime[threadIdx.x] =(int) (stop_time - start_time);
    /*for (int x = 0; x < n; x++) {
        for (int y = 0; y < n; y++)
            cout << board[x+n*y]<< "\t";
        cout << endl;
    }*/
}

int main()
{
    loadData();
    int n;
    cout << "Enter size of board:";
    cin >> n;
    int board[n*n];
    int Time[n/3];
    unsigned long int gpuTime = monotonicTime();
    // Declare gpuBase
    int* gpuBase;
    int* gpuBase7;
    int* gpuBase8;
    int* gpuBase11;
    int* gpuBase12;
    int* gpuBase13;
    int* gpuBase14;
    int* gpuBoard;
    int* runTime;
    //Allocate
    cudaMalloc(&gpuBase, 12*sizeof(int));     cudaMalloc(&gpuBase7, 21*sizeof(int));
    cudaMalloc(&gpuBase8, 24*sizeof(int));     cudaMalloc(&gpuBase11, 33*sizeof(int));
    cudaMalloc(&gpuBase12, 36*sizeof(int));     cudaMalloc(&gpuBase13, 39*sizeof(int));
    cudaMalloc(&gpuBase14, 42*sizeof(int));     cudaMalloc(&gpuBoard, n*n*sizeof(int));
    cudaMalloc(&runTime, n*sizeof(int)); //  getting runTime 
    //Copy data
    cudaMemcpy(gpuBase, base,  12*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(gpuBase7, base7,  21*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(gpuBase8, base8,  24*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(gpuBase11, base11,  33*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(gpuBase12, base12,  36*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(gpuBase13, base13,  39*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(gpuBase14, base14,  42*sizeof(int), cudaMemcpyHostToDevice);
    // Calculate threads needed
    int num_threads = n/3; // we want to handle the last thing in stripe
    // Call kernel
    solveBoard<<<1,num_threads>>>(gpuBase,gpuBase7,gpuBase8,gpuBase11,gpuBase12,gpuBase13,gpuBase14,gpuBoard,runTime, n);
    // copy to out from device to host
    cudaMemcpy(board, gpuBoard, n*n* sizeof(int) , cudaMemcpyDeviceToHost); 
    cudaMemcpy(Time, runTime, (n/3)* sizeof(int) , cudaMemcpyDeviceToHost); 	
    gpuTime = monotonicTime() - gpuTime;  
    fprintf(stderr, "Time to perform operation on CPU = %ld ns\n", Time[n/3-1]);

    /*for (int x = 0; x < n; x++) {
        for (int y = 0; y < n; y++)
            cout << board[x+n*y]<< "\t";
        cout << endl;
    }
    
    /*for(int x = 0; x < 42; x++)
    {         
	cout << base14[x] << endl;
    }*/
    return 0;
}
