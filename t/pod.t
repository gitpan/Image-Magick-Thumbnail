use strict;
use warnings;

use Test::More;

my
	$VERSION = do { my @r = ( q$Revision: 1.2 $ =~ /\d+/g ); sprintf "%d." . "%03d" x $#r, @r };

use Cwd;
chdir ".." if getcwd() =~ '\Wt';	# For dev

eval "use Test::Pod 1.00";

plan skip_all => "Test::Pod 1.00 required for testing POD" if $@;

all_pod_files_ok();

__END__

=head1 TEST F<pod.t>

Someone gave me this to test POD.
