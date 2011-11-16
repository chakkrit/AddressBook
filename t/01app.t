#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

=head1 NAME

Finding Root Testing Unit

=head1 DESCRIPTION

use Test::More ok function to find root request 

=head1 METHODS

=cut


use Catalyst::Test 'AddressBook';

ok( request('/')->is_success, 'Request should succeed' );

done_testing();
