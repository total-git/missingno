module Handler.GameHome where

import Import
import Handler.Game
import Crypto.Random (SystemRandom)
import Control.Monad.CryptoRandom
import Data.ByteString.Base16 (encode)
import DbFunctions

-- generate a random id (8 bytes) and forward to the corresponding site
-- see http://www.yesodweb.com/book/yesods-monads#yesods-monads_adding_a_new_monad_transformer
getGameHomeR :: Handler Html
getGameHomeR = do
    gen <- liftIO newGenIO
    eres <- evalCRandT (getBytes 8) (gen :: SystemRandom)
    pId <- case eres of
        Left e -> error $ show (e :: GenError)
        Right g -> return g
    let urlHash = decodeUtf8 $ encode pId
    _ <- insertPlayer urlHash
    getGameR urlHash
