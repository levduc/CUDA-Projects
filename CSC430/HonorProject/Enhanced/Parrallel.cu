#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <algorithm>
#include <stdio.h>
#include <fcntl.h>
#include <time.h>
#define NS_PER_SEC (1000*1000*1000)
using namespace std;

int base[3][4];
int base7[3][7];
int tranposeBase7[7][3];
int base8[3][8];
int tranposeBase8[8][3];
int base11[3][11];
int base12[3][12];
int base13[3][13];
int base14[3][14];
int board7[7][7];
int board8[8][8];

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
	base[0][0]=1;
	base[0][1]=4;
	base[0][2]=7;
	base[0][3]=10;
	base[1][0]=8;
	base[1][1]=11;
	base[1][2]=2;
	base[1][3]=5;
	base[2][0]=3;
	base[2][1]=6;
	base[2][2]=9;
	base[2][3]=12;

    //base 3*7
    	base7[0][0]=1;
	base7[0][1]=14;
	base7[0][2]=17;
	base7[0][3]=20;
	base7[0][4]=9;
	base7[0][5]=4;
	base7[0][6]=7;
	base7[1][0]=16;
	base7[1][1]=19;
	base7[1][2]=12;
	base7[1][3]=3;
	base7[1][4]=6;
	base7[1][5]=21;
	base7[1][6]=10;
	base7[2][0]=13;
	base7[2][1]=2;
	base7[2][2]=15;
	base7[2][3]=18;
	base7[2][4]=11;
	base7[2][5]=8;
	base7[2][6]=5;
    //Tranpose base 7
	for(int x = 0; x < 3; x++)
	  {
		for(int y = 0; y < 7 ; y++)
		{
		    	tranposeBase7[y][x] = base7[x][y];                
	    	}
	  }
    //base 3*8
    	base8[0][0]=1;
	base8[0][1]=16;
	base8[0][2]=3;
	base8[0][3]=22;
	base8[0][4]=19;
	base8[0][5]=12;
	base8[0][6]=7;
	base8[0][7]=10;
	base8[1][0]=4;
	base8[1][1]=21;
	base8[1][2]=18;
	base8[1][3]=15;
	base8[1][4]=6;
	base8[1][5]=9;
	base8[1][6]=24;
	base8[1][7]=13;
	base8[2][0]=17;
	base8[2][1]=2;
	base8[2][2]=5;
	base8[2][3]=20;
	base8[2][4]=23;
	base8[2][5]=14;
	base8[2][6]=11;
	base8[2][7]=8;
    //Tranpose base 8
	for(int x = 0; x < 3; x++)
	  {
		for(int y = 0; y < 8 ; y++)
		{
		    	tranposeBase8[y][x] = base8[x][y];                
	    	}
	  }	
	
    //base 3*11
    for(int x = 0; x < 3; x++)
    {
        for(int y = 0; y < 11 ; y++)
        {
            if(y < 4)
            	base11[x][y] = base[x][y];            
            else
            	base11[x][y] = base7[x][y-4]+3*4;     
    	}// end of inner loop
    }
    //base 3*12
    for(int x = 0; x < 3; x++)
    {
        for(int y =0; y<12; y++)
        {
            if(y<4)
            base12[x][y] = base[x][y];
            else
            base12[x][y] = base8[x][y-4]+3*4;
	}
    }
    //board 3*13
    	base13[0][0]=1;
	base13[0][1]=4;
	base13[0][2]=13;
	base13[0][3]=16;
	base13[0][4]=21;
	base13[0][5]=8;
	base13[0][6]=23;
	base13[0][7]=18;
	base13[0][8]=35;
	base13[0][9]=38;
	base13[0][10]=27;
	base13[0][11]=32;
	base13[0][12]=29;
	base13[1][0]=12;
	base13[1][1]=15;
	base13[1][2]=6;
	base13[1][3]=3;
	base13[1][4]=10;
	base13[1][5]=17;
	base13[1][6]=20;
	base13[1][7]=37;
	base13[1][8]=24;
	base13[1][9]=33;
	base13[1][10]=30;
	base13[1][11]=39;
	base13[1][12]=26;
	base13[2][0]=5;
	base13[2][1]=2;
	base13[2][2]=11;
	base13[2][3]=14;
	base13[2][4]=7;
	base13[2][5]=22;
	base13[2][6]=9;
	base13[2][7]=34;
	base13[2][8]=19;
	base13[2][9]=36;
	base13[2][10]=25;
	base13[2][11]=28;
	base13[2][12]=31;
    //base 3*14
    for(int x = 0; x < 3; x++)
    {	
       for(int y =0; y<14; y++)
        {
            if(y < 7)
                base14[x][y] = base7[x][y];
            else
               base14[x][y] = base7[x][y-7]+3*7;         
     	}
    }
    // load board 7
   	board7[0][0] = 1;
	board7[0][1] = 26;
	board7[0][2] = 11;
	board7[0][3] = 46;
	board7[0][4] = 29;
	board7[0][5] = 24;
	board7[0][6] = 9;
	board7[1][0] = 12;
	board7[1][1] = 45;
	board7[1][2] = 28;
	board7[1][3] = 25;
	board7[1][4] = 10;
	board7[1][5] = 47;
	board7[1][6] = 30;
	board7[2][0] = 27;
	board7[2][1] = 2;
	board7[2][2] = 35;
	board7[2][3] = 44;
	board7[2][4] = 49;
	board7[2][5] = 8;
	board7[2][6] = 23;
	board7[3][0] = 40;
	board7[3][1] = 13;
	board7[3][2] = 42;
	board7[3][3] = 19;
	board7[3][4] = 36;
	board7[3][5] = 31;
	board7[3][6] = 48;
	board7[4][0] = 3;
	board7[4][1] = 16;
	board7[4][2] = 39;
	board7[4][3] = 34;
	board7[4][4] = 43;
	board7[4][5] = 22;
	board7[4][6] = 7;
	board7[5][0] = 14;
	board7[5][1] = 41;
	board7[5][2] = 18;
	board7[5][3] = 5;
	board7[5][4] = 20;
	board7[5][5] = 37;
	board7[5][6] = 32;
	board7[6][0] = 17;
	board7[6][1] = 4;
	board7[6][2] = 15;
	board7[6][3] = 38;
	board7[6][4] = 33;
	board7[6][5] = 6;
	board7[6][6] = 21;
   //Board 8
	 board8[0][0] = 1;
	board8[0][1] = 46;
	board8[0][2] = 15;
	board8[0][3] = 24;
	board8[0][4] = 59;
	board8[0][5] = 28;
	board8[0][6] = 13;
	board8[0][7] = 26;
	board8[1][0] = 16;
	board8[1][1] = 23;
	board8[1][2] = 58;
	board8[1][3] = 51;
	board8[1][4] = 14;
	board8[1][5] = 25;
	board8[1][6] = 64;
	board8[1][7] = 29;
	board8[2][0] = 47;
	board8[2][1] = 2;
	board8[2][2] = 45;
	board8[2][3] = 54;
	board8[2][4] = 63;
	board8[2][5] = 60;
	board8[2][6] = 27;
	board8[2][7] = 12;
	board8[3][0] = 22;
	board8[3][1] = 17;
	board8[3][2] = 52;
	board8[3][3] = 57;
	board8[3][4] = 50;
	board8[3][5] = 55;
	board8[3][6] = 30;
	board8[3][7] = 61;
	board8[4][0] = 3;
	board8[4][1] = 48;
	board8[4][2] = 21;
	board8[4][3] = 44;
	board8[4][4] = 53;
	board8[4][5] = 62;
	board8[4][6] = 11;
	board8[4][7] = 34;
	board8[5][0] = 18;
	board8[5][1] = 39;
	board8[5][2] = 42;
	board8[5][3] = 49;
	board8[5][4] = 56;
	board8[5][5] = 33;
	board8[5][6] = 8;
	board8[5][7] = 31;
	board8[6][0] = 41;
	board8[6][1] = 4;
	board8[6][2] = 37;
	board8[6][3] = 20;
	board8[6][4] = 43;
	board8[6][5] = 6;
	board8[6][6] = 35;
	board8[6][7] = 10;
	board8[7][0] = 38;
	board8[7][1] = 19;
	board8[7][2] = 40;
	board8[7][3] = 5;
	board8[7][4] = 36;
	board8[7][5] = 9;
	board8[7][6] = 32;
	board8[7][7] = 7;

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


