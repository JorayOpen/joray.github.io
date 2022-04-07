---
layout: post
category : 技术
title: Install Apache2.4 PHP5.3 on Windows
tagline: ""
tags : [apache]
---
{% include JB/setup %}



from：<http://www.workorderts.com/Virtual_Brain_Online.php/category/Installation_Guides>

__Let's get started!__
__First, download the latest version of Apache, PHP5 and MySQL. __
__The most recent editions available today are__


	httpd-2.4.2-win32-ssl_0.9.8v.zip => http://www.apachelounge.com/download/
	php-5.3.13-Win32-VC9-x86.zip (VC9 x86 Thread Safe ) => http://windows.php.net/download/
	mysql-5.5.24-win32.msi => http://www.mysql.com/downloads/mysql/


### Install Apache 2.4 on Windows

You must first install (not needed for Windows 7+) the Visual C++ 2010 Redistributable Package.
Download and Install, if you have not installed it already,
from: http://www.microsoft.com/download/en/details.aspx?id=8328

__Extract the files inside the Apache Zip archive to c:\apache24__
(note NOT c:\apache24\Apache24)

Extracting apache into another folder means that you will have to adjust a few config options.
Don't do this unless you know what you are doing! 
Open httpd.conf and adjust ServerRoot, Documenroot, Directories, ScriptAlias to your custom path.
Don't forget the "extra" folder if you need the option.
Do NOT place the apache folder into "Program Files" or "Program Files (x86)"!

Next add the apache folder to your Windows PATH variable. 
__Open Control Panel => System => Advanced system settings => Advanced => Environment Variables...__
Under System variables, scroll down to Path and append the following to Variable value ;

__c:\apache24\bin\__

Now it is time to see if apache will start. Open a comamnd prompt Start => Run => CMD 
Try to start the server with httpd.exe and you should see a message like this:
AH00558: httpd.exe: Could not reliably determine the server's fully qualified domain name, using fe80::3064:1dd0:3e60:9fb7. Set the 'ServerName' directive globally to suppress this message

So far so good, use CTRL+C to terminate the server.

ServerName localhost:80

__Root Cause :__

Apache Server is looking for the hostname name which it can use to start and listen for request. If there is a hostname configured on the machine and it is not configured in the httpd.conf file then it will throw this error .

__Solution:__

Get the hostname of the machine on which the Apache Server is installed using the OS command : hostname
Configure the same in the httpd.conf file with the directive : ServerName as shown below:
ServerName Sandeep

Restart the Apache Server.
In case you do not want to use the Machine Hostname with the Apache Server then make the ServerName Entry in the httpd.conf file as localhost.

Now run httpd.exe -k install to install Apache as a service (open a command prompt with Administrative rights under Windows Vista and above). Now open Start => Run => services.msc and look for Apache2.4. Try to start it, it should work.

Congratulations, you have just installed Apache onto your Windows system.


### Install the MySQL5 database server on a Windows Computer/Server

Double click on the .msi file to start the setup programm. 
Follow the instructions given to you by the installer and choose the "Typical" installation method when prompted. 

Once the installation is complete ensure that the box next to "Launch the MySQL Instance Configuration Wizard" is checked, then click on "Finish".


	please select "Detailed Configuration"
	Server Role should be Server Machine
	install MySQL 5 as a "Multifunctional Database" 
	Set the MySQL5 connection limit to 20-50
	Character Set 
	Please enter a secure root password
	Almost Done, time to execute the configuration. Please click on "Execute" 



MySQL 5 is now installed and running, but how do we know?
Click on Start => Run and enter cmd into the box,

Once the black window, Command Prompt, is open, type "netstat -an" 
Make sure that you can find port 80 (apache) and 3306 (mysql) on the list.


### Install PHP5 and integrate it with Apache 2.0, 2.2 or 2.4

Extract the downloaded zip file containing PHP, rename it to PHP and move it to C:\

Now we need to add C:\php to the Windows Path. This is the recommended way, DO NOT follow other instructions!
14. How do I add my PHP directory to the PATH on Windows?
(Source http://www.php.net/manual/en/faq.installation.php#faq.installation.addtopath )

__On Windows NT, 2000, XP and 2003:__

> -Go to Control Panel and open the System icon (Start -> Settings -> Control Panel -> System, or just Start -> Control Panel -> System for Windows XP/2003). You might have to click on "Switch to Classic View" on the top left corner to see "System"!

> -Go to the Advanced tab
> -Click on the 'Environment Variables' button
> -Look into the 'System Variables' pane
> -Find the Path entry (you may need to scroll to find it)
> -Double click on the Path entry
> -Enter your PHP directory ant the end, including ';' before (e.g. ;C:\php)
> -Press OK and restart your computer 

Note: Be sure to reboot after following the steps above to ensure that the PATH changes are applied. 

Now it is time to configure PHP.
You will find two sample configuration files inside the PHP 5 directory, C:\php.
Delete php.ini-development and copy the file php.ini-production to php.ini

Open php.ini with Notepad and search for "extension_dir", change the line to 
extension_dir = "./ext/"

Keep php.ini open and look for
 
	extension=php_mysql.dll
	extension=php_mysqli.dll
	
Remove the ; in front of the lines, save and close the file.

Now it's time to configure Apache to work with PHP. 


#### Apache 2.0:

Use Notepad to open the file C:\Apache2\conf\httpd.conf. Search the file for the string "LoadModule" and add these lines below.


	LoadModule php5_module "c:/php/php5apache2.dll"
	AddType application/x-httpd-php .php
	PHPIniDir "C:/php"


#### Apache 2.2:

Use Notepad to open the file C:\Apache2.2\htdocs\httpd.conf. Search the file for the string "LoadModule" and add these lines below.


	LoadModule php5_module "c:/php/php5apache2_2.dll"
	AddType application/x-httpd-php .php
	PHPIniDir "C:/php"


#### Apache 2.4:

You need to download php5apache2_4.dll-php-5.3-win32.zip from Apachelounge, extract the files and copy php5apache2_4.dll into C:\PHP

Use Notepad to open the file C:\Apache24\htdocs\httpd.conf. Search the file for the string "LoadModule" and add these lines below.


	LoadFile "C:/php/php5ts.dll"
	LoadModule php5_module "c:/php/php5apache2_4.dll"
	AddType application/x-httpd-php .php
	PHPIniDir "C:/php"



__Optional__
The default Apache configuration has directory indexes enabled which displays the directory content if no index file is found. This is fine for a development server but not for production use.. Locate the 
`<Directory>`section handling your htdocs directory and remove the command Indexes,The configuration line should now read Options FollowSymLinks


Save the configuration file and restart Apache 2. 
Create the file info.php in your htdocs directory.
Edit info.php and enter the code below.


Now it's time to test the php installation. Open your web browser and navigate to http://localhost/info.php if you did everything as shown above you should see the screen below and should now be ready to install WorkOrder TS


##### Problems:

__Problem:__ You receive a PHP error message that you MySQL extension has not been found.

__Solution:__The solution to this problem is usually to correct incorrect path entries, make sure that your MySQL and PHP paths point to the correct directories on your hard drive. If this does not work, copy the file libmysql.dll from your PHP directory into your %windir%\system32 directory. Don't forget to restart when you change the Windows PATH




