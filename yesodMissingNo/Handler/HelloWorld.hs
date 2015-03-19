module Handler.HelloWorld where

import Import
import DbFunctions

getHelloWorldR :: Handler Html
getHelloWorldR = do
    --itemsInArea 2
    lookAtItemByName "testchair"
    lookAtItemByUnique "testchair" 1
    
    defaultLayout $ do
        setTitle "Hello World"
        $(widgetFile "helloworld")


