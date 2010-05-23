{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import           System
import           Control.Applicative
import "monads-fd" Control.Monad.Trans
import qualified Data.ByteString.Char8 as BS
import           Snap.Http.Server
import           Snap.Iteratee
import           Snap.Types
import           Snap.Util.FileServe
import           Text.Templating.Heist
import Numeric (showInt)
import qualified Data.ByteString.Lazy as L
import           Data.ByteString (ByteString)

allData :: [ByteString]
allData = "<table>" : foldr ($) ["</table>"] (replicate 1000 makeRow)

makeRow :: [ByteString] -> [ByteString]
makeRow rest = foldr (:) rest $ map makeCol [1..50]

makeCol 1 = "<tr><td>1</td>"
makeCol 50 = "<td>50</td></tr>"
makeCol i = BS.pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"

tableServer :: Snap ()
tableServer = writeLBS $ L.fromChunks allData

main :: IO ()
main = do
    args <- getArgs
    let port = case args of
                   []  -> 8000
                   p:_ -> read p
    httpServe "*" port "myserver"
        Nothing -- (Just "access.log")
        Nothing -- (Just "error.log")
        tableServer
