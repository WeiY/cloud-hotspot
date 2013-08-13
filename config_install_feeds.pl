#!/usr/bin/perl

use warnings;
use strict;

open(CONFIG_FILE, '<', ".config");
while(<CONFIG_FILE>)
{
  if( $_ =~ /^CONFIG_PACKAGE_(.+?)=y/)
  {
    my $feed = $1;
    print("./scripts/feeds install $feed\n");
    system("./scripts/feeds install $feed");
  }
}
