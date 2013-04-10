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

my $serverid='1025849085';

#my $hostname = $client->call('system.getDetails', $session, $serverid);

my $channels = $client->call('channel.software.listSystemChannels', $session, $serverid);

my $listchannels = $client->call('channel.listSoftwareChannels', $session);


my @newchannels;
push(@newchannels,'rhel-x86_64-server-optional-6.4.z');
push(@newchannels,'rhel-x86_64-server-6.4.z');

my $updatechannels = $client->call('channel.software.setSystemChannels', $session, $serverid, \@newchannels);

#print Dumper($listchannels);
#print Dumper($hostname);
print Dumper($channels);
print Dumper($updatechannels);




__END__

my %db;

for my $system (@$systems) {
	foreach my $key (keys %{$system}){
		print "$key : ${$system}{$key}\n";
		if($key eq 'id'){
			 my $entitlements = $client->call('system.getEntitlements', $session, ${$system}{$key});
			 if(!defined($$entitlements[0])){
				 print "entitlement: none\n";
				 $db{${$system}{$key}}=${$system}{'name'};
			 }else{
				print "entitlement: @$entitlements\n";
			}
		 }
	}
	print "=========================\n";
	#print Dumper($system);
}

foreach my $id (keys %db){
	print "$id : $db{$id}\n";
}

my @a= keys %db;

print "@a\n";
