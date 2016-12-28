#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <algorithm>
using namespace std;

int base[3][4];
int base7[3][7];
int tranposeBase7[7][3];
int base8[3][8];
int base11[3][11];
int base12[3][12];
int base13[3][13];
int base14[3][14];
int board7[7][7];
int board8[8][8];
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

int** create2DArray(int n) 
    {
      int** array2D = 0;
      //transpose 3x7 to 7*3
      
      array2D = new int*[7]; // height is 7

      for (int h = 0; h < 7; h++)
      {
            array2D[h] = new int[n-7];
	    //initialize array
            for (int w = 0; w < (n-7); w++)
            {
                 //if(w < ) 
		 //array2D[h][w] = w + width * h;
            }
      }
      return array2D;
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
	   break;
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
	   //Handling 7*n here
	   for(int x = 0; x < 7; x++)
	   {
		for(int y = 0; y < n-7 ; y++) // NOTE !!!!
		{
		    if(y%6 == 0) //0,6,12....
		    {
			int temp = y/6;
		    	board[n+x-7][y] = tranposeBase7[x][y%3]+ 2*temp*21;
			board[n+x-7][y+1] = tranposeBase7[x][y%3+1]+ 2*temp*21;
			board[n+x-7][y+2] = tranposeBase7[x][y%3+2]+ 2*temp*21;
		    }
		    else if( y%3 == 0) //3,9,15,21...
		    {
			int temp = y/6;
		    	board[n-x-1][y] = tranposeBase7[x][y%3]+ 21 + 2*temp*21;
			board[n-x-1][y+1] = tranposeBase7[x][y%3+1]+ 21 + 2*temp*21;
			board[n-x-1][y+2] = tranposeBase7[x][y%3+2]+ 21 + 2*temp*21;
		    }
		    /*int temp = y/3; // getting index of block of 7*3
		    for(int i = 0; i < n-7; i+= 3) // 
			{  
			    int stride = i/3; 	    	
			    board[n+x-7][y] = tranposeBase7[x][y%3] + temp*21 + 3*n*stride;
			    if(x+3+i < n-7)
			    	board[x+3+i][n-y-1] = base[x][y%4]+ temp*12 + 3*n*(stride+1);
			}*/
		}
	   }
	
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
	


    } // end of switch
    for (int x = 0; x < n; x++) {
        for (int y = 0; y < n; y++)
            cout << board[x][y]<< "\t";
        cout << endl;
    }
}

int main()
{
    loadData();
    int n;
    cout << "Enter size of board:";
    cin >> n;
    solveBoard(n);

    /*for(int x = 0; x < 3; x++)
    {
	for(int y = 0; y < 7 ; y++)
	    	cout << base7[x][y] << "\t";                
	cout << endl;
    }
    for(int x = 0; x < 7; x++)
    {
	for(int y = 0; y < 3 ; y++)
	    	cout << tranposeBase7[x][y] << "\t";   
	cout << endl;             
    }*/
    return 0;
}
