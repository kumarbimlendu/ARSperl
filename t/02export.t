#!perl

use ARS;
require './config.cache';

print "1..5\n";

my($ctrl) = ars_Login(&CCACHE::SERVER, &CCACHE::USERNAME, &CCACHE::PASSWORD);
if(!defined($ctrl)) {
  print "not ok (login $ars_errstr)\n";
  exit 0;
}

my $d = "aptest.def";
if(ars_APIVersion() >= 4) {
  $d = "aptest50.def";
}

my $def = "";
my $c = 1;

my @objects =  ("schema", "ARSperl Test",
		"schema", "ARSperl Test2",
		"schema", "ARSperl Test-join",
		"filter", "ARSperl Test-filter");

my $junk = ars_Export($ctrl, undef, 0, "schema", "blarg292394");
if (defined($junk)) {
  print "not ok [$c]\n";
} else {
  print "ok [$c]\n";
}
$c++;

for (my $i = 0 ; $i < $#objects ; $i += 2) {
  print $objects[$i], "><", $objects[$i+1], "\n";

  my $d2 .= ars_Export($ctrl, undef, 0, $objects[$i], $objects[$i+1]);
  if (!defined($d2)) {
    print "not ok [$c] ($ars_errstr)\n";
  } else {
    print "ok [$c] ($ars_errstr)\n";
  }
  $c++;
  $def .= $d2;
}

ars_Logoff($ctrl);

exit(0);
