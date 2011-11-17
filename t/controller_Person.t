use strict;
use warnings;
use Test::More;


use Catalyst::Test 'AddressBook';
use AddressBook::Controller::Person;

ok( request('/person/edit')->is_success, 'Request should succeed' );
ok( request('/person/list')->is_success, 'Request should succeed' );
ok( request('/person/add')->is_success, 'Request should succeed' );

done_testing();
