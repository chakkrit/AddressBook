use utf8;
package AddressBook::Schema::AddressDB::Result::Person;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AddressBook::Schema::AddressDB::Result::Person

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

=head1 TABLE: C<people>

=cut

__PACKAGE__->table("people");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 firstname

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 lastname

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "firstname",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "lastname",
  { data_type => "varchar", is_nullable => 0, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07012 @ 2011-11-16 09:01:57
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fuAFVRFuN7wbXIgQ2YtCFw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
__PACKAGE__->has_many(
  address => 'AddressBook::Schema::AddressDB::Result::Address', 'person', {cascading_delete => 1} );

=head2 name

  Combine a firstname and a lastname tobe a fullname

=cut

sub name {
  my $self = shift;
  return $self->firstname.' '.$self->lastname;
}

__PACKAGE__->add_unique_constraint(name => [qw/firstname lastname/]);
1;
