#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <algorithm>
using namespace std;
const int row = 3;
const int col = 13;
int board[row][col];
pair<int, int> knightMove[8];
int xMove[8] = {2,1,-1,-2,-2,-1,1,2};
int yMove[8] = {1,2,2,1,-1,-2,-2,-1};

bool LegalMove(int x, int y)
{
   return board[x][y] == -1 && x >= 0 && y >=0 && x < row && y < col;
}

void returnMoves()
{
    for (int x = 0; x < row; x++) {
        for (int y = 0; y < col; y++)
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

void sortMoves(int x, int y)
{
    int minDegree = 8;
    for(int i =0; i <8 ; i++)
    {
        int nextX = x + xMove[i];
        int nextY = y + yMove[i];
        if(LegalMove(nextX,nextY) && degree(nextX,nextY) < minDegree && degree(nextX,nextY) > 0)
        {
            minDegree = degree(nextX,nextY);
        }
    }
    
    int index = 0;
    for(int i =0; i<8 ; i++)
    {
        int nextX = x + xMove[i];
        int nextY = y + yMove[i];
        if(degree(nextX,nextY) == minDegree)
        {
            knightMove[index] = make_pair(xMove[i],yMove[i]);
            index++;
        }
    }
    //random to break tie
    

    /*if(index != 7)
    {
        for(int i =0; i <8 ; i++)
        {
            int nextX = x + xMove[i];
            int nextY = y + yMove[i];
            bool matchAny = false;
            for(int j = 0; j < index; j++)
            {
                if(nextX == knightMove[j].first && nextY == knightMove[j].second)
                {
                    matchAny = true;
                    break;
                }
                if(!matchAny && j == index-1)
                {
                    knightMove[index] = make_pair(xMove[i], yMove[i]);
                    index++;
                    break;
                }
            }
        }
    }*/
    random_shuffle(&knightMove[0], &knightMove[index]);
    
}

bool findingSolution(int x, int y, int numMoves)
{
   //pair<int, int> knightMove[8];
   sortMoves(x,y);
   if (numMoves == row*col)
   {
      board[x][y] = row*col;
      return true;
   }
   for(int i =0; i <8 ; i++)
   {
	   int nextX = x + knightMove[i].first;
	   int nextY = y + knightMove[i].second;
       if(LegalMove(nextX,nextY))
        {
            board[x][y] = numMoves;
            if(findingSolution(nextX,nextY,numMoves+1))
                return true;
            else
                board[nextX][nextY] = -1; // when we do the backtracking
        }
   }
   return false;
}



bool knightsTour(int x, int y)
{
    for(int i = 0; i<row; i++)
        for(int j = 0; j<col; j++)
            board[i][j] = -1;
    cout << "Knight starts at (" << x << ", " << y << ")" << endl;
    board[x][y] = 0;
    if(!findingSolution(x,y,1))
    {
        cout << "No Solution" << endl;
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
    //while(board[1][col-2] != row*col)
    for(int i =0; i< 12; i++)
    	knightsTour(x,y);
	
    //pair<int, int> abcd[8];
    //pair<int,int> xyz;
    //xyz = make_pair(2,1);
    //sortMoves(x,y,abcd);
    //for(int i = 0; i< 8; i++)
    //cout << "("<< abcd[i].first << abcd[i].second <<")" << endl;
    return 0;
}
