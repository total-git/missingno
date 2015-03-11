module DbFunctions where

import Import

look_at itemN= do
    item <- runDB $ selectList [ItemName ==. itemN] []
    if null item
      then liftIO $ putStrLn "No items with this Name"
      else forM_ item printDescription
    where
      printDescription (Entity a b) = do
        print $ unItemKey a
        print $ b
        putStrLn $ itemItem_description b

