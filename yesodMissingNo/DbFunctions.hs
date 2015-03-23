module DbFunctions where

import Import
import Database.Persist.Sql

lookAtArea :: Int64 -> Handler (Maybe Area)
lookAtArea areaId = do
    runDB $ get $ toSqlKey areaId

lookAtItemByUnique :: Text -> Int64 -> Handler (Maybe (Entity Item))
lookAtItemByUnique name areaId = do
    runDB $ getBy $ (UniqueItem name) (toSqlKey areaId)

showItemsInArea :: Int64 -> Handler [Entity Item]
showItemsInArea areaId = do
    runDB $ selectList [ItemArea_id ==. toSqlKey areaId] []

getPlayer :: Text -> Handler (Maybe (Entity Player_status))
getPlayer urlHash = do
    runDB $ selectFirst [Player_statusUrlHash ==. urlHash] []

updateArea :: Int64 -> Text -> Handler ()
updateArea newArea urlHash = do
    runDB $ updateWhere [Player_statusUrlHash ==. urlHash] [Player_statusArea_id =. (toSqlKey newArea)]
