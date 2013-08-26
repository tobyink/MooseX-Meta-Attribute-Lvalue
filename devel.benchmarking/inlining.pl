use strict;
use warnings;
no warnings 'once';
use Benchmark ':all';

{
	package Goose1;
	use Moose;
	use MooseX::LvalueAttribute 'lvalue';
	
	local $MooseX::LvalueAttribute::INLINE = 0;
	has eggs => (
		traits  => [ lvalue ],
		is      => 'rw',
#		isa     => 'Int',
		default => 0,
	);
}

{
	package Goose2;
	use Moose;
	use MooseX::LvalueAttribute 'lvalue';
	
	has eggs => (
		traits  => [ lvalue ],
		is      => 'rw',
#		isa     => 'Int',
		default => 0,
	);
}

cmpthese(-3, {
	standard => q{ my $goose = Goose1->new; $goose->eggs++ for 1..1000; die unless $goose->eggs == 1000 },
	inlined  => q{ my $goose = Goose2->new; $goose->eggs++ for 1..1000; die unless $goose->eggs == 1000 },
});
