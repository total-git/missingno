module Handler.Home where

import Import

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        setTitle "Welcome to Missingno!"
        $(widgetFile "homepage")
