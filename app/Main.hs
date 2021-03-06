module Main where

import qualified Data.Text                     as T
import System.Environment

import BrickApp
import Config
import Config.ConfigOpen
import Config.Bookmarks
import Config.Homepage
import Config.Theme

handleArgs :: [String] -> IO ()
handleArgs []                      = uiMain Nothing
handleArgs (host:port:resource:[]) = uiMain (Just (T.pack host, read port :: Int, T.pack resource))
handleArgs (_)                     = error "Error! Need to supply host, port, and selector (or no args!). For empty selector you can use \"\"."

main :: IO ()
main = do
  -- First do config file check
  -- FIXME: hacky doing setup here...
  -- maybe could have a cli option to reset even
  setupConfigDirectory
  setupDefaultOpenConfig
  setupDefaultBookmarks
  setupDefaultHomepageConfig
  setupDefaultTheme
  -- Now run!
  args <- getArgs
  handleArgs args
