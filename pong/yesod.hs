{-# LANGUAGE OverloadedStrings, QuasiQuotes, TypeFamilies, TemplateHaskell, MultiParamTypeClasses #-}
import Yesod.Dispatch
import Yesod.Core
import Yesod.Content
import Data.ByteString (ByteString)
import Network.Wai.Handler.Warp (run)

data Pong = Pong
mkYesod "Pong" [parseRoutes|
/ PongR GET
|]

instance Yesod Pong where
    makeSessionBackend _ = return Nothing

getPongR = return $ RepPlain $ toContent ("PONG" :: ByteString)

main = toWaiAppPlain Pong >>= run 3000
