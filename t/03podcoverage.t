#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

=head1 NAME

Test::More podcoverage

=head1 DESCRIPTION

To test this POD use Test::Pod::Coverage version 1.04 and 
Pod::Coverage version 0.20 

=head1 METHODS

=cut


plan skip_all => 'set TEST_POD to enable this test' unless $ENV{TEST_POD};

eval "use Test::Pod::Coverage 1.04";
plan skip_all => 'Test::Pod::Coverage 1.04 required' if $@;

eval "use Pod::Coverage 0.20";
plan skip_all => 'Pod::Coverage 0.20 required' if $@;

all_pod_coverage_ok();
