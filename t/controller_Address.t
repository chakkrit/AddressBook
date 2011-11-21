use strict;
use warnings;
use Test::More tests=> 6;
use Test::WWW::Mechanize::Catalyst;

BEGIN { $ENV{ADDRESSBOOK_CONFIG_LOCAL_SUFFIX}="test" }
BEGIN { use_ok 'AddressBook::Controller::Address'}
BEGIN { use_ok('Catalyst::Test', 'AddressBook') }

my $mech = Test::WWW::Mechanize::Catalyst->new({catalyst_app=>'AddressBook'});
ok( request('/address/edit')->is_success, 'Request should succeed' );

#-----------------------------------------------------------------
# Testing for Add method
$mech->get_ok('/address/add/1', 'got Add form');
#$mech->content_like(qr/Adding a new address \s* for Your Maxi/);
$mech->form_number(1);
$mech->field(location => 'Home');
$mech->field(postal => 'This is the postal address.');
$mech->field(phone => '123-456-7890');
$mech->field(email => 'test@example.com');
$mech->click('_submit');
#$mech->content_like(qr/Added new address for Your Maxi/);
#$mech->content_like(qr/This is the postal address[.]/);

#------------------------------------------------------------------
# Testing for Edit method
$mech->get_ok('/address/edit/3/1', 'get Edit form');
$mech->form_number(1);
$mech->field(phone => '789-234-5432');
$mech->click('_submit');
#$mech->content_like(qr/Updated address for Your Maxi/);

#------------------------------------------------------------------
#  Testing for Delete method
$mech->get_ok('/address/delete/3', 'got Delete form');
#$mech->content_like(qr/Deleted Your Maxi's Home address/);



done_testing();




