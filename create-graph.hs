{-# LANGUAGE OverloadedStrings #-}
import Data.XML.Types
import Text.XML.Enumerator.Document (writeFile)
import qualified Data.Map as Map
import Prelude hiding (writeFile)
import Data.Text (pack)

largest = 900

results =
    [ ("warp", 81700.9)
    , ("yesod", 64027.8)
    , ("happstack", 35810.8)
    , ("snap", 35272.2)
    , ("node", 18654.4)
    , ("winstone", 4659.6)
    , ("php", 3416.9)
    , ("tornado", 3416.0)
    , ("goliath", 3236.9)
    ]
{-
    [ ("warp", 53924.6)
    , ("yesod", 49355.3)
    , ("happstack", 29696.2)
    , ("snap", 27987.8)
    , ("node", 13610.1)
    , ("winstone", 4551.7)
    , ("tornado", 3321.7)
    , ("goliath", 3007.9)
    , ("php", 2728.1)
    ]
-}

doctype = Doctype "svg" (Just $ PublicID "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd") []

svg = Element "{http://www.w3.org/2000/svg}svg" (Map.fromList
    [ ("version", [ContentText "1.1"])
    , ("font-family", [ContentText "DejaVu Sans"])
    , ("font-size", [ContentText "16pt"])
    ]) $ map NodeElement $ concat $ zipWith mkResult [0..] $ reverse results

mkResult i (name, val) =
    [ Element "{http://www.w3.org/2000/svg}rect" (Map.fromList
        [ ("width", [ContentText "50"])
        , ("height", [ContentText $ pack $ show $ normalize val'])
        , ("x", [ContentText $ pack $ show $ i * 60])
        , ("y", [ContentText $ pack $ show $ normalize $ largest - val'])
        , ("style", [ContentText $ pack $ concat
                        [ "fill:#"
                        , (cycle colors) !! i
                        , ";stroke-width:1;stroke:black"
                        ]])
        ]) []
    , Element "{http://www.w3.org/2000/svg}text" (Map.fromList
        [ ("x", [ContentText $ pack $ show x])
        , ("y", [ContentText $ pack $ show y])
        , ("transform", [ContentText $ pack $ concat ["rotate(45, ", show x, ", ", show y, ")"]])
        ]) [NodeContent $ ContentText $ pack name]
    , Element "{http://www.w3.org/2000/svg}text" (Map.fromList
        [ ("x", [ContentText $ pack $ show $ x - 10])
        , ("y", [ContentText $ pack $ show $ normalize (largest - val') - 5])
        , ("font-size", [ContentText "8pt"])
        ]) [NodeContent $ ContentText $ pack $ prettyNum val]
    ]
  where
    y = normalize largest + 20
    x = 20 + i * 60
    val' = val / 100
    normalize = (*) 0.4

prettyNum = prettyInt . round

prettyInt x
    | x < 1000 = show x
    | otherwise =
        let (y, z) = x `divMod` 1000
         in prettyInt y ++ ',' : showLead z
  where
    showLead a
        | a < 10 = '0' : '0' : show a
        | a < 100 = '0' : show a
        | otherwise = show a

main = writeFile "benchmark2.svg" $ Document (Prologue [] (Just doctype) []) svg []

colors =
    [ "990033"
    , "336699"
    , "FFFF00"
    , "669966"
    ]
