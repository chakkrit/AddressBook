use strict;
use warnings;
use Test::More;


use Catalyst::Test 'AddressBook';
use AddressBook::Controller::Person;

ok( request('/person')->is_success, 'Request should succeed' );
done_testing();
