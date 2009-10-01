use strict;
use FindBin;
use Test::More;
use Test::Requires qw(Plack::Test);
use Plack::Test;

use HTML::Mason::PSGIHandler;

my $h = HTML::Mason::PSGIHandler->new(
    comp_root => $FindBin::Bin,
);

my $handler = sub { $h->handle_psgi(@_) };

test_psgi app => $handler, client => sub {
    my $cb = shift;
    my $res = $cb->(HTTP::Request->new(GET => "http://localhost/hello.mhtml?foo=bar"));
    like $res->content, qr/Hello World Foo/;
    like $res->content, qr/foo,bar/;
};

done_testing;

