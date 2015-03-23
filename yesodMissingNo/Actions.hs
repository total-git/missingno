module Actions where

import Import
import DbFunctions

--go :: Maybe Text -> Handler (Maybe (Entity Player_status))
--go location = do
--    -- TODO
--
--use :: Maybe Text -> Handler (Maybe (Entity Item_status))
--use object = do
--    -- TODO
--
--open :: Maybe Text -> Handler (Maybe (Entity Item_status))
--open object = do
--    -- TODO

examine :: Text -> Int64 -> Handler Text
examine object areaId = do
    output <- lookAtItemByUnique object areaId
    case output of
        Just (Entity _ itemVal) -> return $ itemItem_description itemVal
        Nothing -> return "No such item in this area"

--pickUp :: Maybe Text -> Handler (Maybe (Entity Item_status))
--pickUp object = do
--    -- TODO
--
--inventory :: Handler (Maybe Text)
--inventory = do
--    -- TODO
--    --

lookAround :: Int64 -> Handler Text
lookAround areaId = do
    areaDescription <- lookAtArea areaId
    itemsInArea <- showItemsInArea areaId
    case areaDescription of
        Just areaVal -> return $ pack $ listItems (show $ areaArea_description areaVal) itemsInArea
        _ -> return "Wrong area ID"
    where listItems :: [Char] -> [Entity Item] -> [Char]
          listItems out ((Entity _ itemVal):xs) =
            listItems (out ++ (unpack $ itemName itemVal)) xs
          listItems out _ =
            out
