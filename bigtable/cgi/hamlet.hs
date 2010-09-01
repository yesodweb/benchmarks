{-# LANGUAGE QuasiQuotes #-}
import Text.Hamlet
import Numeric (showInt)
import Data.Text (pack)
import qualified Data.ByteString.Lazy as L

main = do
    let rows = replicate 1000 makeRow
    putStrLn "Content-Type: text/html\n"
    L.putStr $ renderHamlet undefined [$hamlet|
%table
    $forall rows row
        ^row^
|]

makeRow = [$hamlet|
%tr
    $forall cols col
        %td $showInt'.col$
|]
  where
    showInt' i = preEscapedString $ showInt i ""
    cols = [1..50]
