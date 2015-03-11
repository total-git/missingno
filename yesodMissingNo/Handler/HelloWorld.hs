module Handler.HelloWorld where

import Import
import DbFunctions

getHelloWorldR :: Handler Html
getHelloWorldR = do
    look_at "testchair"
    --itemsInArea 2
    
    defaultLayout $ do
        setTitle "Hello World"
        $(widgetFile "helloworld")


