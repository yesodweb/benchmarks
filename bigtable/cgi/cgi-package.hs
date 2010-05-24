{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
import Prelude hiding (putStr)
import Data.ByteString.Char8 (ByteString, putStr, pack)
import Numeric (showInt)
import qualified Data.ByteString.Lazy as L
import Network.CGI

main = runCGI app

app = do
    setHeader "Content-Type" "text/html"
    outputFPS content

content = L.fromChunks
      $ "<table>"
      : foldr ($) ["</table>"] (replicate 1000 makeRow)

makeRow :: [ByteString] -> [ByteString]
makeRow rest = foldr (:) rest $ map makeCol [1..50]

makeCol 1 = "<tr><td>1</td>"
makeCol 50 = "<td>50</td></tr>"
makeCol i = pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"
