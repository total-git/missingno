module Handler.Game where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3, withSmallInput)

getGameR :: Text -> Handler Html
getGameR id = do
    (formWidget, formEnctype) <- generateFormPost gameForm
    let handlerName = "getGameR" :: Text
        submission = Nothing :: Maybe Text
    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "game")

postGameR :: Text -> Handler Html
postGameR id = do
    ((result, formWidget), formEnctype) <- runFormPost gameForm
    let handlerName = "postGameR" :: Text
        submission = case result of
            FormSuccess res -> Just res
            _ -> Nothing
    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "game")

gameForm :: Form Text
gameForm = renderBootstrap3 BootstrapBasicForm $
    areq textField "Input" Nothing
