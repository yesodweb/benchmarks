{-# LANGUAGE OverloadedStrings #-}
import Prelude hiding (putStr)
import Data.Text (pack)
import Data.Text.Lazy.IO (putStr)
import Data.Text.Lazy.Builder
import Numeric (showInt)
import Data.Monoid (mappend)

main = do
    putStr $ toLazyText $
      foldr mappend "</table>" ("Content-Type: text/html\n\n<table>" : replicate 1000 makeRow)

makeRow :: Builder
makeRow = foldr1 mappend $ map makeCol [1..50]

makeCol :: Int -> Builder
makeCol 1 = "<tr><td>1</td>"
makeCol 50 = "<td>50</td></tr>"
makeCol i = fromText $ pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"
