#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <algorithm>
using namespace std;
const int row = 3;
const int col = 8;
int board[row][col];
pair<int, int> knightMove[8];
int xMove[8] = {2,1,-1,-2,-2,-1,1,2};
int yMove[8] = {1,2,2,1,-1,-2,-2,-1};
int base[3][4];
int base7[3][7];
int base8[3][8];
int base11[3][11];
int base12[3][12];
int base13[3][13];
int base14[3][14];
bool LegalMove(int x, int y)
{
   return board[x][y] == -1 && x >= 0 && y >=0 && x < row && y < col;
}

void returnMoves()
{
    for (int x = 0; x < row; x++) {
        for (int y = 0; y < col; y++)
	{
            cout << board[x][y]<< "\t";
            //cout<< "base7["<<x<<"]["<<y<<"];";
        }
        cout << endl;
    }
    for (int x = 0; x < row; x++) {
        for (int y = 0; y < col; y++)
	{
            //cout << board[x][y]<< "\t";
            cout<< "base8["<<x<<"]["<<y<<"]="<< board[x][y]<<";"<< endl;
        }
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
	if(board[1][col-2] == row*col)
           returnMoves();

    return true;
}

int main() {
    //int x,y;
    //cout <<"x-coordinate of Knight:";
    //cin >> x;
    //cout <<"y-coordinate of Knight:";
    //cin >> y;
    //board 3*4
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
	    for(int y =0; y<11; y++)
	    {
		if(y<4){
		base11[x][y] = base[x][y];
		}
		else{
		base11[x][y] = base7[x][y-4]+3*4;
		}
	    }
       
    //base 3*12
        for(int x = 0; x < 3; x++)
	    for(int y =0; y<12; y++)
	    {
		if(y<4){
		base12[x][y] = base[x][y];
		}
		else{
		base12[x][y] = base8[x][y-4]+3*4;
		}
	    }
    //board 3*13 
        base13[0][0]=1;
	base13[0][1]=4;
	base13[0][2]=13;
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
       for(int y =0; y<14; y++)
    {
	if(y<7){
	base14[x][y] = base7[x][y];
	}
	else{
	base14[x][y] = base7[x][y-7]+3*7;
	}
    }   
    //int size;
    //cout <<"x-coordinate of Knight:";
    //cin >> size;
    int temp =30;	
    int boardSize[3][temp];
    int howMany = 16;
    for(int x = 0; x < 3; x++)
       for(int y =0; y < 30; y++)
	{	   
	if(y < howMany)
	   boardSize[x][y] = base[x][y%4]+3*4*(y/4);
	else
	   boardSize[x][y] = base14[x][(y-howMany)%14] + howMany*3;
	}
    for (int x = 0; x < 3; x++) {
        for (int y = 0; y < 30; y++)
            cout << boardSize[x][y]<< "\t";
        cout << endl;
    }


    //for(int i =0; i< 10; i++)
    //knightsTour(x,y);	
    return 0;
}
