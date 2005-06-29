use Test::More tests => 3;

use Bio::Medpost;

ok($r = Bio::Medpost::medpost_file('t/rawtextfile'));
is($r->[2][0], 'purpose');
is($r->[2][1], 'NN');
