module Actions where

import Import
import DbFunctions

--go :: Maybe Text -> Handler (Maybe (Entity Player_status))
--go location = do
--    -- TODO
--
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
    case item of
        Just (Entity _ itemVal) -> do
            case itemTakeable itemVal of
                True -> do
                    _ <- insertItemWithStatus obj areaId urlHash "inventory"
                    return $ pack $ "Picked up" ++ (show $ itemName itemVal) ++ "."
                False -> return $ itemName itemVal ++ " not takeable."
        Nothing -> return "No such item in this Area."

inventory :: Text -> Handler Text
inventory urlHash = do
    itemsInInventory <- showInventory urlHash
    let items = toItemName "" itemsInInventory
    case items of
        [] -> return "No items in inventory."
        _  -> return $ pack items

lookAround :: Int64 -> Handler Text
lookAround areaId = do
    areaDescription <- lookAtArea areaId
    itemsInArea <- showItemsInArea areaId
    case areaDescription of
        Just areaVal -> return $ pack $ toItemName (show $ areaArea_description areaVal) itemsInArea
        _ -> return "Wrong area ID."

toItemName :: [Char] -> [Entity Item] -> [Char]
toItemName out ((Entity _ itemVal):xs) =
  toItemName (out ++ (unpack $ itemName itemVal)) xs
toItemName out _ =
  out
