use strict;
use Test::More 0.98 tests => 24;
use Data::Dumper qw(Dumper);

use lib './lib';

use Date::CutOff::JP;
my $dco = Date::CutOff::JP->new({ cut_off => 10, late => 0, pay_day => 0 });

my %calc = $dco->calc_date('2019-01-15');
is $calc{cut_off}, '2019-02-10', "cut_off is ok for Jan.";
is $calc{pay_day}, '2019-02-28', "pay_day is ok for Jan.";

%calc = $dco->calc_date('2019-02-15');
is $calc{cut_off}, '2019-03-10', "cut_off is ok for Feb.";
is $calc{pay_day}, '2019-03-31', "pay_day is ok for Feb.";

%calc = $dco->calc_date('2019-03-15');
is $calc{cut_off}, '2019-04-10', "cut_off is ok for Mar.";
is $calc{pay_day}, '2019-04-30', "pay_day is ok for Mar.";

%calc = $dco->calc_date('2019-04-15');
is $calc{cut_off}, '2019-05-10', "cut_off is ok for Apr.";
is $calc{pay_day}, '2019-05-31', "pay_day is ok for Apr.";

%calc = $dco->calc_date('2019-05-15');
is $calc{cut_off}, '2019-06-10', "cut_off is ok for May.";
is $calc{pay_day}, '2019-06-30', "pay_day is ok for May.";

%calc = $dco->calc_date('2019-06-15');
is $calc{cut_off}, '2019-07-10', "cut_off is ok for Jun.";
is $calc{pay_day}, '2019-07-31', "pay_day is ok for Jun.";

%calc = $dco->calc_date('2019-07-15');
is $calc{cut_off}, '2019-08-10', "cut_off is ok for Jul.";
is $calc{pay_day}, '2019-08-31', "pay_day is ok for jul.";

%calc = $dco->calc_date('2019-08-15');
is $calc{cut_off}, '2019-09-10', "cut_off is ok for Aug.";
is $calc{pay_day}, '2019-09-30', "pay_day is ok for Aug.";

%calc = $dco->calc_date('2019-09-15');
is $calc{cut_off}, '2019-10-10', "cut_off is ok for Sep.";
is $calc{pay_day}, '2019-10-31', "pay_day is ok for Sep.";

%calc = $dco->calc_date('2019-10-15');
is $calc{cut_off}, '2019-11-10', "cut_off is ok for Oct.";
is $calc{pay_day}, '2019-11-30', "pay_day is ok for Oct.";

%calc = $dco->calc_date('2019-11-15');
is $calc{cut_off}, '2019-12-10', "cut_off is ok for Nov.";
is $calc{pay_day}, '2019-12-31', "pay_day is ok for Nov.";

%calc = $dco->calc_date('2019-12-15');
is $calc{cut_off}, '2020-01-10', "cut_off is ok for Dec.";
is $calc{pay_day}, '2020-01-31', "pay_day is ok for Dec.";

done_testing;
