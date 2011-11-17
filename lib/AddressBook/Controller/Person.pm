package AddressBook::Controller::Person;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }
extends 'Catalyst::Controller::FormBuilder';

=head1 NAME

AddressBook::Controller::Person - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;

#    $c->response->body('Matched AddressBook::Controller::Person in Person.');
#}

sub list : Local {
    my ($self, $c) = @_;
    my $people = $c->model('AddressDB::Person');
    $c->stash->{people} = $people;
    $c->stash( template => 'person/list.tt2' );
}

sub delete : Local {
    my ($self, $c, $id) = @_;
    my $person = $c->model('AddressDB::Person')->find({id => $id});
    $c->stash->{person} = $person;
    if($person) {
      $c->stash->{message} = 'Delete '. $person->name;
      $person->delete;
    } else {
      $c->response->status(404);
      $c->stash->{error} = "No person $id";
    }

    $c->detach('list');
}

sub edit : Local Form {
  my ($self, $c, $id) = @_;
  my $form = $self->formbuilder;
  my $person = $c->model('AddressDB::Person')->find_or_new(id => $id);
  if ($form->submitted && $form->validate) {
    $person->firstname($form->field('firstname'));
    $person->lastname($form->field('lastname'));
    $person->update_or_insert;
    $c->stash->{message} = ($id>0?'Updated':'Added').$person->name;
    $c->detach('list');
  } else {
    if(!$id){
      $c->stash->{message} = 'Adding a new person';
    }
    $form->field(name => 'firstname', value => $person->firstname);
    $form->field(name => 'lastname', value => $person->lastname);
  }
}

=head1 AUTHOR

chakkrit,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

#__PACKAGE__->meta->make_immutable;

1;
