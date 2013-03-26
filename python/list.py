#!/usr/bin/python

import xmlrpclib

SATELLITE_URL = "https://rhn.redhat.com/rpc/api"
SATELLITE_LOGIN = "rhn-acccount"
SATELLITE_PASSWORD = "rhn-password"

client = xmlrpclib.Server(SATELLITE_URL, verbose=0)
key = client.auth.login(SATELLITE_LOGIN, SATELLITE_PASSWORD)
list = client.system.listUserSystems(key)

for group in list:
	sysname = group.get('name')
	sysid =  group.get('id')
	print '{0} - {1} ' .format (sysname, sysid)

client.auth.logout(key)

