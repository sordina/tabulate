{-# Language OverloadedStrings #-}

import Control.Arrow      ((&&&), (***), (>>>))
import System.Environment (getArgs)

import qualified Data.List    as L
import qualified Data.Text    as T
import qualified Data.Text.IO as T

main :: IO ()
main = getArgs >>= run

run :: [String] -> IO ()
run []    = run ["\t"]
run [sep] = exec (T.pack sep)
run _     = putStrLn "Usage: tabulate [delimiter]"

exec :: T.Text -> IO ()
exec sep = T.interact tabulate where

  tabulate           = rows
                   >>> (map L.length &&& id)
                   >>> (fst &&& pipeline)
                   >>> uncurry (zipWith L.take)
                   >>> unrows

  pipeline           = (maximum *** id)
                   >>> uncurry strip
                   >>> columns
                   >>> (lengths &&& id)
                   >>> uncurry (zipWith uncolumns)
                   >>> L.transpose

  rows               = T.lines >>> map (T.splitOn sep)
  strip num          = map ((++ L.repeat "") >>> L.take num)
  columns            = L.transpose
  lengths            = map (map T.length >>> maximum)
  uncolumns width    = map (T.justifyLeft width ' ')
  unrows             = map (T.intercalate sep >>> T.stripEnd) >>> T.unlines
