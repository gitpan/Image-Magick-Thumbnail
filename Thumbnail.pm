package Image::Magick::Thumbnail;

use strict;
use warnings;
our $VERSION = '0.01';

=head1 NAME

Image::Magick::Thumbnail - produces thumbnail images with ImageMagick

=head1 SYNOPSIS

	use Image::Magick::Thumbnail;
	# Load your source image
	my $src = new Image::Magick;
	$src->Read('source.jpg');

	# Create the thumbnail from it, where the biggest side is 50 px
	my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,50);

	# Save your thumbnail
	$thumb->Write('source_thumb.jpg');

	__END__

=head1 DESCRIPTION

This module uses the ImageMagick library to create a thumbnail image with no side bigger than you specify.

The subroutine C<create> takes two arguments: the first is an ImageMagick image object,
the second is the size, in pixels, you wish the image's longest side to be.
It returns an ImaegMagick image object (the thumbnail), as well as the
number of pixels of the I<width> and I<height> of the image,
as integer scalars.

=cut

=head1 PREREQUISITES

	Image::Magick

=cut

use Image::Magick;

sub create { my ($img,$n) = (shift,shift);
	my ($ox,$oy) = $img->Get('width','height');
	my $r = $ox>$oy ? $ox / $n : $oy / $n;
	$img->Resize(width=>$ox/$r,height=>$oy/$r);
	return $img, sprintf("%.0f",$ox/$r), sprintf("%.0f",$oy/$r);
}

1;

__END__

=head2 EXPORT

None by default.

=head1 AUTHOR

Lee Goddard <LGoddard@CPAN.org>

=head1 SEE ALSO

L<perl>, L<Image::Magick>, L<Image::GD::Thumbnail>.

=head1 COPYRIGT

Copyright (C) Lee Godadrd 2001 all rights reserved.
Available under the same terms as Perl itself.

=cut

__END__
