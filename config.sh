#!/bin/bash
# Author: Vishal Dilip Sanghi
# Install WordPress Config File on a Debian/Ubuntu VPS
# Created on: 26th April 2020
# Last Updated on: 01st May 2020

#Enter the root SQL password 
croot=<your-sql-root-password>

#Enter the new database name you want to create for wordpress installation
cdbname=<yournewdatabasename>

#Database user configuration new or existing
#---------------------------------------------------------------------------------------------------
	#Enter the new user for above database you want to create for wordpress installation
	cdbuser=<your-new-database-user>

	#Enter the new user password for above database you want to create for wordpress installation
	cuserpass=<your-new=database=password>
#---------------------------------------------------------------------------------------------------
#										OR
#---------------------------------------------------------------------------------------------------
	#Enter the new user for above database you want to create for wordpress installation
	cedbuser=<your-existing-database-user>

	#Enter the new user password for above database you want to create for wordpress installation
	ceuserpass=<your-existing-database-password>
#---------------------------------------------------------------------------------------------------

#Enter the new wordpress installation folder name or path
cwpURL=<your-wordpress-installation-folder-path>

#Enter the new wordpress installation URL. Ex. localhost or www.<yourwebsite>.com
curl=<your-wordpress-URL>

#Enter the new wordpress installation Title
ctitle=<your-wordpress-site-title>

#Enter the new wordpress installation Admin Name
cadmin_name=<your-wordpress-admin-name>

#Enter the new wordpress installation Admin Password
cadmin_pass=<your-wordpress-admin-password>

#Enter the new wordpress installation Admin Email
cadmin_email=<your-wordpress-admin-email>

#Enter the default wordpress plugin names to be installed. Please seperate plugin names by spaces. No spaces in plugin name are allowed.
cplugin="<plugin-name1> <plugin-name2>"

#Enter the backup of source path without '/' at last
cbkpsource=<your-backup-path=source>

#Enter the backup of destination path
cbkpdestination=<your-backup-path=destination>
