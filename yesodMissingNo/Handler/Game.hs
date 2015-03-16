module Handler.Game where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3, withSmallInput)

getGameR :: Text -> Handler Html
getGameR id = do
    (formWidget, formEnctype) <- generateFormPost gameForm
    let submission = Nothing :: Maybe (Text)
        -- handlerName = "getGameR" :: Text
    defaultLayout $ do
        -- aDomId <- newIdent
        setTitle "Welcome to the game!"
        -- $(widgetFile "game")
        [whamlet|Welcome to the game, #{id}|]
        [whamlet|
            Enter Text:
            <form method=post action=@{HomeR} enctype=#{formEnctype}>
            ^{formWidget}
            <button>Submit
            |]


postGameR :: Text -> Handler Html
postGameR id = do
    ((result, formWidget), formEnctype) <- runFormPost gameForm
    -- let handlerName = "postGameR" :: Text
    case result of
        FormSuccess res -> defaultLayout [whamlet|Thanks for posting, #{res}|]
        _ -> defaultLayout [whamlet|
            Try again:
            <form method=post action=@{HomeR} enctype=#{formEnctype}>
            ^{formWidget}
            <button>Submit
            |]

gameForm :: Form Text
gameForm = renderBootstrap3 BootstrapBasicForm $
    areq textField "Input" Nothing
