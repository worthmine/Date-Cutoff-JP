package Date::Weekend::JP;

our $VERSION = "0.01";

use base 'Date::Japanese::Holiday';

sub is_weekend {
    my $self = shift;
    return $self->is_holiday || $self->day_of_week == 6;
}

package Date::Cutoff::JP;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Time::Seconds;
use Time::Piece;
my $tp = Time::Piece->new();

use Class::Accessor qw(antlers);
has cutoff => ( is => 'rw', isa => 'Num', default => 0 );
has late    => ( is => 'rw', isa => 'Num', default => 1 );
has payday => ( is => 'rw', isa => 'Num', default => 0 );

sub calc_date {
    my $self = shift;
    my $until = shift if @_;
    my $t = $until? $tp->strptime( $until, '%Y-%m-%d' ) : localtime();
    
    my $cutoff = $self->cutoff? $self->cutoff: $t->month_last_day();
    my $str = $t->strftime('%Y-%m-') . sprintf( "%02d", $cutoff );
    my $ref_day = $t->strptime( $str, '%Y-%m-%d');
    my $over = 0;
    if ( $ref_day->epoch() < $t->epoch() ) {
        $over = 1;
        $ref_day += ONE_DAY() * $ref_day->month_last_day();
    }
    
    $cutoff = $ref_day->ymd();
    while( Date::Weekend::JP->new( split( "-", $cutoff ) )->is_weekend ){
        my $ref_day = $t->strptime( $cutoff, '%Y-%m-%d');
        $ref_day += ONE_DAY();
        $cutoff = $ref_day->ymd();
    }
    
    $ref_day += ONE_DAY() * 28 * ( $self->late || 0 );
    $str = $ref_day->strftime('%Y-%m-%d');
    $ref_day = $t->strptime( $str, '%Y-%m-%d');

    my $payday = $self->payday? $self->payday:  $ref_day->month_last_day();
    $str = $ref_day->strftime('%Y-%m-') . sprintf( "%02d", $payday );
    
    my $date = $t->strptime( $str, '%Y-%m-%d' )->ymd();
    while( Date::Weekend::JP->new( split( "-", $date ) )->is_weekend ){
        my $ref_day = $t->strptime( $date, '%Y-%m-%d');
        $ref_day += ONE_DAY();
        $date = $ref_day->ymd();
    }
    return ( cutoff => $cutoff, payday => $date, is_over => $over );
}

1;
__END__

=encoding utf-8

=head1 NAME

Date::CutOff::JP - Get the day cutoff and payday for in Japanese timezone

=head1 SYNOPSIS

 use Date::CutOff::JP;
 my $dco = Date::CutOff::JP->new({ cutoff => 0, late => 1, payday => 0 });
 my %calculated = $dco->calc_date('2019-01-01');
 print $calculated{'cutoff'}; # '2019-01-31'
 print $calculated{'payday'}; # '2019-02-28'


=head1 DESCRIPTION

Date::CutOff::JP provides how to calculate the day cutoff and the payday from Japanese calender.
you can calculate the weekday for cutoff and paying without holiday in Japan.
 
=head1 BUGS

Because of dependency: L<Date::Japanese::Holiday>
 
=over
 
=item 山の日

11th of Aug is a holiday as '山の日' since 2016 but this module doesn't support it yet.

=item 天皇即位の日

1st of May is special holiday especially 2019 but this module doesn't support it yet.
 
=back
 
=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

worthmine E<lt>worthmine@cpan.orgE<gt>

=cut

