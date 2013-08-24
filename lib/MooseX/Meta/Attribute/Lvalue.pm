{
	package MooseX::Meta::Attribute::Lvalue;
	our $VERSION   = '0.05';
	our $AUTHORITY = 'cpan:TOBYINK';
	use Moose::Role;
}

{
	package MooseX::Meta::Attribute::Trait::Lvalue;
	our $VERSION   = '0.05';
	our $AUTHORITY = 'cpan:TOBYINK';
	use Moose::Role;
	has lvalue => (
		is        => 'rw',
		isa       => 'Bool',
		predicate => 'has_lvalue',
		trigger   => sub { require Carp; Carp::carp('setting lvalue=>1 on the attribute is deprecated') },
	);
}

{
	package Moose::Meta::Attribute::Custom::Trait::Lvalue;
	our $VERSION   = '0.05';
	our $AUTHORITY = 'cpan:TOBYINK';
	sub register_implementation { 'MooseX::Meta::Attribute::Trait::Lvalue' }
}

1;

__END__

=pod

=head1 NAME

MooseX::Meta::Attribute::Lvalue - lvalue attributes for Moose

=head1 SYNOPSIS

   package MyThing;
   use Moose;
   
   has name => (
      traits      => ['Lvalue'] ,
      is          => 'rw',
      isa         => 'Str',
      required    => 1,
   );
   
   package main;
   
   my $thing = MyThing->new(name => 'Foo');
   $thing->name = "Bar";
   print $thing->name;   # Bar

=head1 DESCRIPTION

WARNING: This module provides syntactic sugar at the expense of some 
Moose's encapsulation.  The Moose framework does not support type 
checking of Lvalue attributes.  You should only use this role when the 
convenience of the Lvalue attributes outweighs the need to type 
checking.

This package provides a Moose meta attribute via a role/trait that 
provides Lvalue accessors to your Moose attributes.  Which means that 
instead of writing:

   $thing->name("Foo");

You can use the more functional and natural appearing:

   $thing->name = "Foo";

For details of Lvalue implementation in Perl, please see: 
L<http://perldoc.perl.org/perlsub.html#Lvalue-subroutines>

=head1 AUTHOR

Christopher Brown, C<< <cbrown at opendatagroup.com> >>

=head1 BUGS

Please report any bugs or feature requests to:
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MooseX-Meta-Attribute-Lvalue>.

=head1 COPYRIGHT & LICENSE

Copyright 2013 Toby Inkster.

Copyright 2008 Christopher Brown.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
