module Actions where

import Import
import Parser
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

examine :: Text -> Int64 -> Handler (Maybe Text)
examine object areaId = do
    output <- lookAtItemByUnique object areaId
    case output of
        Just (Entity _ itemVal) -> return $ Just $ itemItem_description itemVal
        Nothing -> return Nothing

--pickUp :: Maybe Text -> Handler (Maybe (Entity Item_status))
--pickUp object = do
--    -- TODO
--
--inventory :: Handler (Maybe Text)
--inventory = do
--    -- TODO
--    --
--lookAround :: Handler (Maybe Text)
--lookAround = do
--    -- TODO
