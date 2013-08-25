package MooseX::LvalueAttribute::Trait::Attribute;

our $VERSION   = '0.900_01';
our $AUTHORITY = 'cpan:TOBYINK';

use Moose::Role;

has lvalue => (
	is        => 'rw',
	isa       => 'Bool',
	predicate => 'has_lvalue',
	trigger   => sub { require Carp; Carp::carp('setting lvalue=>1 on the attribute is deprecated') },
);

around accessor_metaclass => sub
{
	my $next = shift;
	my $self = shift;
	my $metaclass = $self->$next(@_);
	return Moose::Util::with_traits($metaclass, 'MooseX::LvalueAttribute::Trait::Accessor');
};

1;
