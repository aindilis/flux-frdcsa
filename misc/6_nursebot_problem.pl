zInit([
       in_room(andrewDougherty,room2),
       in_room(meredithMcGhan,R),
       in_room(eleanorDougherty,room6),
       request(room2,xRoom),
       request(room6,uRoom)
      ], squelch([R])).

:- dynamic examination_room/2.

problemInit([
	     examination_room(gRoom,room1),
	     examination_room(gRoom,room2),
	     examination_room(uRoom,room3),
	     examination_room(uRoom,room4),
	     examination_room(xRoom,room5),
	     examination_room(xRoom,room6)
	    ]).
