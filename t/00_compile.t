use strict;
use Test::More 0.98;
use Data::Dumper qw(Dumper);

use lib './lib';

use_ok $_ for qw(
    Date::CutOff::JP
);

use Date::Japanese::Holiday;

my $day = [qw( 2019 5 3 )];

my $date = Date::Simple->new(@$day);
if ($date->is_holiday) {
    note join( "/", @$day ) . " is a holiday!";
}

#note Dumper \%calc;

done_testing;

