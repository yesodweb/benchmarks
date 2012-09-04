{-# LANGUAGE OverloadedStrings, QuasiQuotes, TypeFamilies, CPP, TemplateHaskell, MultiParamTypeClasses #-}
import Yesod.Dispatch
import Yesod.Core
import Yesod.Content
import Yesod.Handler
import Data.ByteString (ByteString)
import Network.Wai.Handler.Warp (run)
import Blaze.ByteString.Builder (copyByteString)
import Blaze.ByteString.Builder.Char8 (fromShow)
import Data.Monoid (mappend, mempty)

data Pong = Pong
mkYesod "Pong"
#if __GLASGOW_HASKELL__ >= 700
    [parseRoutes|
#else
    [$parseRoutes|
#endif
/bigtable.html PongR GET
|]
instance Yesod Pong where
    makeSessionBackend _ = return Nothing

getPongR = return $ RepHtml $ ContentBuilder table Nothing

main = toWaiAppPlain Pong >>= run 3000

table =
    copyByteString "<html><body><table>\n"
    `mappend` tableBody 1
    `mappend` copyByteString "</table></body></html>"

tableRow x
  | x <= 50   =
    copyByteString "<td>"
    `mappend` fromShow x
    `mappend` copyByteString "</td>"
    `mappend` tableRow (x + 1)
  | otherwise = mempty

tableBody x
  | x <= 1000 =
    copyByteString "<tr><td>"
    `mappend` fromShow x
    `mappend` copyByteString "</td>"
    `mappend` tableRow 1
    `mappend` copyByteString "</tr>\n"
    `mappend` tableBody (x + 1)
  | otherwise = mempty
