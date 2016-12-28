#include <iostream>
#include <iomanip>
#include <vector>
#include <cstdlib>
#include <cstdio>

using namespace std;

const int move[8][2]={1,2, 2,1, 2,-1, 1,-2, -1,-2, -2,-1, -2,1, -1,2};

class tour {
	vector< vector< int > > board;
	int sx, sy, size;
		
public:
	bool findtour(tour& , int );
	
        // Constructor	
	tour(int s = 8, int startx = 1, int starty = 2)
		:sx(startx), sy(starty), size(s)
	{
		// Get the board to size x size
		board.resize(size);
		for(int i = 0; i < size; ++i)
			board[i].resize(size);

		// Fill the board with -1s
		for(int i = 0; i < size; ++i)
		  for(int j = 0; j < size; ++j) 
			board[i][j] = -1;

		// Move 0
		board[sx][sy] = 0;

		// Solve the problem
		if(!findtour(*this, 0)) 
		  cout << "No solutions found\n";
	}		
	
        // Copy constructor
	tour(const tour& T): sx(T.sx), sy(T.sy), size(T.size){
		this->board.resize(size);
		for(int i = 0; i < size; ++i)
			board[i].resize(size);

		// Copy the board
		for(int i = 0; i < size; ++i)
		  for(int j = 0; j < size; ++j)	
		    board[i][j] = T.board[i][j];
	}
	
        // Function to output class to ostream
        friend std::ostream& operator<<
	  ( std::ostream& os, const tour& T );
};

// Implementation of the overloaded << which is a friend of tour...
std::ostream& operator<<( std::ostream& os, const tour& T ){
  os << endl;
  int size = T.size;

  os << " +"; for(int i = 0; i < size*5-1; ++i) os << "-";
  os << "+\n";

  for(int i = 0; i < size; ++i){ 
    os << " | "; 
    for(int j = 0; j < size; ++j)
      os <<  setw(2) << T.board[i][j] << " | ";
    os << endl;

    os << " +"; for(int i = 0; i < size*5-1; ++i) os << "-";
    os << "+\n";

  }


  return os;
}

// A recursive function to find the knight tour.
bool tour::findtour(tour& T, int imove){
        if(imove == (size*size - 1)) return true;

        // make a move
	int cx = T.sx;
	int cy = T.sy;
        int cs = T.size;

        for ( int i = 0; i < 8; ++i){
	  int tcx = cx + move[i][0];
	  int tcy = cy + move[i][1];
	  if (
		  // Is this a valid move? 
                  (tcx >= 0) &&  (tcy >= 0)  &&  (tcx < cs) &&  (tcy < cs) &&
		  // Has this place been visited yet?
                  (T.board[tcx][tcy] == -1)
             ){
		tour temp(T);
		temp.board[tcx][tcy] = imove+1;
		temp.sx = tcx;
		temp.sy = tcy;
		if(findtour(temp, imove+1)) {
		  cout << "Solution found\n";
		  cout << temp << endl;
		  exit(1);
		}
   	  } // legal move?
        } // for
		
        return false;
}


int main(void){
	tour T;
	return 0;
}
