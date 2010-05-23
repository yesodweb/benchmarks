{-# LANGUAGE PackageImports #-}
{-# LANGUAGE OverloadedStrings #-}
import Hyena.Server
import "hyena" Network.Wai
import Numeric (showInt)
import Data.ByteString.Char8 (pack)

main = serve $ \_ -> return (200, "OK", [("Content-Type", "text/html")], enum)

enum :: Enumerator
enum iter seed = do
    _ <- iter seed "<table>"
    sequence_ $ replicate 1000 $ makeRow iter seed
    _ <- iter seed "</table>"
    return seed

makeRow iter seed = mapM_ makeCol [1..50]
  where
    makeCol 1 = iter seed "<tr><td>1</td>"
    makeCol 50 = iter seed "<tr><td>50</td>"
    makeCol i = iter seed $ pack $ '<' : 't' : 'd' : '>' : showInt i "</td>"
