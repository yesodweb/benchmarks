{-# LANGUAGE OverloadedStrings #-}
import Network.Wai
import Network.Wai.Handler.Warp
import Blaze.ByteString.Builder (fromByteString)

main = run 3000 $ const $ return $ ResponseFile
    status200
    [("Content-Type", "text/plain"), ("Content-Length", "23")]
    "static-file.txt"
