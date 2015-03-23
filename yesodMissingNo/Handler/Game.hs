module Handler.Game where

import Import
import Parser
import Actions
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

getGameR :: Text -> Handler Html
getGameR playerId = do
    (formWidget, formEnctype) <- generateFormPost gameForm
    let submission = Nothing :: Maybe Text
        output = "" :: Text
    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "game")

postGameR :: Text -> Handler Html
postGameR playerId = do
    ((formResult, formWidget), formEnctype) <- runFormPost gameForm
    let submission = case formResult of
            FormSuccess res -> Just $ parseInput res
            _ -> Nothing
        areaId = 1
    output <- case submission of
        Just (Input (Just Examine) (Just obj)) -> do
            out <- examine obj areaId
            return out
        Just (Input (Just LookAround) _ ) -> do
            out <- lookAround areaId
            return out
        _ -> return "Invalid input."

    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "game")

gameForm :: Form Text
gameForm = renderBootstrap3 BootstrapBasicForm $
    areq textField "Input" Nothing
