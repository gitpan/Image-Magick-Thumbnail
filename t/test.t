use Test;
use lib "../lib";

BEGIN {
	plan tests => 14;
	use Image::Magick;
	use Image::Magick::Thumbnail 0.06;
};

ok(1);
skip (
	(!-e "source.jpg" || !-e "source100x200.jpg"),
	&img_tests
);

exit;

sub img_tests {
	my $src = Image::Magick->new;
	$src->Read('source.jpg');
	unlink 'source_thumb.jpg' if -e 'source_thumb.jpg';

	my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,50);
	ok($thumb);
	ok ( $x<=50 );
	ok ( $y<=50 );
	$thumb->Write('source_thumb.jpg');
	ok (-e 'source_thumb.jpg');
	unlink 'source_thumb.jpg' if -e 'source_thumb.jpg';

	$src = Image::Magick->new;
	$src->Read('source.jpg');
	($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'20x50');
	ok($thumb);
	ok ($x <= 20);
	ok ($y <= 50);

	$src = Image::Magick->new;
	$src->Read('source100x200.jpg');
	($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'150x100');
	ok($thumb);
	ok($x <= 150);
	ok($y <= 100);

	$src = Image::Magick->new;
	$src->Read('source100x200.jpg');
	($thumb,$x,$y) = Image::Magick::Thumbnail->create($src,'150x100');
	ok($thumb);
	ok($x <= 150);
	ok($y <= 100);
}

=head1 TEST F<test.t>

This script tests the module is acceptable and functions as expected.

Reads and writes files, and attempts to clean its own mess.

=head1 COPYRIGT

Copyright (C) Lee Godadrd 2001-2008. all rights reserved.
Available under the same terms as Perl itself.

