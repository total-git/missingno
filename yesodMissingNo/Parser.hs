module Parser where

import Import
import Data.Text (strip)

data Input = Input { act :: Maybe Action,
                     obj :: Maybe Text
                   } deriving (Show, Eq)

data Action = Go | Use | Open | Examine | PickUp | Inventory | LookAround | Eat deriving (Show, Eq)
-- TODO add more actions
action :: Text -> Maybe Action
action txt | oelem (toLower txt) ["go", "move", "run", "walk"]
             = Just Go
           | oelem (toLower txt) ["use", "utilize", "utilise", "make use of"]
             = Just Use
           | oelem (toLower txt) ["open", "break open", "undo"]
             = Just Open
           | oelem (toLower txt) ["examine", "look at", "inspect", "view", "watch"]
             = Just Examine
           | oelem (toLower txt) ["pick up", "get", "take", "gather", "grab"]
             = Just PickUp
           | oelem (toLower txt) ["inventory", "pocket", "pockets", "bag", "bags", "rucksack", "backpack"]
             = Just Inventory
           | oelem (toLower txt) ["look around", "look about", "look round", "scout", "glance around"]
             = Just LookAround
           | oelem (toLower txt) ["eat", "devour", "consume"]
             = Just Eat
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

