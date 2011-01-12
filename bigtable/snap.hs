{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import qualified Data.ByteString.Char8 as BS
import           Snap.Http.Server
import           Snap.Iteratee
import           Snap.Types
import           Snap.Util.FileServe


tableRow :: Int -> Snap ()
tableRow x
  | x <= 50   = do
                  writeBS "<td>" 
                  writeBS (BS.pack (show x))
                  writeBS "</td>"
                  tableRow (x+1)
  | otherwise = return ()

tableBody :: Int -> Snap ()
tableBody x
  | x <= 1000 = do 
                  writeBS "<tr><td>"
                  writeBS (BS.pack (show x))
                  writeBS "</td>"
                  tableRow 1 
                  writeBS "</tr>\n"
                  tableBody (x+1)
  | otherwise = return ()

tableServer :: Snap ()
tableServer = do
    writeBS "<html><body><table>\n"
    tableBody 1
    writeBS "</table></body></html>"

main :: IO ()
main =
    let config = addListen (ListenHttp "*" 3000) $
                 setAccessLog Nothing $
                 setErrorLog Nothing $
                 defaultConfig
     in httpServe config tableServer
