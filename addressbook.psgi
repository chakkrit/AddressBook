use strict;
use warnings;

use AddressBook;

my $app = AddressBook->apply_default_middlewares(AddressBook->psgi_app);
$app;

