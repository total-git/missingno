module Handler.HelloWorld where

import Import
import DbFunctions

getHelloWorldR :: Handler Html
getHelloWorldR = do
    examine "testchair"
    --itemsInArea 2
    
    defaultLayout $ do
        setTitle "Hello World"
        $(widgetFile "helloworld")


