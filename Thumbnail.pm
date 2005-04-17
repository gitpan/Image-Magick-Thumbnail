package Image::Magick::Thumbnail;

use strict;
use warnings;
our $VERSION = '0.04';

=head1 NAME

Image::Magick::Thumbnail - Produces thumbnail images with ImageMagick

=head1 SYNOPSIS

	use Image::Magick::Thumbnail;
	# Load your source image
	my $src = new Image::Magick;
	$src->Read('source.jpg');

	# Create the thumbnail from it, where the biggest side is 50 px
	my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,50);

	# Save your thumbnail
	$thumb->Write('source_thumb.jpg');

	# Create another thumb, that fits into the geometry
	my ($thumb,$x,$y) = Image::Magick::Thumbnail::create($src,'60x50');


	__END__

=head1 DESCRIPTION

This module uses the ImageMagick library to create a thumbnail image with no side bigger than you specify.

There is no OO API, since that would seem to be over-kill.
The subroutine C<create> takes two arguments: the first is an ImageMagick image object,
the second is either the size in pixels you wish the longest side of the image to be,
or an C<Image::Magick>-style 'geometry' (eg C<100x120>) which the thumbnail must fit.

It returns an ImaegMagick image object (the thumbnail), as well as the
number of pixels of the I<width> and I<height> of the image,
as integer scalars.

=cut

=head1 PREREQUISITES

	Image::Magick

=cut

use Image::Magick;
use Carp;

sub create { my ($img, $max) = (shift, shift);
	if (not $img){
		warn "No image in ".__PACKAGE__."::create";
		return undef;
	}
	if (not $max){
		warn "No size or geometry in ".__PACKAGE__."::create";
		return undef;
	}
	my ($ox,$oy) = $img->Get('width','height');

	# From geo, get the longest side of the box into which to fit:
	my ($maxx, $maxy);
	if (($maxx, $maxy) = $max =~ /^(\d+)x(\d+)$/i){
		$max = ($ox>$oy)? $maxx : $maxy;
	} else {
		$maxx = $maxy = $max;
	}

	my $r = ($ox>$oy) ? ($ox/$maxx) : ($oy/$maxy);

	$img->Thumbnail(width=>int($ox/$r),height=>int($oy/$r));
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
