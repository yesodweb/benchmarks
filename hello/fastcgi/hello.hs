{-# LANGUAGE OverloadedStrings #-}
import Network.Wai
import Network.Wai.Handler.FastCGI
main = run $ const $ return Response
    { responseBody = ResponseLBS "Hello World"
    , status = status200
    , responseHeaders = [("Content-Type", "text/plain")]
    }
