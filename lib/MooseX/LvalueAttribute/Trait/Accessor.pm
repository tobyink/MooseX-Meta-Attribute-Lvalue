package MooseX::LvalueAttribute::Trait::Accessor;

our $VERSION   = '0.900_01';
our $AUTHORITY = 'cpan:TOBYINK';

use Moose::Role;

use Variable::Magic ();
use Hash::Util::FieldHash::Compat ();
use Scalar::Util ();

Hash::Util::FieldHash::Compat::fieldhash(our %LVALUES);

override _generate_accessor_method => sub
{
	my $self = shift;
	
	my $attr = $self->associated_attribute;
	my $attr_name = $attr->name;
	Scalar::Util::weaken($attr);
	
	return sub :lvalue {
		my $instance = shift;
		Scalar::Util::weaken($instance);
		
		unless (exists $LVALUES{$instance}{$attr_name})
		{
			my $wiz = Variable::Magic::wizard(
				set => sub { $attr->set_value($instance, ${$_[0]}) },
				get => sub { ${$_[0]} = $attr->get_value($instance); $_[0] },
			);
			Variable::Magic::cast($LVALUES{$instance}{$attr_name}, $wiz);
		}
		
		@_ and $attr->set_value($instance, $_[0]);
		$LVALUES{$instance}{$attr_name};
	};
};

1;