void solveBoard(int n)
{
    int board[n][n]; // initialize the board
    for (int i = 0; i < n; i++)
       for (int j = 0; j < n; j++)
            board[i][j] = 0;
    int BaseOfFour = blockOfFour(n)/4; // number blocks of 3*4
    
    switch(n % 3)
    {	
	case 0: // for all board size that is divisibe by 3
	   for (int x = 0; x < 3; x++)
	   {
	       for(int y = 0; y < n; y++)
	       {
		    if(y < blockOfFour(n))
		    {
			int temp = y/4;	
			for(int i = 0; i < n; i+= 6) // parrallel here parrallel here i+6 to get stripe without flipping order
			{
			    int stride = i/3;		    	
			    board[x+i][y] = base[x][y%4]+ temp*12 + 3*n*stride;
			    if(x+3+i < n)
			    	board[x+3+i][n-y-1] = base[x][y%4]+ temp*12 + 3*n*(stride+1);
			}
		    }
		    else
		    {
			for(int i = 0 ; i < n; i+= 6) // parallel here
			{
			    int stride = i/3;
			    if(n % 4 == 0)
			    {
			    	board[x+i][y] = base8[x][y-blockOfFour(n)]+BaseOfFour*12 + 3*n*stride;
				board[x+3+i][n-y-1] = base8[x][y-blockOfFour(n)]+ BaseOfFour*12 + 3*n*(stride+1); //using base 8
			    }
 			    if(n % 4 == 1)
			    {
			    	board[x+i][y] = base13[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n)
				   board[x+3+i][n-y-1] = base13[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1); //using base 13
			    }
			    if(n % 4 == 2)
			    {
			    	board[x+i][y] = base14[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n)
				   board[x+3+i][n-y-1] = base14[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1); // using base 14
			    }
			    if(n % 4 == 3)
			    {
			    	board[x+i][y] = base7[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n)
				   board[x+3+i][n-y-1] = base7[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1); // using base 7
			    }
			}
		    }
	       }   
	   }
	   break; //  end of first case
	case 1:
	   for (int x = 0; x < 3; x++)
	   {
	       for(int y = 0; y < n; y++)
	       {
		    if(y < blockOfFour(n))
		    {
			int temp = y/4; // temp get index of blockOf4
			for(int i = 0; i < n-7; i+= 6) // 
			{
			    int stride = i/3; 	    	
			    board[x+i][y] = base[x][y%4]+ temp*12 + 3*n*stride; 
			    if(x+3+i < n-7)
			    	board[x+3+i][n-y-1] = base[x][y%4]+ temp*12 + 3*n*(stride+1);
			}
		    }// end of if
		    else
		    {
			for(int i = 0 ; i < n-7; i+= 6) // parallel here
			{
			    int stride = i/3;
			    if(n % 4 == 0)
			    {
			    	board[x+i][y] = base8[x][y-blockOfFour(n)]+BaseOfFour*12 + 3*n*stride;
				if(x+3+i < n-7)// Don't want to get in the 7 stride
				board[x+3+i][n-y-1] = base8[x][y-blockOfFour(n)]+ BaseOfFour*12 + 3*n*(stride+1);
			    }
 			    if(n % 4 == 1)
			    {
			    	board[x+i][y] = base13[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n-7) // Don't want to get in the 7 stride
				   board[x+3+i][n-y-1] = base13[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1);
			    }
			    if(n % 4 == 2)
			    {
			    	board[x+i][y] = base14[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n-7) // Don't want to get in the 7 stride
				   board[x+3+i][n-y-1] = base14[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1);
			    }
			    if(n % 4 == 3)
			    {
			    	board[x+i][y] = base7[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n-7) // Don't want to get in the 7 stride
				   board[x+3+i][n-y-1] = base7[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1);
			    }
			}
		    }// end of else
	       }// end of for y   
	   }// end of big 4
	   //Handling 7*3(k-1) here 2 case 
	   if(n%2 != 0)
	   {
		   for(int x = 0; x < 7; x++)
		   {
			for(int y = 0; y < n-7 ; y++) // NOTE !!!!
			{
			    if(y%6 == 0) //0,6,12....
			    {
				int temp = y/6;
			    	board[n+x-7][y] = tranposeBase7[x][y%3]+ 2*temp*21 + (n-7)*n; // minus 7 because we want to start at line n-7
				board[n+x-7][y+1] = tranposeBase7[x][y%3+1]+ 2*temp*21 + (n-7)*n;
				board[n+x-7][y+2] = tranposeBase7[x][y%3+2]+ 2*temp*21 + (n-7)*n;
			    }
			    else if( y%3 == 0) //3,9,15,21...
			    {
				int temp = y/6;
			    	board[n-x-1][y] = tranposeBase7[x][y%3]+ 21 + 2*temp*21 + (n-7)*n;
				board[n-x-1][y+1] = tranposeBase7[x][y%3+1]+ 21 + 2*temp*21+ (n-7)*n;
				board[n-x-1][y+2] = tranposeBase7[x][y%3+2]+ 21 + 2*temp*21+ (n-7)*n;
			    }
			}
		   }
		   //handling 7*7 chessboard here
		   for(int x = 0; x < 7; x++)
		   {
			for(int y = 0; y < 7 ; y++)
			{
			    board[n+x-7][n+y-7] = board7[x][y] + (n*n-49);
			}
		   }
           } else
		{
		for(int x = 0; x < 7; x++)
		   {
			for(int y = n; y > 7 ; y--) // NOTE !!!!
			{
			    if((n-y)%6 == 0) // n-y because we start from ending
			    {
				int temp = (n-y)/6;
			    	board[n+x-7][y-1] = tranposeBase7[x][(n-y)%3] + 2*temp*21 + (n-7)*n;
				board[n+x-7][y-2] = tranposeBase7[x][(n-y)%3+1] + 2*temp*21 + (n-7)*n; //+ 2*temp*21 + (n-7)*n
				board[n+x-7][y-3] = tranposeBase7[x][(n-y)%3+2] + 2*temp*21 + (n-7)*n; 
			    }
			    else if((n-y)%3 == 0) // n-y because we start from ending
			    {
				int temp = (n-y)/6;
			    	board[n-x-1][y-1] = tranposeBase7[x][(n-y)%3] + 21 +  2*temp*21 + (n-7)*n;
				board[n-x-1][y-2] = tranposeBase7[x][(n-y)%3+1]+ 21 + 2*temp*21 + (n-7)*n;
				board[n-x-1][y-3] = tranposeBase7[x][(n-y)%3+2]+ 21 + 2*temp*21 + (n-7)*n;
			    }
			}
		   }
		   //handling 7*7 chessboard here
		   for(int x = 6; x >= 0; x--)
		   {
			for(int y = 6; y >=0 ; y--)
			{
			    board[n+x-7][y] = board7[6-x][6-y] + (n*n-49);
			    //cout << "testing" << endl;
			}
		   }
	   }// end of else

	  
	
	break;
      case 2:
	 for (int x = 0; x < 3; x++)
	   {
	       for(int y = 0; y < n; y++)
	       {
		    if(y < blockOfFour(n))
		    {
			int temp = y/4;	
			for(int i = 0; i < n-8; i+= 6) 
			{
			    int stride = i/3; 	    	
			    board[x+i][y] = base[x][y%4]+ temp*12 + 3*n*stride;
			    if(x+3+i < n-8)
			    	board[x+3+i][n-y-1] = base[x][y%4]+ temp*12 + 3*n*(stride+1);
			}
		    }// end of if
		    else
		    {
			for(int i = 0 ; i < n-8; i+= 6)
			{
			    int stride = i/3;
			    if(n % 4 == 0)
			    {
			    	board[x+i][y] = base8[x][y-blockOfFour(n)]+BaseOfFour*12 + 3*n*stride;
				if(x+3+i < n-8)// Don't want to get in the 8 stride
				board[x+3+i][n-y-1] = base8[x][y-blockOfFour(n)]+ BaseOfFour*12 + 3*n*(stride+1);
			    }
 			    if(n % 4 == 1)
			    {
			    	board[x+i][y] = base13[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n-8) // Don't want to get in the 8 stride
				   board[x+3+i][n-y-1] = base13[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1);
			    }
			    if(n % 4 == 2)
			    {
			    	board[x+i][y] = base14[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n-8) // Don't want to get in the 8 stride
				   board[x+3+i][n-y-1] = base14[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1);
			    }
			    if(n % 4 == 3)
			    {
			    	board[x+i][y] = base7[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*stride;
				if(x+3+i < n-8) // Don't want to get in the 8 stride
				   board[x+3+i][n-y-1] = base7[x][y-blockOfFour(n)]+ BaseOfFour * 12 + 3*n*(stride+1);
			    }
			}
		    }// end of else
	       }// end of for y   
	   }// end of big 4
	// Handling 8*n stride here
	 if(n%2 == 0)
	   {
		   for(int x = 0; x < 8; x++)
		   {
			for(int y = 0; y < n-8 ; y++) // NOTE !!!!
			{
			    if(y%6 == 0) //0,6,12....
			    {
				int temp = y/6;
			    	board[n+x-8][y] = tranposeBase8[x][y%3]+ 2*temp*24 + (n-8)*n; // minus 8 because we want to start at line n-8
				board[n+x-8][y+1] = tranposeBase8[x][y%3+1]+ 2*temp*24 + (n-8)*n;
				board[n+x-8][y+2] = tranposeBase8[x][y%3+2]+ 2*temp*24 + (n-8)*n;
			    }
			    else if( y%3 == 0) //3,9,15,21...
			    {
				int temp = y/6;
			    	board[n-x-1][y] = tranposeBase8[x][y%3]+ 24 + 2*temp*24 + (n-8)*n;
				board[n-x-1][y+1] = tranposeBase8[x][y%3+1]+ 24 + 2*temp*24+ (n-8)*n;
				board[n-x-1][y+2] = tranposeBase8[x][y%3+2]+ 24 + 2*temp*24+ (n-8)*n;
			    }
			}
		   }
		   //handling 8*8 chessboard here
		   for(int x = 0; x < 8; x++)
		   {
			for(int y = 0; y < 8 ; y++)
			{
			    board[n+x-8][n+y-8] = board8[x][y] + (n*n-64);
			}
		   }
           } else
		{
		for(int x = 0; x < 8; x++)
		   {
			for(int y = n; y > 8 ; y--) // NOTE !!!!
			{
			    if((n-y)%6 == 0) // n-y because we start from ending
			    {
				int temp = (n-y)/6; // getting index of block 8*3
			    	board[n+x-8][y-1] = tranposeBase8[x][(n-y)%3] + 2*temp*24 + (n-8)*n;
				board[n+x-8][y-2] = tranposeBase8[x][(n-y)%3+1] + 2*temp*24 + (n-8)*n;
				board[n+x-8][y-3] = tranposeBase8[x][(n-y)%3+2] + 2*temp*24 + (n-8)*n; 
			    }
			    else if((n-y)%3 == 0) // n-y because we start from ending
			    {
				int temp = (n-y)/6; // getting index of block 8*3
			    	board[n-x-1][y-1] = tranposeBase8[x][(n-y)%3] + 24 +  2*temp*24 + (n-8)*n; // note 24 = 3*8 
				board[n-x-1][y-2] = tranposeBase8[x][(n-y)%3+1]+ 24 + 2*temp*24 + (n-8)*n;
				board[n-x-1][y-3] = tranposeBase8[x][(n-y)%3+2]+ 24 + 2*temp*24 + (n-8)*n;
			    }
			}
		   }
		   //handling 7*7 chessboard here
		   for(int x = 7; x >= 0; x--)
		   {
			for(int y = 7; y >=0 ; y--)
			{
			    board[n+x-7][y] = board8[7-x][7-y] + (n*n-64);
			    //cout << "testing" << endl;
			}
		   }
	   }// end of else
    } // end of switch


    // print out the thingy
    
    /*for (int x = 0; x < n; x++) {
        for (int y = 0; y < n; y++)
            cout << board[x][y]<< "\t";
        cout << endl;
    }*/
    
}

int main()
{
    loadData();
    int n;
    cout << "Enter size of board:";
    cin >> n;
    unsigned long int cpuTime = monotonicTime();
    solveBoard(n);
    cpuTime = monotonicTime() - cpuTime;  
    fprintf(stderr, "Time to perform operation on CPU = %ld ns\n", cpuTime);
    /*for(int x = 0; x < 3; x++)
    {
	for(int y = 0; y < 8 ; y++)
	    	cout << base8[x][y] << "\t";                
	cout << endl;
    }
    for(int x = 0; x < 8; x++)
    {
	for(int y = 0; y < 3 ; y++)
	    	cout << tranposeBase8[x][y] << "\t";   
	cout << endl;             
    }*/
    return 0;
}
