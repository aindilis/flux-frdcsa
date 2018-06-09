(have to think, how to formalize this)

(have to be at the store to purchase it)
(can reuse the domain information from the other domains about
 moving to different locations

(should have tests to determine what the inventory level for
 different items that we don't know the level of)

(should have situation constraints that say that we were never
 out of a given item, or bounds on how long we're out, etc)

(should have plan quality constraints that minimize the amount of
 time spent)

(should integrate with our system so we can use barcode readers
 to mark items consumed, etc.)

(should have certain items marked for repurchase)

(scan grocery receipts)

(make interface with FreeLifePlanner)

(can have hasInventory(foodType1,X), and
 hasInventory(foodType2,Y) and genls(foodType1,foodType2) and
 then use uncertainty that when we say consumed(foodType2,Z),
 such that this might possibly mean we have consume 0..Z of
 foodType1, but leave it uncertain)

(so the goal formula is to hold over the whole time that we are
 getting work done.  should represent the preconditions using
 precondition axioms)


(look into object orientation in prolog, for saying things like
 townhome->upstairsLevel->fridge)

(Be sure to have it not know that there is inventory in stock
 unless it is explicitly checked, like online or through a phone
 call.  try to make an API to check automatically online.)

(create the ability to purchase things using two seperate funds,
 like cash and a gift card.  obviously dependent on who will do
 that kind of transaction - difficult in general to order online
 using seperate payment methods for instance.)

(create the ability to plan out purchases, such as taking into
 account different coupons or combo deals or what not.)

(try to borrow from other domains)

