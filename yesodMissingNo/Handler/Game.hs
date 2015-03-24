module Handler.Game where

import Import
import Parser
import Actions
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

getGameR :: Text -> Handler Html
getGameR urlHash = do
    (formWidget, formEnctype) <- generateFormPost gameForm
    let submission = Nothing :: Maybe Text
        output = "" :: Text
    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "game")

postGameR :: Text -> Handler Html
postGameR urlHash = do
    (formWidget, formEnctype) <- generateFormPost gameForm
    ((formResult, _), _) <- runFormPost gameForm
    let submission = case formResult of
            FormSuccess res -> Just $ parseInput res
            _ -> Nothing
    areaId <- getAreaId urlHash
    output <- case areaId of
        0 -> return "Invalid URL. Please return to the startpage."
        _ -> do
            case submission of
              Just (Input (Just Examine) (Just obj)) -> do
                  out <- examine obj areaId
                  return out
              Just (Input (Just LookAround) _ ) -> do
                  out <- lookAround areaId urlHash
                  return out
              Just (Input (Just PickUp) (Just obj)) -> do
                  out <- pickUp obj areaId urlHash
                  return out
              Just (Input (Just Inventory) _) -> do
                  out <- inventory urlHash
                  return out
              Just (Input (Just Go) (Just loc)) -> do
                  out <- go loc areaId urlHash
                  return out
              Just (Input (Just Eat) (Just obj)) -> do
                  out <- eat obj areaId urlHash
                  return out
              Just (Input (Just Use) (Just obj)) -> do
                  out <- useWith obj areaId urlHash
                  return out
              _ -> return "Invalid input."

    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "game")

gameForm :: Form Text
gameForm = renderBootstrap3 BootstrapBasicForm $
    areq (searchField True) "Input:" Nothing
