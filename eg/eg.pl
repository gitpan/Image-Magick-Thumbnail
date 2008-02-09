use Image::Magick::Thumbnail;

# Load your source image
my $src = new Image::Magick;
$src->Read('../t/source.jpg');

# Create the thumbnail from it, where the biggest side is 50 px
my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,50);

# Save your thumbnail
$thumb->Write('source_thumb.jpg');

# Create another thumb, that fits into the geometry
my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'60x50');
