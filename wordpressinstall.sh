#!/bin/bash
# Author: Vishal Dilip Sanghi
# Install WordPress on a Debian/Ubuntu VPS
# Created on: 26th April 2020
# Last Updated on: 06th May 2020
# References: https://gist.github.com/rjekic/2d04423bd167f8e7afd26f8982609378
source config.sh

function installwordpress() {

	# Download, unpack and configure WordPress
	echo
	read -r -p "Enter your WordPress installation folder name (without '/' on beign. or end) ? [e.g. mywebsite.com or html]: " wpURL
	# Setting value to be picked from configuration file.
	wpURL=${wpURL:-$cwpURL}

	# Removing the current directory and files
	rm -r /var/www/$wpURL
	echo
	echo "****Removed current files and folder from wordpress site directory****"

	# Make new directory with the same name and path
	mkdir /var/www/$wpURL
	echo
	echo "****Created new directory with same name and path****"
	echo
	echo "****Please wait as wordpress is getting downloaded....."
	echo
	wget -q -O - "https://wordpress.org/latest.tar.gz" | tar -xzf - -C /var/www --transform s/wordpress/$wpURL/
	chown www-data: -R /var/www/$wpURL && cd /var/www/$wpURL
	cp wp-config-sample.php wp-config.php
	chmod 640 wp-config.php
	mkdir uploads
	sed -i "s/database_name_here/$dbname/;s/username_here/$dbuser/;s/password_here/$userpass/" wp-config.php
	echo "****Wordpress Download Sucessfull****"
	echo

	# Entering details of the new Wordpress site
	echo "======================================================="
	echo "Ready to install Wordpress. Just enter few more details"
	echo "======================================================="
	read -p "Website url or local installation please mention (localhost): " url
	# Setting value to be picked from configuration file.
	url=${url:-$curl}
	read -p "Wordpress Website title: " title
	# Setting value to be picked from configuration file.
	title=${title:-$ctitle}
	read -p "Wordpress Admin username: " admin_name
	# Setting value to be picked from configuration file.
	admin_name=${admin_name:-$cadmin_name}
	read -sp "Wordpress Admin password: " admin_pass
	# Setting value to be picked from configuration file.
	admin_pass=${admin_pass:-$cadmin_pass}
	echo
	read -p "Wordpress Admin email: " admin_email
	# Setting value to be picked from configuration file.
	admin_email=${admin_email:-$cadmin_email}
        echo "Email ID is $admin_email"
	echo
	echo "============================================"
	echo "Wordpress is now getting installed."
	echo "============================================"
	echo

	# Installing Wordpress site using credentials defined in above section
	wp core install --url=$url --title="$title" --admin_name=$admin_name --admin_password=$admin_pass --admin_email=$admin_email --allow-root

	# Installing Wordpress plugins
	# define array of plugin slugs to install. Enter multiple plugin with spaces in round bracket below.
	echo "Installing default plugins"
	# Setting value to be picked from configuration file.
	plugin=${plugin:-$cplugin}
	WPPLUGINS=( $plugin )
	# Path of the installation folder of wordpress
	WPPATH=/var/www/$wpURL
	# Command to install the actual plugins
	wp plugin install ${WPPLUGINS[@]} --activate --path=$WPPATH --allow-root
	echo
	echo "==============================="
	echo "Plugins Installation Completed"
	echo "==============================="
		
	# Give Permissions
	sudo chown -R www-data:www-data /var/www/$wpURL
	sudo chmod -R 755 /var/www/$wpURL
	sudo find $WPPATH -type f -exec chmod 644 {} +
	sudo find $WPPATH -type d -exec chmod 755 {} +
	echo
	echo "==============================="
	echo "Permissions Granted - Success"
	echo "==============================="

	# Restarting Services optional not needed
	# systemctl restart apache2.service
	# echo "Apache Service Restarted"
	# echo
	# systemctl restart mysql.service
	# echo "My SQL Service Restarted"
	echo
	echo "============================================"
	echo "Hurray..!!! Wordpress sucessfully installed"
	echo "============================================"
	echo
	echo "=========================="
	echo "Choose Backup Copy Option:"
	echo "=========================="
	echo
	echo "1. Continue copying with bakcup file "
	echo "2. Exit"
	echo
	read -p "Choose Option: " install_method
	if [ "$install_method" == 1 ]; then
		# Copy the backup file from one directory to another default value is just for reference
		# Specify Source Path
		echo
		read -r -p "Enter Source Path (without '/' at the end): " source
		# Setting default value for variable source of source path - optional as needed
		source=${source:-$cbkpsource}
		# Specify Destination Path
		echo
		read -r -p "Enter Destination Path: " destination
		# Setting default value for variable destination of destination path - optional as needed
		destination=${destination:-$cbkpdestination}
		# Command to find latest zip from source folder and copy to destination folder
		echo
		ls -ltr $source/*.zip | awk 'END{print $NF}'|xargs -i -t cp {}  $destination
		echo
		echo "============================================"
		echo "Backup of wordpress site copied sucessfully"
		echo "============================================"
	else
		exit
	fi
}


echo "=================================================="
echo "Welcome to Automated Wordpress Installation Tool"
echo "=================================================="

	# Create MySQL database
    read -sp "Enter your MySQL root password: " rootpass
	# Setting value to be picked from configuration file.
	rootpass=${rootpass:-$croot}
	echo
	read -p "Database name: " dbname
	# Setting value to be picked from configuration file.
	dbname=${dbname:-$cdbname}
	
	echo "CREATE DATABASE $dbname;" | mysql -u root -p$rootpass
	echo "=================================================="
	echo "Choose SQL Database Configuration Option for User:"
	echo "=================================================="
	echo
	echo "1. Install with new DB user"
	echo "2. Install with existing DB user"
	echo
	read -p "Choose install method: " install_method
	
	if [ "$install_method" == 1 ]; then
		#Create a DB user
		echo
		read -p "Database username: " dbuser
		# Setting value to be picked from configuration file.
		dbuser=${dbuser:-$cdbuser}
		read -sp "Enter a password for user $dbuser: " userpass
		# Setting value to be picked from configuration file.
		userpass=${userpass:-$cuserpass}
		echo "CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$userpass';" | mysql -u root -p$rootpass
	else
		# Provide privileges to the existing user
		echo
		read -p "Database username: " dbuser
		# Setting value to be picked from configuration file.
		dbuser=${dbuser:-$cedbuser}
		read -sp "Enter a password for user $dbuser: " userpass
		# Setting value to be picked from configuration file.
		userpass=${userpass:-$ceuserpass}
		echo "GRANT permission ON $dbname.* TO '$dbuser'@'localhost';" | mysql -u root -p$rootpass
	fi

	echo "GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'localhost';" | mysql -u root -p$rootpass
	echo "FLUSH PRIVILEGES;" | mysql -u root -p$rootpass
	echo
	echo "New MySQL database is successfully created and configured"
	
	# Starting the Wordpress installation process 
	echo
	echo "======================================"
	echo "Choose Wordpress installation Option:"
	echo "======================================"
	echo
	echo "1. Install Wordpress with wp-cli Installation. Please install Curl first"
	echo "2. Install Wordpress with already installed wp-cli"
	echo
	read -p "Choose install method: " install_method

	if [ "$install_method" == 1 ]; then

		# Starting the Wordpress installation process using wp-cli
		echo "===================================="
		echo "Please wait while we install wp-cli"
		echo "===================================="
		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
		chmod +x wp-cli.phar
		cp wp-cli.phar /usr/bin/wp

		echo "=========================="
		echo "Finished installing wp-cli"
		echo "=========================="
		echo
		installwordpress
	else
		installwordpress
	fi
	




