module Handler.Game where

import Import
import Yesod.Form.Bootstrap3

data Input = Input Text deriving Show

getGameR :: Text -> Handler Html
getGameR id = do
    defaultLayout [whamlet|Welcome to the game, #{id}|]
--     (formWidget, formEnctype) <- generateFormPost gameForm
--     let submission = Nothing :: Maybe (FileInfo, Text)
--         handlerName = "getGameR" :: Text
--     defaultLayout $ do
--         aDomId <- newIdent
--         setTitle "Welcome to the game!"
--         -- $(widgetFile "game")
--         [whamlet|Welcome to the game, #{id}|]

-- postGameR :: Text -> Handler Html
-- postGameR id = do
--     ((result, formWidget), formEnctype) <- runFormPost gameForm
--     let handlerName = "postGameR" :: Text
--         submission = case result of
--             FormSuccess res -> Just res
--             _ -> Nothing
--     defaultLayout $ do
--         aDomId <- newIdent
--         setTitle "Welcome to the game!"
--         -- $(widgetFile "game")
--         [whamlet|Thanks for posting, #{submission}|]
-- 
-- gameAForm :: AForm Handler Input
-- gameAForm = Input
--     <$> areq textField "Input" Nothing
-- 
-- gameForm :: Html -> MForm Handler (FormResult Input, Widget)
-- gameForm = renderTable $ Input $
--     areq textField "Input" Nothing

-- gameForm :: AForm Handler Input
-- gameForm = Input
--     <$> areq textField (bfs ("Name" :: Text)) Nothing
