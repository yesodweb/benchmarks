{-# LANGUAGE QuasiQuotes #-}
import Text.Hamlet
import Text.Hamlet.Monad
import Numeric (showInt)
import Data.ByteString.Char8 (pack)

main = do
    let rows = replicate 1000 makeRow
    putStrLn "Content-Type: text/html\n"
    printHamlet undefined [$hamlet|
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
    showInt' i = Encoded $ pack $ showInt i ""
    cols = [1..50]
