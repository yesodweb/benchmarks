{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
import Prelude hiding (putStr)
import Data.ByteString.Char8 (ByteString, putStr, pack)
import Numeric (showInt)
import qualified Data.ByteString.Lazy as L
import "direct-fastcgi" Network.FastCGI
import Control.Concurrent

main = acceptLoop forkIO app

app = do
    setResponseHeader HttpContentType "text/html"
    mapM_ fPut content

content = "<table>"
      : foldr ($) ["</table>"] (replicate 1000 makeRow)

makeRow :: [ByteString] -> [ByteString]
makeRow rest = foldr (:) rest $ map makeCol [1..50]

makeCol 1 = "<tr><td>1</td>"
makeCol 50 = "<td>50</td></tr>"
makeCol i = pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"
