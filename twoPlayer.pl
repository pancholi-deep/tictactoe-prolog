
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
				
other(x,o).
other(o,x).

/*
game(Board, Player) :- win(Board,Player), 
					   format('Player ~w wins!', [Player]).
*/					   

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
					   
display([A,B,C,D,E,F,G,H,I]) :- write([A,B,C]),nl,
								write([D,E,F]),nl,
								write([G,H,I]),nl,nl.
					   
twoPlayer :- explain, game([' ',' ',' ',' ',' ',' ',' ',' ',' '],x).

explain :- write('Each Player (x first) can play by entering respective integer positions.'), nl,
		   display([1,2,3,4,5,6,7,8,9]).