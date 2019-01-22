package Date::CutOff::JP;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Time::Seconds;
use Time::Piece;
my $tp = Time::Piece->new();

use Class::Accessor qw(antlers);
has cut_off => ( is => 'rw', isa => 'Num' );
has late    => ( is => 'rw', isa => 'Num' );
has pay_day => ( is => 'rw', isa => 'Num' );

sub calc_date {
    my $self = shift;
    my $until = shift if @_;
    my $t = $until? $tp->strptime( $until, '%Y-%m-%d' ) : localtime();
    
    my $cut_off = $self->cut_off? $self->cut_off: $t->month_last_day();
    my $str = $t->strftime('%Y-%m-') . sprintf( "%02d", $cut_off );
    my $ref_day = $t->strptime( $str, '%Y-%m-%d');
    my $over = 0;
    if ( $ref_day->epoch() < $t->epoch() ) {
        $over = 1;
        $ref_day += ONE_DAY() * $ref_day->month_last_day();
    }
    $cut_off = $ref_day->ymd();
    $ref_day += ONE_DAY() * 28 * ( $self->late || 0 );
    $str = $ref_day->strftime('%Y-%m-%d');
    $ref_day = $t->strptime( $str, '%Y-%m-%d');

    $str = $ref_day->strftime('%Y-%m-') . sprintf( "%02d",
        $self->pay_day? $self->pay_day:  $ref_day->month_last_day()
    );
    
    my $date = $t->strptime( $str, '%Y-%m-%d' )->ymd();
    return ( cut_off => $cut_off, pay_day => $date, is_over => $over );
}

1;
__END__

=encoding utf-8

=head1 NAME

Date::CutOff::JP - It's new $module

=head1 SYNOPSIS

    use Date::CutOff::JP;

=head1 DESCRIPTION

Date::CutOff::JP is ...

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

worthmine E<lt>worthmine@cpan.orgE<gt>

=cut

