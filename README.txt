mkdir -p /var/lib/myfrdcsa/sandbox/eclipse-basic-20160110/eclipse-basic-20160110

unzip eclipse_basic.tgz and eclipse_doc.tgz into this folder, then go back to whereever you unpacked flux-frdcsa and run

./flux-frdcsa security/security

The output should look like this:


andrewdo@ai:/var/lib/myfrdcsa/github/aindilis/flux-frdcsa$ ./flux-frdcsa security/security
./eclipse -f flux_frdcsa.pl -e "['data-git/capsules/security/security.d.pl'],['data-git/capsules/security/security.p.pl'],main"
Definition of forall/2 in module swi is incompatible (tool declaration) with call in module eclipse
Definition of forall/2 in module swi is incompatible (tool declaration) with call in module eclipse
File flux_frdcsa.pl, line 36: Singleton variable P2
File flux_frdcsa.pl, line 37: Singleton variable Plan


    zInit.
    [location(desk, office), location(apple, kitchen), location(flashlight, desk), location(washingMachine, cellar), location(nani, washingMachine), location(broccoli, kitchen), location(crackers, kitchen), location(computer, office), location(envelope, desk), location(stamp, envelope), location(cellarKey, envelope), here(kitchen), opened(office, hall), opened(kitchen, office), opened(hall, diningRoom), opened(diningRoom, kitchen), locked(kitchen, cellar)].

[location(59897774, 466286768837), location(5075402799, 48368685518133), location(40512427535335156244, 59897774), location(2397116116265836053325528849, 551826475005), location(58297720, 2397116116265836053325528849), location(4175286374579736, 48368685518133), location(4736705770667833, 48368685518133), location(4673138084372389, 466286768837), location(3954573800460443, 59897774), location(5864087169, 3954573800460443), location(465829143478994941, 3954573800460443), here(48368685518133), opened(466286768837, 60616850), opened(48368685518133, 466286768837), opened(60616850, 37243655612032929614), opened(37243655612032929614, 48368685518133), locked(48368685518133, 551826475005)|_308523]



--------------------------------------------

Plan found!

[Final state:, [have(cellarKey), here(office), location(desk, office), location(apple, kitchen), location(flashlight, desk), location(washingMachine, cellar), location(nani, washingMachine), location(broccoli, kitchen), location(crackers, kitchen), location(computer, office), location(envelope, desk), location(stamp, envelope), opened(office, hall), opened(kitchen, office), opened(hall, diningRoom), opened(diningRoom, kitchen), locked(kitchen, cellar), ]]

[action, [take(cellarKey), ]]

[Found plan:, [goto(kitchen, office), take(cellarKey), ]]
andrewdo@ai:/var/lib/myfrdcsa/github/aindilis/flux-frdcsa$ 
