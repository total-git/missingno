module DbFunctions where

import Import
import Database.Persist.Sql

insertPlayer :: Text -> Handler (Key Player_status)
insertPlayer urlHash = do
    runDB $ insert $ Player_status (toSqlKey 1) Nothing urlHash

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
    runDB $ getBy $ UniqueHash urlHash

updateArea :: Int64 -> Text -> Handler ()
updateArea newArea urlHash = do
    runDB $ updateWhere [Player_statusUrlHash ==. urlHash] [Player_statusArea_id =. (toSqlKey newArea)]

insertItemWithStatus :: Text -> Int64 -> Text -> Text -> Handler (Key Item_status)
insertItemWithStatus itemName areaId urlHash status = do
    player <- getPlayer urlHash
    item <- lookAtItemByUnique itemName areaId
    let playerId = case player of
            Just (Entity valId _) -> valId
        itemId = case item of
            Just (Entity valId _) -> valId
    runDB $ insert $ Item_status playerId itemId status

showUsedItems :: Text -> Handler [Entity Item_status] 
showUsedItems urlHash = do
    player <- getPlayer urlHash
    let playerId = case player of
            Just (Entity valId _) -> valId
    runDB $ selectList [Item_statusPlayer_id ==. playerId, Item_statusStatus !=. "inventory"] []

showInventory :: Text -> Handler [Entity Item]
showInventory urlHash = do
    player <- getPlayer urlHash
    let playerId = case player of
            Just (Entity valId _) -> valId
    --runDB $ selectList [Item_statusPlayer_id ==. playerId, Item_statusStatus ==. "inventory"] []
    showInventory2 playerId
    where
        showInventory2 :: Player_statusId -> Handler [Entity Item]
        showInventory2 playerId = 
            runDB $ rawSql
              "SELECT ?? FROM item, item_status WHERE item.id = item_status.item_id AND ? = item_status.player_id"
              [toPersistValue playerId]
