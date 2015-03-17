module Handler.Game where

import Import
import Parser
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

getGameR :: Text -> Handler Html
getGameR playerId = do
    (formWidget, formEnctype) <- generateFormPost gameForm
    let submission = Nothing :: Maybe Text
    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "game")

postGameR :: Text -> Handler Html
postGameR playerId = do
    ((result, formWidget), formEnctype) <- runFormPost gameForm
    let submission = case result of
            FormSuccess res -> Just $ show $ parseInput res
            _ -> Nothing
    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "game")

gameForm :: Form Text
gameForm = renderBootstrap3 BootstrapBasicForm $
    areq textField "Input" Nothing
