module DbFunctions where

import Import
import Database.Persist.Sql


lookAtItemByUnique :: Text -> Int64 -> Handler (Maybe (Entity Item))
lookAtItemByUnique name areaId = do
    runDB $ getBy $ (UniqueItem name) (toSqlKey areaId)

showItemsInArea :: Int64 -> Handler [Entity Item]
showItemsInArea areaId = do
    runDB $ selectList [ItemArea_id ==. toSqlKey areaId] []
