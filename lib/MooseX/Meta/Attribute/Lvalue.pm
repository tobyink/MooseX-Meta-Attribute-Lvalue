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

This package provides a Moose attribute trait that provides Lvalue accessors.
Which means that instead of writing:

   $thing->name("Foo");

You can use the more natural looking:

   $thing->name = "Foo";

For details of Lvalue implementation in Perl, please see: 
L<http://perldoc.perl.org/perlsub.html#Lvalue-subroutines>

Type constraints and coercions still work for lvalue attributes. Triggers
still fire. Everything should just work. (Unless it doesn't.)

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=MooseX-Meta-Attribute-Lvalue>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

Based on work by
Christopher Brown, C<< <cbrown at opendatagroup.com> >>

=head1 SEE ALSO

L<MooX::LvalueAttribute>,
L<Object::Tiny::Lvalue>.

=head1 COPYRIGHT & LICENCE

This software is copyright (c) 2013 by Toby Inkster;
2008 by Christopher Brown.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=cut

