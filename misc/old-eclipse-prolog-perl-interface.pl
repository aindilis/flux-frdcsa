#!/usr/bin/perl -w

use System::EclipseProlog;

use PerlLib::SwissArmyKnife;

my $eclipseprolog = System::EclipseProlog->new();

$eclipseprolog->StartServer(File => '6_nursebot_canonical.pl');
my $res1 = $eclipseprolog->ProcessInteraction(Query => 'main.');
my $res2 = $eclipseprolog->ProcessInteraction(Query => 'scry(isa(X,Y)).');
print Dumper({Res => [$res1,$res2]});

# use System::EclipseProlog::UniLang::Client;
# use System::Enju::UniLang::Client;
