:- dynamic examination_room/2.

%% OBJECTS

isaDirectlyList([andrewDougherty],player).
isaDirectlyList([kitchen, office, hall, diningRoom, cellar],room).


%% INIT

zInit([
       location(desk, office),
       location(apple, kitchen),
       location(flashlight, desk),
       location(washingMachine, cellar),
       location(nani, washingMachine),
       location(broccoli, kitchen),
       location(crackers, kitchen),
       location(computer, office),
       location(envelope, desk),
       location(stamp, envelope),
       location(key, envelope),

       here(kitchen),

       opened(office, hall),
       opened(kitchen, office),
       opened(hall, diningRoom),
       opened(kitchen, cellar),
       opened(diningRoom, kitchen)

      ], squelch([R])).


problemInit([
	     keyForDoor(key,hall,diningRoom),

	     room(kitchen),
	     room(office),
	     room(hall),
	     room(diningRoom),
	     room(cellar),

	     door(office, hall),
	     door(kitchen, office),
	     door(hall, diningRoom),
	     door(kitchen, cellar),
	     door(diningRoom, kitchen),

	     edible(apple),
	     edible(crackers),

	     tastesYucky(broccoli)

	     ]).

%% GOALS

problemGoals([
	      location(nani,have)
	     ]).
