use Test;
BEGIN { plan tests => 4 };
use Image::Magick::Thumbnail;
ok(1);
my $src = new Image::Magick;
$src->Read('source.jpg');
my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,50);
ok($thumb);
$thumb->Write('source_thumb.jpg');
ok ($x,50);
ok ($y, 42);

__END__
