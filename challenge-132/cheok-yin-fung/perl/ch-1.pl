#!/usr/bin/perl
# The Weekly Challenge 131
# Task 1 Mirror Dates
# Usage: ch-1.pl YYYY/MM/DD
use v5.24.0;
use warnings;
use Time::Local qw'timelocal timegm_nocheck';
use Test::More tests => 3;

say mirror_str($ARGV[0]) if defined($ARGV[0]);

sub mirror {
    my @arr_today = (22, 8, 2021); # Wed Sep 22 2021
    my $_today = timelocal(0, 0, 0, @arr_today);
    my @arr_birth = ($_[2], $_[1]-1, $_[0]);
    my $_birth = timelocal(0, 0, 0, @arr_birth);
    my $sec_diff = $_today - $_birth;
    my $y1 = int (($_today - $_birth)/86400);
    my @d_senior = localtime timegm_nocheck 0, 0, 0, $arr_birth[0]-$y1, $arr_birth[1], $arr_birth[2]; 
    my @d_junior = localtime timegm_nocheck 0, 0, 0, $arr_today[0]+$y1, $arr_today[1], $arr_today[2]; 
    return [ [@d_senior], [@d_junior] ];
}

sub mirror_str {
    my ($byear, $bmonth, $bday) = split /\//, $_[0];
    $bmonth =~ s/^0//;  # remove leading zeros
    $bday =~ s/^0//;    # remove leading zeros
    my ($d_s, $d_j) = mirror($byear, $bmonth, $bday)->@*;

    return 
         ($d_s->[5]+1900)."/"
        .($d_s->[4]<=8 ? 0 : "").($d_s->[4]+1)."/"
        .($d_s->[3]<10 ? 0 : "").($d_s->[3])
        .", "
        .($d_j->[5]+1900)."/"
        .($d_j->[4]<=8 ? 0 : "").($d_j->[4]+1)."/"
        .($d_j->[3]<10 ? 0 : "").($d_j->[3]);
}

ok mirror_str("2021/09/18") eq "2021/09/14, 2021/09/26", "Example 1";
ok mirror_str("1975/10/10") eq "1929/10/27, 2067/09/05", "Example 2";
ok mirror_str("1967/02/14") eq "1912/07/08, 2076/04/30", "Example 3";
