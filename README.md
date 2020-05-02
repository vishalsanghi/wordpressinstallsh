## Wordpress Installation Shell Script

The script is my first ever shell script public code. It is built for my custom requirement but I have made it generic so anyone can use it as needed. 

**The script is divided into following parts and can be used as per your requirement:**

* Defining the configuration file for your requirement
* Creating SQL Database with new or existing users
* Installing wordpress in custom defined directory with WP-CLI
* Defininig the wordpress installation metadata - Title, Username, Password and Email.
* Installing default wordpress plugin automatically with WP-CLI
* Copying the wordpress backup zip file with custom source and destination. This is optional step.                                                 
  * This is built for copying the latest zip file from wp-clone backup folder to your destination WP-Clone backup folder
  * You would have already taken the backup from WP-Clone plugin manually for the current website.
  * To restore the backup you need navigate to newly installed wordpress site and then restore from WP-Clone interface.

**Key Points & Assumptions:**

* Passing correct values from user interface or from the configuration file.
* You can change the config file name as needed but please ensure to modify the source in the wordpressinstall.sh too.
* Script has lot of customizations please make use of it as needed.                                                                                

**Disclaimer:**

* Author does not take any responsibility of your data loss or any configuration loss.

