{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE TypeFamilies, QuasiQuotes #-}
import Yesod
import Data.ByteString.Char8 (ByteString, putStr, pack)
import Numeric (showInt)
import "wai" Network.Wai
import Network.Wai.Enumerator
import Network.Wai.Handler.FastCGI
import qualified Data.ByteString.Lazy as L

data BigTable = BigTable
mkYesod "BigTable" [$parseRoutes|/ RootR GET|]
instance Yesod BigTable where approot _ = ""
getRootR = return $ RepHtml $ toContent content
main = toWaiApp BigTable >>= run

content :: L.ByteString
content = L.fromChunks
      $ "<table>"
      : foldr ($) ["</table>"] (replicate 1000 makeRow)

makeRow :: [ByteString] -> [ByteString]
makeRow rest = foldr (:) rest $ map makeCol [1..50]

makeCol 1 = "<tr><td>1</td>"
makeCol 50 = "<td>50</td></tr>"
makeCol i = pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"
