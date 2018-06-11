:- dynamic examination_room/2.

%% OBJECTS

isaDirectlyList([andrewDougherty],player).
isaDirectlyList([kitchen, office, hall, diningRoom, cellar],room).


%% INIT

%% these are wrapped in holds
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
       location(cellarKey, envelope),

       %% have(cellarKey),

       here(kitchen),

       opened(office, hall),
       opened(kitchen, office),
       opened(hall, diningRoom),
       %% opened(kitchen, cellar),
       opened(diningRoom, kitchen),

       locked(kitchen, cellar)

      ], (squelch([R]),R)).

%% these are not wrapped in holds
problemInit([
	     keyForDoor(cellarKey,kitchen,cellar),

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
	      have(cellarKey)
	      %% here(cellar)
	     ]).
