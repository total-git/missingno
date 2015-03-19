module Handler.HelloWorld where

import Import
import DbFunctions

getHelloWorldR :: Handler Html
getHelloWorldR = do
    uniqueItem <- lookAtItemByUnique "testchair" 1
    itemsInArea <- showItemsInArea 1
    defaultLayout $ do
        setTitle "Test"
        [whamlet|
        $maybe (Entity itemKey itemVal) <- uniqueItem
          #{itemItem_description itemVal}
        |]
        [whamlet|
        $forall (Entity itemKey itemVal) <- itemsInArea
          #{itemItem_description itemVal}
        |]
