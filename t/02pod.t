#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;


=head1 NAME

Testing POD files

=head1 DESCRIPTION

To make a plan for POD testing

=head1 METHODS

=cut

BEGIN { $ENV{ADDRESSBOOK_CONFIG_LOCAL_SUFFIX}="test" }

#plan skip_all => 'set TEST_POD to enable this test' unless $ENV{TEST_POD};

eval "use Test::Pod";
plan skip_all => 'Test::Pod 1.14 required' if $@;

all_pod_files_ok();
