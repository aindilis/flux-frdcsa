mkdir -p /var/lib/myfrdcsa/sandbox/eclipse-basic-20160110/eclipse-basic-20160110

unzip eclipse_basic.tgz and eclipse_doc.tgz into this folder, then go back to whereever you unpacked flux-frdcsa and run

./flux-frdcsa amzibot/amzibot

The output should look like this:



andrewdo@ai:/var/lib/myfrdcsa/codebases/minor/flux-frdcsa$ ./flux-frdcsa amzibot/amzibot
./eclipse -f flux_frdcsa.pl -e "['data-git/capsules/amzibot/amzibot.d.pl'],['data-git/capsules/amzibot/amzibot.p.pl'],main"
Definition of forall/2 in module swi is incompatible (tool declaration) with call in module eclipse
Definition of forall/2 in module swi is incompatible (tool declaration) with call in module eclipse


    zInit.
    [location(desk, office), location(apple, kitchen), location(flashlight, desk), location(washingMachine, cellar), location(nani, washingMachine), location(broccoli, kitchen), location(crackers, kitchen), location(computer, office), location(envelope, desk), location(stamp, envelope), location(key, envelope), here(kitchen), opened(office, hall), opened(kitchen, office), opened(hall, diningRoom), opened(kitchen, cellar), opened(diningRoom, kitchen)].


Trying queued branch: 
[branch, []]



[actions, [goto(kitchen, office), goto(kitchen, cellar), take(apple), take(broccoli), take(crackers), ]]

[action, [goto(kitchen, office), ]]
[branch2, [goto(kitchen, office), ]]

[action, [goto(kitchen, cellar), ]]
[branch2, [goto(kitchen, cellar), ]]

[action, [take(apple), ]]
[branch2, [take(apple), ]]

[action, [take(broccoli), ]]
[branch2, [take(broccoli), ]]

[action, [take(crackers), ]]
[branch2, [take(crackers), ]]


Trying queued branch: 
[branch, [goto(kitchen, office), ]]



[actions, [goto(office, hall), take(desk), take(computer), take(flashlight), take(envelope), take(stamp), take(key), ]]

[action, [goto(office, hall), ]]
[branch2, [goto(kitchen, office), goto(office, hall), ]]

[action, [take(desk), ]]
[branch2, [goto(kitchen, office), take(desk), ]]

[action, [take(computer), ]]
[branch2, [goto(kitchen, office), take(computer), ]]

[action, [take(flashlight), ]]
[branch2, [goto(kitchen, office), take(flashlight), ]]

[action, [take(envelope), ]]
[branch2, [goto(kitchen, office), take(envelope), ]]

[action, [take(stamp), ]]
[branch2, [goto(kitchen, office), take(stamp), ]]

[action, [take(key), ]]
[branch2, [goto(kitchen, office), take(key), ]]


Trying queued branch: 
[branch, [goto(kitchen, cellar), ]]



[actions, [take(washingMachine), take(nani), ]]

[action, [take(washingMachine), ]]
[branch2, [goto(kitchen, cellar), take(washingMachine), ]]

[action, [take(nani), ]]
[branch2, [goto(kitchen, cellar), take(nani), ]]



--------------------------------------------

Plan found!

[Final state:, [have(nani), here(cellar), location(desk, office), location(apple, kitchen), location(flashlight, desk), location(washingMachine, cellar), location(broccoli, kitchen), location(crackers, kitchen), location(computer, office), location(envelope, desk), location(stamp, envelope), location(key, envelope), opened(office, hall), opened(kitchen, office), opened(hall, diningRoom), opened(kitchen, cellar), opened(diningRoom, kitchen), ]]

[action, [take(nani), ]]

[Found plan:, [goto(kitchen, cellar), take(nani), ]]
andrewdo@ai:/var/lib/myfrdcsa/codebases/minor/flux-frdcsa$ 
