requires 'perl', '5.008001';
requires 'Time::Seconds';
requires 'Time::Piece';
requires 'Date::Japanese::Holiday';
requires 'Class::Accessor';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

