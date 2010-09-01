{-# LANGUAGE OverloadedStrings #-}
import Prelude hiding (putStr)
import Data.ByteString.Char8 (pack)
import Text.Blaze.Builder.Core
import qualified Data.ByteString.Lazy as L
import Numeric (showInt)
import Data.Monoid (mappend)

main = do
    L.putStr $ toLazyByteString $
      foldr mappend (fbs "</table>") (fbs "Content-Type: text/html\n\n<table>" : replicate 1000 makeRow)

makeRow :: Builder
makeRow = foldr1 mappend $ map makeCol [1..50]

makeCol :: Int -> Builder
makeCol 1 = fbs "<tr><td>1</td>"
makeCol 50 = fbs "<td>50</td></tr>"
makeCol i = fbs $ '<' : 't' : 'd' : '>' : showInt i "</td>"

fbs = fromByteString . pack
