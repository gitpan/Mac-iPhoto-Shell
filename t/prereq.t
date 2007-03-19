# $Id: prereq.t 1157 2004-02-20 14:36:18Z comdog $
local $^W = 0;

use Test::More;
eval "use Test::Prereq";
plan skip_all => "Test::Prereq required to test dependencies" if $@;
prereq_ok();
