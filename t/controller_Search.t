use strict;
use warnings;
use Test::More tests => 10;
use Test::WWW::Mechanize::Catalyst;

BEGIN { $ENV{ADDRESSBOOK_CONFIG_LOCAL_SUFFIX}="test" }
BEGIN { use_ok 'AddressBook::Controller::Search'}
BEGIN { use_ok('Catalyst::Test', 'AddressBook') }

my $mech = Test::WWW::Mechanize::Catalyst->new({catalyst_app=>'AddressBook'});

#----------------------------------------------------------------------
# Testing Name Search
#----------------------------------------------------------------------
ok( request('/search')->is_success, 'Request should succeed' );
$mech->get_ok('/search', 'got search page');
$mech->submit_form(
  with_fields => {
    query => 'Your',
    domain => 'Names', 
  }
);

ok $mech->success, 'To submit Name search for exist example data';
$mech->content_like(qr/Your Maxi/, 'Get the result when submit to search Name');

#-----------------------------------------------------------------------
# Testing Address Search
#----------------------------------------------------------------------- 
ok( request('/search')->is_success, 'Request should succeed' );
$mech->get_ok('/search', 'got search page');
$mech->submit_form(
  with_fields => {
    query => 'Green',
    domain => 'Addresses', 
  }
);

ok $mech->success, 'To submit Address search for exist example data';
$mech->content_like(qr/Home/, 'Get the result when submit to search Address');

#-----------------------------------------------------------------------

done_testing();
