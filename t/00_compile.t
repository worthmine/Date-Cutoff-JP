use strict;
use Test::More 0.98 tests => 15;

use lib './lib';

use_ok $_ for qw(Date::Cutoff::JP);                                                     # 1
my $dco = new_ok('Date::Cutoff::JP');                                                   # 2

is eval{ $dco->cutoff(-1) }, undef, "Fail to assign too small cutoff";                  # 3
is eval{ $dco->cutoff(29) }, undef, "Fail to assign too big cutoff";                    # 4

is eval{ $dco->payday(-1) }, undef, "Fail to assign too small payday";                  # 5
is eval{ $dco->payday(29) }, undef, "Fail to assign too big payday";                    # 6

is eval{ $dco->late(-1) }, undef, "Fail to assign too small lateness";                  # 7
is eval{ $dco->late(4) }, undef, "Fail to assign too big lateness";                     # 8

$dco = Date::Cutoff::JP->new({ cutoff => 10, late => 0 }); # payday is 0 automatically

is eval{ $dco->payday(1) }, undef, "Fail to assign too ealier payday";                  # 9
is eval{ $dco->payday(10) }, undef, "Fail to assign payday that is equal to cutoff";    #10
is $dco->payday(0), 0, "Succeed to assign payday correctly with 0";                     #11
is $dco->payday(11), 11, "Succeed to assign payday correctly";                          #12
is eval{ $dco->cutoff(20) }, undef, "Fail to assign too later cutoff";                  #13
is eval{ $dco->cutoff(0) }, undef, "Fail to assign too later cutoff with 0";            #14
is $dco->cutoff(1), 1, "Succeed to assign cutoff correctly";                            #15



done_testing;
