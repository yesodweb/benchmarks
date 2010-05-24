{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
import Prelude hiding (putStr)
import Data.ByteString.Char8 (ByteString, putStr, pack)
import Numeric (showInt)
import "wai" Network.Wai
import Network.Wai.Enumerator
import Network.Wai.Handler.SimpleServer
import qualified Data.ByteString.Lazy as L

main = run 3000 app

app _ = return $ Response Status200 [(ContentType, "text/html")] $ Right $
            fromLBS content

content :: L.ByteString
content = L.fromChunks
      $ "Content-Type: text/html\n\n<table>"
      : foldr ($) ["</table>"] (replicate 1000 makeRow)

makeRow :: [ByteString] -> [ByteString]
makeRow rest = foldr (:) rest $ map makeCol [1..50]

makeCol 1 = "<tr><td>1</td>"
makeCol 50 = "<td>50</td></tr>"
makeCol i = pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"
