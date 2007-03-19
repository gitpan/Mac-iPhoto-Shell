# $Id: compile.t 2071 2007-01-20 19:07:08Z comdog $

use Test::More tests => 1;

print "bail out! Script file is missing!" unless
	use_ok( "Mac::iPhoto::Shell" );
