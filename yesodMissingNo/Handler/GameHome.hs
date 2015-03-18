module Handler.GameHome where

import Import
import Handler.Game
-- import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3)

getGameHomeR :: Handler Html
getGameHomeR = do
    -- (formWidget, formEnctype) <- generateFormPost gameHomeForm
    defaultLayout $ do
        setTitle "Welcome to the game!"
        $(widgetFile "gameHome")

postGameHomeR :: Handler Html
postGameHomeR = postGameR "Eva"

-- gameHomeForm :: Form
-- gameHomeForm = renderBootstrap3 BootstrapBasicForm $
--     bootstrapSubmit "Enter Game"
