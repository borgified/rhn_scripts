#!/usr/bin/python

import xmlrpclib
import sys

SATELLITE_URL = "https://rhn.redhat.com/rpc/api"
SATELLITE_LOGIN = "rhn-account"
SATELLITE_PASSWORD = "rhn-password"


client = xmlrpclib.Server(SATELLITE_URL, verbose=0)
key = client.auth.login(SATELLITE_LOGIN, SATELLITE_PASSWORD)

for system in sys.argv:
	    # SKIP the first element of the args as it's always the script name
    if system == sys.argv[0]:
			        continue
       
    print 'asking RHN to delete :{0}'.format (system)
    sysid = int(system)
    client.system.deleteSystems(key,sysid)

client.auth.logout(key)
