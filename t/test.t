use Test::More;
use lib qw[ lib ../lib ];

use strict;
use warnings;

BEGIN {
	plan tests => 22;
	use Image::Magick;
	use Image::Magick::Thumbnail 0.06;
};

use Cwd;
if (getcwd !~ m(t$)){
	if (-d 't'){
		chdir 't'
	}
}

ok(1);
SKIP: {
	skip "Can't find image in ".getcwd
		if !-e "source.jpg" || !-e "source100x200.jpg";
	&img_tests
};


exit;

sub img_tests {
	my $src = Image::Magick->new;
	isa_ok($src, 'Image::Magick');

	my $err = $src->Read('source.jpg');
	BAIL_OUT "Didn't get vry far: ".$err.' '.getcwd if $err;

	unlink 'source_thumb.jpg' if -e 'source_thumb.jpg';

	{
		my ( $thumb, $x, $y, $r);
		($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,50);
		ok($thumb, 'Got thumb') or BAIL_OUT;
		ok ( $x<=50 );
		ok ( $y<=50 );
		$thumb->Write('source_thumb.jpg');
		ok (-e 'source_thumb.jpg');
		unlink 'source_thumb.jpg' if -e 'source_thumb.jpg';
	}

	{
		my ( $thumb, $x, $y, $r);
		$src = Image::Magick->new;
		$src->Read('source.jpg');
		($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'20x50');
		ok($thumb);
		ok ($x <= 20);
		ok ($y <= 50);
	}

	{
		my ( $thumb, $x, $y, $r);
		$src = Image::Magick->new;
		$src->Read('source100x200.jpg');
		($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'150x100');
		ok($thumb);
		ok($x <= 150);
		ok($y <= 100);
	}

	{
		my ( $thumb, $x, $y, $r);
		$src = Image::Magick->new;
		$src->Read('source100x200.jpg');
		($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'150x100');
		ok($thumb);
		ok($x <= 150);
		ok($y <= 100);
	}

	{
		my ( $thumb, $x, $y, $r);
		$src = Image::Magick->new;
		$src->Read('source100x200.jpg');
		($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'x200');
		ok($thumb);
		ok($x == 100, "y=".$x);
		ok($y == 200, "y=".$y);
	}

	{
		my ( $thumb, $x, $y, $r);
		$src = Image::Magick->new;
		$src->Read('source100x200.jpg');
		($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'200x');
		ok($thumb);
		ok($x == 200, "y=".$x);
		ok($y == 400, "y=".$y);
	}

	ERRS: {
		my ( $thumb, $x, $y, $r);
		$src = Image::Magick->new;
		$src->Read('source100x200.jpg');
		no warnings;
		eval {
			($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'-1x');
		};
		ok(!$thumb);
	}

}

=head1 TEST F<test.t>

This script tests the module is acceptable and functions as expected.

Reads and writes files, and attempts to clean its own mess.

=head1 COPYRIGT

Copyright (C) Lee Godadrd 2001-2008. all rights reserved.
Available under the same terms as Perl itself.

