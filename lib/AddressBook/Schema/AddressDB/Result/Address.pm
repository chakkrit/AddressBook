use utf8;
package AddressBook::Schema::AddressDB::Result::Address;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AddressBook::Schema::AddressDB::Result::Address

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<addresses>

=cut

__PACKAGE__->table("addresses");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 person

  data_type: 'integer'
  is_nullable: 0

=head2 location

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 postal

  data_type: 'text'
  is_nullable: 1

=head2 phone

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "person",
  { data_type => "integer", is_nullable => 0 },
  "location",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "postal",
  { data_type => "text", is_nullable => 1 },
  "phone",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-16 09:01:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OhGQBJolqV3So2MR+Zi0wQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
__PACKAGE__->belongs_to(
  person => 'AddressBook::Schema::AddressDB::Result::Person');
1;
