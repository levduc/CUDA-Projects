#include <iostream>
#include <stdlib.h>
#include <math.h> 
using namespace std;

const int n = 8;
int board[n][n];
int xMove[8] = {2,1,-1,-2,-2,-1,1,2};
int yMove[8] = {1,2,2,1,-1,-2,-2,-1};

bool LegalMove(int x, int y)
{
   return board[x][y] == -1 && x >= 0 && y >=0 && x < n && y < n;
}

void returnMoves()
{
    for (int x = 0; x < n; x++) {
        for (int y = 0; y < n; y++)
            cout << board[x][y]<< "\t";
        cout << endl;
    }
}

int degree(int x, int y)
{
   int deg = 0;
   for(int i = 0; i < 8; i++)
   {
	int nextX = x + xMove[i]; 
	int nextY = y + yMove[i];
        if (LegalMove(nextX,nextY) && board[nextX][nextY]== -1)
		deg++;
   }
   return deg;	
}

bool findingSolution(int x, int y, int numMoves)
{
   int nextX, nextY;
   //int min = 9;
   if (numMoves == n*n)
   {	 
      board[x][y] = n*n;	
      return true;
   }
   for(int i =0; i <8 ; i++)
   {
	   int minDegree = 8;
	   int nextX = x + xMove[i]; 
	   int nextY = y + yMove[i];
	   
           if(LegalMove(nextX,nextY))
	   {
		board[x][y] = numMoves;
		if(findingSolution(nextX,nextY,numMoves+1))
			return true;
		else
	  		board[nextX][nextY] = -1;
	   }
   }
   return false;
}



bool knightsTour(int x, int y)
{   
    for(int i = 0; i<n; i++)
	for(int j = 0; j<n; j++)
	    board[i][j] = -1;
    cout << "Knight starts at (" << x << ", " << y << ")" << endl;
    board[x][y] = 0; 
    if(!findingSolution(x,y,1))
    {
        cout << "No Solution" << endl;
	//returnMoves();
        return false;
    }
    else
        returnMoves();

    return true;
}

int main() {
    int x,y;
    cout <<"x-coordinate of Knight:";
    cin >> x;
    cout <<"y-coordinate of Knight:";
    cin >> y;
    knightsTour(x,y);
    return 0;
}
