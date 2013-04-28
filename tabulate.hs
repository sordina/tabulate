{-# Language OverloadedStrings #-}

import Control.Arrow      ((&&&), (>>>))
import Prelude            (flip, map, uncurry, zipWith, maximum, id, (==), (>>=), putStrLn, IO, String)
import Data.List          (transpose)
import Data.Text          (Text, lines, intercalate, length, splitOn, justifyLeft, unlines, stripEnd, pack)
import Data.Text.IO       (interact)
import System.Environment (getArgs)

main :: IO ()
main = getArgs >>= run

run :: [String] -> IO ()
run []    = run ["\t"]
run [sep] = exec (pack sep)
run _     = putStrLn "Usage: tabulate [delimiter]"

exec :: Text -> IO ()
exec sep = interact tabulate
  where
    tabulate :: Text ->  Text
    tabulate  = rows >>> columns
                     >>> (lengths &&& id)
                     >>> uncurry (zipWith uncolumns)
                     >>> unrows

    rows            = lines >>> map (splitOn sep)
    columns         = transpose
    lengths         = map (map length >>> maximum)
    uncolumns width = map (justifyLeft width ' ')
    unrows          = transpose >>> map (intercalate sep >>> stripEnd) >>> unlines
