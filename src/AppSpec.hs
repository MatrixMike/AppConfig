module AppSpec where

import Test.Hspec


import System.IO
import Data.List.Split
import Data.Maybe()
import Data.IORef
import System.IO.Unsafe
import AppConfig

-- username   = ausername
-- password   = apassword
-- smtpServer = smtp.gmail.com 
-- imapServer = imap.gmail.com

-- An smtp server
smtpServer :: IORef String
smtpServer = unsafePerformIO $ newIORef ""

main :: IO () 
main = hspec $ do
	describe "AppConfig.initSystem" $ do
		it "sets the value of smtpserver" $ do
			let appSetup = [( "smtpServer", smtpServer)]
			initSystem "email.cfg" appSetup
			smtpServer' <- (asIOString smtpServer)
			smtpServer' `shouldBe` "smtp.gmail.com" 

	describe "AppConfig.getVal" $ do
		it "Gets the value of the valid key username from the email.cfg file" $ do
			
			props <- readProps "email.cfg"
			let v = getVal props "username"
			case v of
				Just a -> a `shouldBe` "ausername"
			
	describe "AppConfig.getVal" $ do
		it "Gets the value of the invalid key usernameXX from the email.cfg file" $ do
			
			props <- readProps "email.cfg"
			let v = getVal props "usernameXXX"
			v `shouldBe` Nothing
			

	describe "AppConfig.getVal" $ do
		it "Gets the value, with default, of the missing key defaultkey from the email.cfg file" $ do
			
			props <- readProps "email.cfg"
			let v = getValDef  props "defaultkey" "adefaultValue"
			v  `shouldBe` "adefaultValue"
			


