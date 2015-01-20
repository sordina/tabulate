{-# Language OverloadedStrings #-}

import Control.Arrow      ((&&&), first, (>>>))
import System.Environment (getArgs)

import qualified Data.List    as L
import qualified Data.Text    as T
import qualified Data.Text.IO as T

main :: IO ()
main = getArgs >>= run

run :: [String] -> IO ()
run []                    = exec "\t" "\t"
run ["-h"]                = help
run ["--help"]            = help
run ["--", sep]           = exec (T.pack sep  ) (T.pack sep   )
run ["--", inSep, outSep] = exec (T.pack inSep) (T.pack outSep)
run [sep]                 = exec (T.pack sep  ) (T.pack sep   )
run [inSep, outSep]       = exec (T.pack inSep) (T.pack outSep)
run _                     = help

help :: IO ()
help = putStrLn "Usage: tabulate [-h|--help] [--] [delimiter] [joiner]"

exec :: T.Text -> T.Text -> IO ()
exec inSep outSep = T.interact tabulate where

  tabulate           = T.lines
                   >>> map splitRow
                   >>> (map L.length &&& id)
                   >>> (fst &&& rectangle)
                   >>> uncurry (zipWith L.take)
                   >>> map joinRow
                   >>> T.unlines

  rectangle          = first maximum
                   >>> uncurry strip
                   >>> toColumns
                   >>> (lengths &&& id)
                   >>> uncurry (zipWith justify)
                   >>> toRows

  splitRow           = T.splitOn inSep
  strip num          = map ((++ L.repeat "") >>> L.take num)
  toColumns          = L.transpose
  toRows             = L.transpose
  lengths            = map (map T.length >>> maximum)
  justify width      = map (T.justifyLeft width ' ')
  joinRow            = T.intercalate outSep >>> T.stripEnd
