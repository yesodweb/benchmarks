{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import           Snap.Http.Server
import           Snap.Http.Server.Config
import           Snap.Iteratee
import           Snap.Types
import           Snap.Util.FileServe

site :: Snap ()
site = writeBS "PONG"

main :: IO ()
main =
    let config = addListen (ListenHttp "*" 3000) $
                 setAccessLog Nothing $
                 setErrorLog Nothing $
                 defaultConfig
     in httpServe config site
