module Handler.Game where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)
import Data.Text (strip)

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

data Input = Input { act :: Maybe Action,
                     obj :: Maybe Text
                   } deriving (Show, Eq)

data Action = Go | Use | Examine | PickUp | Inventory | LookAround deriving (Show, Eq)
-- TODO add more actions
action :: Text -> Maybe Action
action txt | oelem txt ["go", "move", "run", "walk"]
             = Just Go
           | oelem txt ["use", "utilize", "utilise", "make use of"]
             = Just Use
           | oelem txt ["examine", "look at", "inspect", "view", "watch"]
             = Just Examine
           | oelem txt ["pick up", "get", "take", "gather", "grab"]
             = Just PickUp
           | oelem txt ["inventory", "pocket", "pockets", "bag", "bags", "rucksack", "backpack"]
             = Just Inventory
           | oelem txt ["look around", "look about", "look round", "scout", "glance around"]
             = Just LookAround
           | otherwise
             = Nothing

parseInput :: Text -> Input
parseInput txt = parseInputWords (words txt) ""
  where
    parseInputWords :: [Text] -> Text -> Input
    parseInputWords (w:ws) cs =
        case action cs of
            Just act -> Input (Just act) (Just $ unwords $ w:ws)
            Nothing  -> parseInputWords ws $ strip $ unwords [cs,w]
    parseInputWords [] cs = Input (action cs) Nothing

