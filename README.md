
Haskell library for setting app 'constants' via a config file.
-----------------

*Application config values to be set from external config file. All declared as IORef String.*

*An smtp server*

	smtpServer :: IORef String
	smtpServer = unsafePerformIO $ newIORef ""

*with user name and password*

 	username :: IORef String
 	username = unsafePerformIO $ newIORef ""

 	password :: IORef String
 	password = unsafePerformIO $ newIORef ""

*Then at the startup point of the application the above values are writen to with the values taken from the email.cfg file.*

	main = do
		let appSetup = [( "smtpServer", smtpServer), ("username", username), ("password", password)]
		initSystem "email.cfg" appSetup
		smtpServer' <- (asIOString smtpServer)
		username'   <- (asIOString username)
		password'   <- (asIOString password)
		print smtpServer'  
		print username'
		print password'

  

*The email.cfg is just a nymber of key = value entries, each on a new line.*
	
	username   = ausername
	assword   = apassword
	smtpServer = smtp.gmail.com 




