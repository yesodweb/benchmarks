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
main = do
    args <- getArgs
    let port = case args of
                   []  -> 8000
                   p:_ -> read p
    httpServe "*" port "myserver"
        Nothing -- (Just "access.log")
        Nothing -- (Just "error.log")
        tableServer
