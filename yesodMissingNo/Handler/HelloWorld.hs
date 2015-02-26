module Handler.HelloWorld where

import Import

getHelloWorldR :: Handler Html
getHelloWorldR = do
    defaultLayout $ do
        setTitle "Hello World"
        $(widgetFile "helloworld")
