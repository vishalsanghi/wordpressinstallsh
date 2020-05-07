#!/bin/bash
# Author: Vishal Dilip Sanghi
# wordpressinstall.sh sample configuration file
# Created On: 26th April 2020
# Last Updated On: 07th May 2020

# Enter the SQL Root Password 

croot=sqlrootpassword

# Enter the new database name you want to create for wordpress installation
cdbname=dbname

# Database user configuration new or existing
# Enter the new user for above database you want to create for wordpress installation

cdbuser=dbuser

# Enter the new user password for above database you want to create for wordpress installation

cuserpass=dbpassword

# Enter the new user for above database you want to create for wordpress installation

cedbuser=existingdbuser

# Enter the new user password for above database you want to create for wordpress installation

ceuserpass=existingdbpassword

# Enter the new wordpress installation folder name or path

cwpURL=html

# Enter the new wordpress installation URL

curl=localhost

# Enter the new wordpress site Title

ctitle=newwordpress

# Enter the new wordpress installation Admin Name

cadmin_name=adminname

# Enter the new wordpress installation Admin Password

cadmin_pass=adminpassword

# Enter the new wordpress installation Admin Email

cadmin_email=admin@yourdomain.com

# Enter the default wordpress plugin names to be installed
# Please seperate plugin names by spaces and no spaces in plugin name is allowed
# Sample plugins are mentioned below can be replaced as needed

cplugin="wp-clone-by-wp-academy wp-autoupdates"

# Enter the backup of source path
# Please do not end the path with /

cbkpsource=/home/vishalsanghi/wordpress

#Enter the backup of destination path

cbkpdestination=/home/vishalsanghi/wordpress1
