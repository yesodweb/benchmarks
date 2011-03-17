module Main where

import Happstack.Server

main = simpleHTTP nullConf
    { logAccess = Nothing
    , port = 3000
    } $ ok "PONG"
