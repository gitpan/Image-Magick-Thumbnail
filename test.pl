use Test;
BEGIN { plan tests => 9 };
use Image::Magick::Thumbnail 0.02;
ok(1);
my $src = new Image::Magick;
skip (!-e 'source.jpg', &img_tests);
exit;

sub img_tests {
	$src->Read('source.jpg');
	my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,50);
	ok($thumb);
	ok ($x,50);
	ok ($y, 42);
	unlink 'source_thumb.jpg' if -e 'source_thumb.jpg';
	$thumb->Write('source_thumb.jpg');
	ok (-e 'source_thumb.jpg');
	unlink 'source_thumb.jpg' if -e 'source_thumb.jpg';

	($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'20x50');
	ok($thumb);
	ok ($x, 20);
	ok ($y, 17);

	($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'60x50');

}

__END__
