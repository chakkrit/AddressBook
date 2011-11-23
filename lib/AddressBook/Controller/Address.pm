package AddressBook::Controller::Address;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }
extends 'Catalyst::Controller::FormBuilder';

=head1 NAME

AddressBook::Controller::Address - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 add

add new address data to database

=cut

sub add : Local Form('/address/edit'){
  my ($self, $c, $person_id) = @_;
  $c->go('edit', [undef, $person_id]);
}

=head2 edit

update address data in database

=cut

sub edit : Local Form {
  my ($self, $c, $address_id, $person_id) = @_;
  my $form = $self->formbuilder;
  my $address;

  if (!$address_id && $person_id) {
    my $person = $c->model('AddressDB::Person')->find({id => $person_id});
    if (!$person) {
      $c->stash->{error} = 'No such person!';
      $c->detach('/person/list');
    }
    $address = $c->model('AddressDB::Address')->new({person => $person});
  } else {
    $address = $c->model('AddressDB::Address')->find({id => $address_id});
    if (!$address) {
      $c->stash->{error} = 'No such address!';
      $c->detach('/person/list');
    }
  }
  if ($form->submitted && $form->validate) {
    $address->location($form->field('location'));
    $address->postal($form->field('postal'));
    $address->phone($form->field('phone'));
    $address->email($form->field('email'));
    $address->insert_or_update;
    $c->stash->{message} = ($address_id > 0 ? 'Updated ' : 'Added new ').'address for '.$address->person->name;
    $c->detach('/person/list');
  } else {
    $c->stash->{message} = $address;
    if (!$address_id) {
      $c->stash->{message} = 'Adding  a new address';
    } else {
      $c->stash->{message} = 'updating an address';
    }
    $c->stash->{message} .= ' for '.$address->person->name;
    $form->field(name => 'location', value => $address->location);
    $form->field(name => 'postal', value => $address->postal);
    $form->field(name => 'phone', value => $address->phone);
    $form->field(name => 'email', value => $address->email);
  } 
}

=head2 delete

delete address data in database

=cut

sub delete : Local {
  my ($self, $c, $address_id) = @_;
  my $address = $c->model('AddressDB::Address')->find({id => $address_id});
  if ($address) {
  $c->stash->{message} = 'Deleted ' . $address->person->name. q{'s }. $address->location. ' address';
  $address->delete; 
  } else {
    $c->stash->{error} = 'No such address';
  }
  $c->detach('/person/list');
}

=head1 AUTHOR

chakkrit,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

#__PACKAGE__->meta->make_immutable;

1;
