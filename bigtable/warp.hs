{-# LANGUAGE OverloadedStrings #-}
import Network.Wai
import Network.Wai.Handler.Warp
import Blaze.ByteString.Builder (copyByteString, fromLazyByteString, toLazyByteString)
import Blaze.ByteString.Builder.Char8 (fromShow)
import Data.Monoid (mappend, mempty)

main = run 3000 $ const $ return $ ResponseBuilder
    status200
    [("Content-Type", "text/html")]
    table

table = {-fromLazyByteString $ toLazyByteString $-}
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
