use strict;
use warnings;
use Test::More tests => 8;
use Test::WWW::Mechanize::Catalyst;

BEGIN { $ENV{ADDRESSBOOK_CONFIG_LOCAL_SUFFIX}="test" }
BEGIN { use_ok 'AddressBook::Controller::Person'}
BEGIN { use_ok('Catalyst::Test', 'AddressBook') }

my $mech = Test::WWW::Mechanize::Catalyst->new({catalyst_app=>'AddressBook'});
#------------------------------------------------------
ok( request('/person/edit')->is_success, 'Request should succeed' );
$mech->get_ok('person/edit', 'got edit form');
$mech->submit_form(
  with_fields => {
    firstname => 'Lee',
    lastname => 'Tony',
  }
);
ok $mech->success, 'trying to submit new person name';
$mech->content_like(qr/Lee Tony/, 'added a very new person');

#-------------------------------------------------------
ok( request('/person/list')->is_success, 'Request should succeed' );
ok( request('/person/add')->is_success, 'Request should succeed' );

done_testing();
