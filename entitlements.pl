#!/usr/bin/env perl


use strict;
use warnings;
use Frontier::Client;
use Data::Dumper;

my $server_url = 'https://rhn.redhat.com/rpc/api';

my $client = Frontier::Client->new('url' => $server_url);

my %config = do '/secret/rhn.config';

my $username = $config{'username'};
my $password = $config{'password'};

my $session = $client->call('auth.login', $username, $password);

my $serverid='1015117599';

my $entitlements = $client->call('system.getEntitlements', $session, $serverid);

print @{$entitlements};


