{-# LANGUAGE OverloadedStrings, QuasiQuotes, TypeFamilies, CPP #-}
import Yesod.Dispatch
import Data.ByteString (ByteString)
import Network.Wai.Handler.Warp (run)

data Pong = Pong
mkYesod "Pong"
#if __GLASGOW_HASKELL__ >= 700
    [parseRoutes|
#else
    [$parseRoutes|
#endif
/ PongR GET
|]
instance Yesod Pong where
    approot _ = ""
    encryptKey _ = return Nothing
getPongR = return $ RepPlain $ toContent ("PONG" :: ByteString)

main = toWaiAppPlain Pong >>= run 3000
