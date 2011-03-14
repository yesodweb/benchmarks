module Main where

import Happstack.Server

main = simpleHTTP nullConf
    { logAccess = Nothing
    } $ ok "PONG"
