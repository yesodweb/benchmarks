{-# LANGUAGE OverloadedStrings, QuasiQuotes, TypeFamilies, CPP #-}
import Yesod.Dispatch
import Yesod.Core
import Yesod.Content
import Yesod.Handler
import Data.ByteString (ByteString)
import Network.Wai.Handler.Warp (run)

data Pong = Pong
mkYesod "Pong"
#if __GLASGOW_HASKELL__ >= 700
    [parseRoutes|
#else
    [$parseRoutes|
#endif
/static-file.txt PongR GET
|]
instance Yesod Pong where
    approot _ = ""
    encryptKey _ = return Nothing
getPongR = sendFile "text/plain" "static-file.txt" >> return ()

main = toWaiAppPlain Pong >>= run 3000
