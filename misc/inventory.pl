:- dynamic hasInventory/3.

usuallyStocks(cvs,
	      [
	       progressoItalianWeddingSoup,
	       progressoChickenCornChowder,
	       rockstarEnergyDrink
	       ]).

usuallyStocks(Store,List) :-
	type(List,list),
	member(Item,List),
	assertz(usuallyStocks(Store,Item)),
	fail.
usuallyStocks(_,_).

hasInventory(Person,Item,TotalQty) :-
	person(Person),
	TotalQty is sum(Qty,
			(
			 controls(Person,Location),
			 hasInventory(Location,Item,Qty)
			)).

contains(Location1,Location3) :-
	contains(Location1,Location2),
	contains(Location2,Location3).

hasInventory(Location1,Item,TotalQty) :-
	location(Location1),
	TotalQty is sum(Qty,
			(
			 contains(Location1,Location2),
			 hasInventory(Location2,Item,Qty)
			)).

init :-
	residesAt(andrewDougherty,Residence),
	assertz([
		 hasInventory(Residence,progressoItalianWeddingSoup,2),
		 hasInventory(Residence,progressoChickenCornChowder,0),
		 hasInventory(Residence,rockstarEnergyDrink,0),
		 hasInventory(Residence,ripItSugarFreeEnergyDrink,2),
		 isOpened(Residence,ripItSugarFreeEnergyDrink,1)
		 ]).

% knows(resourceManager,[Location,Item,Qty],(hasInventory(Location,Item,Qty),Qty >= 1)) :-
% 	knows(resourceManager,[Location,Item],inStock(Location,Item)).

itemQuantity(Item,Qty) :-
    usuallyStocks(A,List),
    member(Item,List),
    hasInventory(A,Item,Qty).

%% get a list of item locations and their sublocations, and produce a
%% report of the inventory at each

inventoryReport :-
    write('Inventory report'), nl,
    itemQuantity(X,Y), tab(3), write(Y), tab(3), write(X), nl, fail.
inventoryReport.

goodCustomer(X) :- customer(X, Location, Aaa).
%% goodCustomer(X) :- customer(X, aurora, ).

validOrder(Customer,Item,OrderQty) :-
    goodCustomer(Customer),
    itemQuantity(Item,Qty),
    Qty >= OrderQty.
    
reorder(Item) :-
    forSale(A,Item,ReorderQty),
    itemQuantity(Item,Qty),
    ReorderQty >= Qty,
    write('Time to reorder '), write(Item), nl.
    
updateInventory(Item,Qty) :-
    canUpdateInventory(Item,Qty),
    doUpdateInventory(Item,Qty).

canUpdateInventory(Item,Qty) :-
    itemQuantity(Item,StockQty).
canUpdateInventory(Item,Qty) :-
    write('There is no record of this item being on inventory.'), nl,
    fail.

doUpdateInventory(Item,Qty) :-
    forSale(A,Item,_),
    retract(hasInventory(A,Item,Level)),
    NewLevel is Level + Qty,
    asserta(hasInventory(A,Item,NewLevel)),
    write('The inventory has been updated for '), write(Item),
    write(' to '), write(NewLevel), write('.'), nl.

order :-
    write('Enter customer name:'),nl,read(C),
    checkCustomer(C),
    write('Enter item name:'),nl,read(I),
    checkItem(I),
    write('Enter item quantity:'),nl,read(Q),
    checkQuantity(C,I,Q),
    Qprime is 0 - Q,
    doUpdateInventory(I,Qprime).
order :-
    write('The order cannot be filled now.').

checkCustomer(C) :-
    goodCustomer(C).
checkCustomer(C) :-
    write('We cannot perform an order for this customer.'), nl, fail.

checkItem(I) :-
    itemQuantity(I,Q).
checkItem(I) :-
    write('We do not currently stock this item.'), nl, fail.

checkQuantity(C,I,Q) :-
    validOrder(C,I,Q).
checkQuantity(C,I,Q) :-
    write('We do not have sufficient levels of stock to fill this order.'), 
    nl, fail.
