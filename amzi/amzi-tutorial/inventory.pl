:- dynamic inventory/2.

customer(mom,unknown,aaa).
customer(justin,unknown,aaa).

customer(andrew,address('<REDACTED>','<REDACTED>','<REDACTED>','<REDACTED>','<REDACTED>'),aaa).
customer(al,address(unknown,unknown,unknown,unknown,unknown),aaa).

for_sale(1,broccoli,3).
for_sale(2,tape,2).
for_sale(3,computer,1).

inventory(1,5).
inventory(2,4).
inventory(3,0).

item_quantity(X,Y) :-
    for_sale(A,X,_),
    inventory(A,Y).

inventory_report :-
    write('Inventory report'), nl,
    item_quantity(X,Y), tab(3), write(Y), tab(3), write(X), nl, fail.
inventory_report.

good_customer(X) :- customer(X, _, aaa).
% good_customer(X) :- customer(X, aurora, _).

valid_order(Customer,Item,OrderQty) :-
    good_customer(Customer),
    item_quantity(Item,Qty),
    Qty >= OrderQty.
    
reorder(Item) :-
    for_sale(_,Item,ReorderQty),
    item_quantity(Item,Qty),
    ReorderQty >= Qty,
    write('Time to reorder '), write(Item), nl.
    

update_inventory(Item,Qty) :-
    can_update_inventory(Item,Qty),
    do_update_inventory(Item,Qty).

can_update_inventory(Item,Qty) :-
    item_quantity(Item,StockQty).
can_update_inventory(Item,Qty) :-
    write('There is no record of this item being on inventory.'), nl,
    fail.

do_update_inventory(Item,Qty) :-
    for_sale(A,Item,_),
    retract(inventory(A,Level)),
    NewLevel is Level + Qty,
    asserta(inventory(A,NewLevel)),
    write('The inventory has been updated for '), write(Item),
    write(' to '), write(NewLevel), write('.'), nl.

order :-
    write('Enter customer name:'),nl,read(C),
    check_customer(C),
    write('Enter item name:'),nl,read(I),
    check_item(I),
    write('Enter item quantity:'),nl,read(Q),
    check_quantity(C,I,Q),
    Qprime is 0 - Q,
    do_update_inventory(I,Qprime).
order :-
    write('The order cannot be filled now.').

check_customer(C) :-
    good_customer(C).
check_customer(C) :-
    write('We cannot perform an order for this customer.'), nl, fail.

check_item(I) :-
    item_quantity(I,Q).
check_item(I) :-
    write('We do not currently stock this item.'), nl, fail.

check_quantity(C,I,Q) :-
    valid_order(C,I,Q).
check_quantity(C,I,Q) :-
    write('We do not have sufficient levels of stock to fill this order.'), 
    nl, fail.
