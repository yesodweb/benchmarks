{-# LANGUAGE OverloadedStrings #-}
import Prelude hiding (putStr)
import Data.Text (Text, pack)
import Data.Text.IO (putStr)
import Numeric (showInt)

main = do
    mapM_ putStr $
        "Content-Type: text/html\n\n<table>"
      : foldr ($) ["</table>"] (replicate 1000 makeRow)

makeRow :: [Text] -> [Text]
makeRow rest = foldr (:) rest $ map makeCol [1..50]

makeCol 1 = "<tr><td>1</td>"
makeCol 50 = "<td>50</td></tr>"
makeCol i = pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"
