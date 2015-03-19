module DbFunctions where

import Import
import Database.Persist.Sql

--lookAtItemByName :: Text -> Maybe Text
--lookAtItemByName name = do
--    item <- selectList [ItemName ==. name] []
--    case item of
--        [] -> return Nothing
--         xs -> return $ Just $ printDescription xs
--     where
--       printDescription :: [Entity Item] -> Text
--       printDescription [(Entity _ b)] = itemItem_description b
--       printDescription [] = ""

lookAtItemByName name= do
    item <- runDB $ selectList [ItemName ==. name] []
    print item
    if null item
      then liftIO $ putStrLn "No items with this Name"
      else forM_ item printDescription
    where
      printDescription (Entity a b) = do
        print $ fromSqlKey a 
        putStrLn $ itemItem_description b

--lookAtItemByUnique :: Text -> Int64 -> Maybe Text
-- lookAtItemByUnique name area_id = do
--     maybeItem <- getBy $ UniqueItem name $ toSqlKey area_id
--     case maybeItem of
--         Nothing -> return Nothing
--         Just (Entity _ item) -> return $ itemItem_description item 

lookAtItemByUnique name area_id = do
    maybeItem <- runDB $ getBy $ UniqueItem name $ toSqlKey area_id
    case maybeItem of
        Nothing -> liftIO $ putStrLn "No such item in this area"
        Just (Entity _ item) -> liftIO $ print item 

--lookAtAreaById area_id = do
--    maybeArea <- runDB $ get $ toSqlKey area_id
--    case maybeArea of
--        Nothing -> liftIO $ putStrLn "Not an area"
--        Just area -> liftIO $ print area
