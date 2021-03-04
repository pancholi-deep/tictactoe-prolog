/* winning conditions */
win(Board, Player) :- rowwin(Board, Player).
win(Board, Player) :- colwin(Board, Player).
win(Board, Player) :- diagwin(Board, Player).

rowwin(Board, Player) :- Board = [Player,Player,Player,_,_,_,_,_,_].
rowwin(Board, Player) :- Board = [_,_,_,Player,Player,Player,_,_,_].
rowwin(Board, Player) :- Board = [_,_,_,_,_,_,Player,Player,Player].

colwin(Board, Player) :- Board = [Player,_,_,Player,_,_,Player,_,_].
colwin(Board, Player) :- Board = [_,Player,_,_,Player,_,_,Player,_].
colwin(Board, Player) :- Board = [_,_,Player,_,_,Player,_,_,Player].

diagwin(Board, Player) :- Board = [Player,_,_,_,Player,_,_,_,Player].
diagwin(Board, Player) :- Board = [_,_,Player,_,Player,_,Player,_,_].

/* computer moves */
move([' ',B,C,D,E,F,G,H,I], Player, [Player,B,C,D,E,F,G,H,I]).
move([A,' ',C,D,E,F,G,H,I], Player, [A,Player,C,D,E,F,G,H,I]).
move([A,B,' ',D,E,F,G,H,I], Player, [A,B,Player,D,E,F,G,H,I]).
move([A,B,C,' ',E,F,G,H,I], Player, [A,B,C,Player,E,F,G,H,I]).
move([A,B,C,D,' ',F,G,H,I], Player, [A,B,C,D,Player,F,G,H,I]).
move([A,B,C,D,E,' ',G,H,I], Player, [A,B,C,D,E,Player,G,H,I]).
move([A,B,C,D,E,F,' ',H,I], Player, [A,B,C,D,E,F,Player,H,I]).
move([A,B,C,D,E,F,G,' ',I], Player, [A,B,C,D,E,F,G,Player,I]).
move([A,B,C,D,E,F,G,H,' '], Player, [A,B,C,D,E,F,G,H,Player]).

x_can_win_in_one(Board) :- move(Board, x, Newboard), win(Newboard, x).

/* The predicate orespond generates the computers (playing o) reponse from the current Board.
   to check if computer can win in next move */
orespond(Board,Newboard) :- move(Board, o, Newboard),
							win(Newboard, o).
							
/* to check if user can win in next move, if yes block that move(go to next rule) */
orespond(Board,Newboard) :- move(Board, o, Newboard), 
							not(x_can_win_in_one(Newboard)).
							
/* if user can win in next move, mark that move as O */
orespond(Board,Newboard) :- move(Board, o, Newboard).

/* check if no cell is empty, then its a draw. */
orespond(Board,Newboard) :- /* not(member(' ',Board)),*/
							write('Draw Game!'), nl,
							Newboard = Board.

/*human moves*/							
xmove([' ',B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xmove([A,' ',C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xmove([A,B,' ',D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xmove([A,B,C,' ',E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xmove([A,B,C,D,' ',F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xmove([A,B,C,D,E,' ',G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xmove([A,B,C,D,E,F,' ',H,I], 7, [A,B,C,D,E,F,x,H,I]).
xmove([A,B,C,D,E,F,G,' ',I], 8, [A,B,C,D,E,F,G,x,I]).
xmove([A,B,C,D,E,F,G,H,' '], 9, [A,B,C,D,E,F,G,H,x]).
xmove(Board, _, Board) :- write('Illegal move.'), nl.

/*game control*/
game1(Board) :- win(Board, x), write('You win!').
game1(Board) :- win(Board, o), write('I win!').
game1(Board) :- read(N),
				xmove(Board, N, Newboard),
				write('After your move: '), nl, 
			    display(Newboard),
		 	    orespond(Newboard, Newnewboard), 
				write('After computer move: '), nl, 
			    display(Newnewboard),
		 	    game1(Newnewboard).

/*display the board*/				
display([A,B,C,D,E,F,G,H,I]) :- write([A,B,C]),nl,
								write([D,E,F]),nl,
								write([G,H,I]),nl,nl.

/*start game*/
explain1 :- write('You play X by entering integer positions followed by a period.'), nl,
		    display([1,2,3,4,5,6,7,8,9]).
				
onePlayer :- explain1, game1([' ',' ',' ',' ',' ',' ',' ',' ',' ']).
			
			
/*TWO PLAYERS PART:*/

/* user moves*/
usermove([' ',B,C,D,E,F,G,H,I], 1, Player, [Player,B,C,D,E,F,G,H,I]).
usermove([A,' ',C,D,E,F,G,H,I], 2, Player, [A,Player,C,D,E,F,G,H,I]).
usermove([A,B,' ',D,E,F,G,H,I], 3, Player, [A,B,Player,D,E,F,G,H,I]).
usermove([A,B,C,' ',E,F,G,H,I], 4, Player, [A,B,C,Player,E,F,G,H,I]).
usermove([A,B,C,D,' ',F,G,H,I], 5, Player, [A,B,C,D,Player,F,G,H,I]).
usermove([A,B,C,D,E,' ',G,H,I], 6, Player, [A,B,C,D,E,Player,G,H,I]).
usermove([A,B,C,D,E,F,' ',H,I], 7, Player, [A,B,C,D,E,F,Player,H,I]).
usermove([A,B,C,D,E,F,G,' ',I], 8, Player, [A,B,C,D,E,F,G,Player,I]).
usermove([A,B,C,D,E,F,G,H,' '], 9, Player, [A,B,C,D,E,F,G,H,Player]).
usermove(Board, _, _, Board) :- write('Illegal move.'), nl.		

/*switching control*/
other(x,o).
other(o,x).

/*game control*/
game(Board, Player) :- other(Player,Otherplayer),
					   % write(Otherplayer),
					   win(Board, Otherplayer), 
					   format('Player ~w wins!', [Otherplayer]).
					
game(Board, _) :- not(member(' ',Board)),
				  write('Draw Game!'), nl.

game(Board, Player) :- format('Player ~w enter a move: ', [Player]),
					   read(N),
					   usermove(Board, N, Player,Newboard),
					   display(Newboard),
					   other(Player,Otherplayer),
				       game(Newboard,Otherplayer).
					   
/*start game*/			  
twoPlayer :- explain, game([' ',' ',' ',' ',' ',' ',' ',' ',' '],x).

explain :- write('Each Player (x first) can play by entering respective integer positions.'), nl,
		   display([1,2,3,4,5,6,7,8,9]).