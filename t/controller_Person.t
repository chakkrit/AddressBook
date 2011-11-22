use strict;
use warnings;
use Test::More tests => 14;
use Test::WWW::Mechanize::Catalyst;

BEGIN { $ENV{ADDRESSBOOK_CONFIG_LOCAL_SUFFIX}="test" }
BEGIN { use_ok 'AddressBook::Controller::Person'}
BEGIN { use_ok('Catalyst::Test', 'AddressBook') }

my $mech = Test::WWW::Mechanize::Catalyst->new({catalyst_app=>'AddressBook'});

#------------------------------------------------------------------
# Test for List method
ok( request('/person/list')->is_success, 'Request should succeed' );
$mech->get_ok('/person/list', 'got list page');



#-------------------------------------------------------------------
# Test for Edit method
ok( request('/person/edit/1')->is_success, 'Request should succeed' );
$mech->get_ok('/person/edit/1', 'got edit form to edit person1');
$mech->submit_form(
  with_fields => {
    firstname => 'Your',
    lastname => 'Maxi',
  }
);
ok $mech->success, 'trying to submit an updated name';
$mech->content_like(qr/Your Maxi/, 'Change Person1 from You Name to be Your Maxi');


#------------------------------------------------------------------
# Test for Add method
ok( request('/person/add')->is_success, 'Request should succeed' );
$mech->get_ok('/person/add', 'got edit form to add a new person');
$mech->submit_form(
  with_fields => {
    firstname => 'Lee',
    lastname  => 'Mouse',
  }
);
ok $mech->success, 'trying to submit a new name';
$mech->content_like(qr/Lee Mouse/, 'add one more person to database');

#-----------------------------------------------------------------
# Test for Delete method 
$mech->get_ok('/person/delete/2', 'delete Lee');
$mech->content_like(qr/Delete Lee/, 'deleteed a person');

#-----------------------------------------------------------------

done_testing();
