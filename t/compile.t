# $Id: compile.t,v 1.2 2007/01/20 19:07:08 comdog Exp $

use Test::More tests => 1;

print "bail out! Script file is missing!" unless
	use_ok( "Mac::iPhoto::Shell" );
