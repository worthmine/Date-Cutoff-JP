[![Build Status](https://travis-ci.com/worthmine/Date-Cutoff-JP.svg?branch=master)](https://travis-ci.com/worthmine/Date-Cutoff-JP)
# NAME

Date::CutOff::JP - Get the day cutoff and payday for in Japanese timezone

# SYNOPSIS

    use Date::CutOff::JP;
    my $dco = Date::CutOff::JP->new({ cutoff => 0, late => 1, payday => 0 });
    my %calculated = $dco->calc_date('2019-01-01');
    print $calculated{'cutoff'}; # '2019-01-31'
    print $calculated{'payday'}; # '2019-02-28'

# DESCRIPTION

Date::CutOff::JP provides how to calculate the day cutoff and the payday from Japanese calender.

you can calculate the weekday for cutoff and paying without holiday in Japan.

## Accessor Methods

### cutoff()

get/set the day cutoff in every months. 0 means the end of the month.

### payday()

get/set the payday in every months. 0 means the end of the month.

### late()

get/set the lateness. 0 means the cutoff and payday is at same month.

The all you can set is Int of \[ 0 .. 2 \] 3 or more returns error.

## Method

### calc\_date($date)

returns hash value with keys below:

- cutoff

    The latest cutoff after $date.

- payday

    The latest payday after $date.

- is\_over ( maybe bad key name )

    Is or not that the cutoff is pending until next month.

# BUGS

Because of dependency: [Date::Japanese::Holiday](https://metacpan.org/pod/Date::Japanese::Holiday)

- 山の日

    11th of Aug is a holiday as '山の日' since 2016 but this module doesn't support it yet.

- 天皇即位の日

    1st of May is special holiday especially 2019 but this module doesn't support it yet.

# SEE ALSO

[Date::Simple](https://metacpan.org/pod/Date::Simple), [Date::Japanese::Holiday](https://metacpan.org/pod/Date::Japanese::Holiday)

# LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

worthmine <worthmine@cpan.org>
