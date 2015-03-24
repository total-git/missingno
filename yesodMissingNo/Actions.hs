module Actions where

import Import
import DbFunctions
import Database.Persist.Sql

go :: Text -> Int64 -> Text -> Handler Text
go loc areaId urlHash = do
    area <- lookAtArea areaId
    case area of
        Just area' -> do
            let newAreaId = case loc of
                    "north" -> areaGo_north area'
                    "east"  -> areaGo_east area'
                    "west"  -> areaGo_west area'
                    "south" -> areaGo_south area'
                    _       -> Nothing
            case newAreaId of
                Just newAreaId' -> do
                    _ <- updateArea (fromIntegral newAreaId') urlHash
                    return $ "You went " ++ loc ++ "."
                Nothing -> return "You cannot go there."
        Nothing -> return "Invalid location."

useWith :: Text -> Int64 -> Text -> Handler Text
useWith obj areaId urlHash = do
    let words' = words obj
    return ""
--     case head words' of
--         "with" -> return "with"
--         _ -> return "Invalid input."

die :: Text -> Text -> Handler Text
die out urlHash = do
    deletePlayer urlHash
    return $ "You died because " ++ out ++ "! Visit the startpage to restart."

win :: Text -> Text -> Handler Text
win out urlHash = do
    deletePlayer urlHash
    return $ "You won!" ++ out ++ "Visit the startpage to restart."

eat :: Text -> Int64 -> Text -> Handler Text
eat obj areaId urlHash = do
    item <- lookAtItemByUnique obj areaId
    case item of
        Just (Entity _ itemVal) -> do
            case itemUse_action itemVal of
                -- "eat nothing" -> return $ pack $ "You eat the " ++ (unpack $ itemName itemVal) ++ ". Nothing happens."
                "eat die" -> die "you weren't listening" urlHash
                _ -> return "This item is not edible."
        Nothing -> return "No such item in this area."


--use :: Maybe Text -> Handler (Maybe (Entity Item_status))
--use obj = do
--    -- TODO
--
--open :: Maybe Text -> Handler (Maybe (Entity Item_status))
--open obj = do
--    -- TODO

examine :: Text -> Int64 -> Handler Text
examine obj areaId = do
    output <- lookAtItemByUnique obj areaId
    case output of
        Just (Entity _ itemVal) -> return $ itemItem_description itemVal
        Nothing -> return "No such item in this area."

pickUp :: Text -> Int64 -> Text -> Handler Text
pickUp obj areaId urlHash = do
    item <- lookAtItemByUnique obj areaId
    itemsInInventory <- showInventory urlHash
    case item of
        Just (Entity itemKey itemVal) -> do
            case itemInInventory itemsInInventory (Entity itemKey itemVal) of
                True -> do return $ pack $ (unpack $ itemName itemVal) ++ " is already in your inventory."
                False -> do
                    case itemTakeable itemVal of
                        True -> do
                            _ <- insertItemWithStatus obj areaId urlHash "inventory"
                            return $ pack $ "Picked up " ++ (unpack $ itemName itemVal) ++ "."
                        False -> return $ pack "This item is not takeable."
        Nothing -> return "No such item in this Area."

inventory :: Text -> Handler Text
inventory urlHash = do
    itemsInInventory <- showInventory urlHash
    let items = toItemName "" itemsInInventory
    case items of
        [] -> return "No items in inventory."
        _  -> return $ pack $ "Your inventory contains: " ++ items

lookAround :: Int64 -> Text -> Handler Text
lookAround areaId urlHash = do
    areaDescription <- lookAtArea areaId
    items <- showItemsInArea areaId
    inv <- showInventory urlHash
    case areaDescription of
        Just areaVal ->
            case items of
                [] -> return $ areaArea_description areaVal
                items' -> return $ pack $ (unpack $ areaArea_description areaVal) ++ "\nThere are the following items: " ++ (unpack $ toItemName "" (listMinus items' inv))
        _ -> return "Wrong area ID."

-- helper functions
toItemName :: [Char] -> [Entity Item] -> [Char]
toItemName out ((Entity _ itemVal):x:xs) =
  toItemName (out ++ (unpack $ itemName itemVal) ++ ", ") (x:xs)
toItemName out ((Entity _ itemVal):xs) =
  toItemName (out ++ (unpack $ itemName itemVal)) xs
toItemName out _ =
  out

itemInInventory :: [Entity Item] -> (Entity Item) -> Bool
itemInInventory [] _ = False
itemInInventory ((Entity itemKey' _):xs) (Entity itemKey itemVal) =
    (itemKey == itemKey') || itemInInventory xs (Entity itemKey itemVal)

listMinus :: [Entity Item] -> [Entity Item] -> [Entity Item]
listMinus items inv = filter (((not .) .) itemInInventory inv) items

getAreaId :: Text -> Handler Int64
getAreaId urlHash = do
    player <- getPlayer urlHash
    case player of
        Just (Entity _ playerVal) -> return $ fromSqlKey $ player_statusArea_id playerVal
        Nothing -> return 0
