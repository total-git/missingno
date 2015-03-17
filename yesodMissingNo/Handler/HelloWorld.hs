module Handler.HelloWorld where

import Import
import DbFunctions

getHelloWorldR :: Handler Html
getHelloWorldR = do
    lookAtItemByName "testchair"
    lookAtItemByUnique "testchair" 1
    
    defaultLayout $ do
        setTitle "Hello World"
        $(widgetFile "helloworld")


