{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module IO.TrelloTest
    ( test_trello
    ) where

import ClassyPrelude

import Control.Lens ((^.))

import Test.Tasty
import Test.Tasty.HUnit

import Data.Aeson     (decodeStrict)
import Data.FileEmbed (embedFile)

import IO.HTTP.Trello.ChecklistItem (ChecklistItem, checkItems, checklistItemToSubTask)
import IO.HTTP.Trello.List          (List, listToList)

json :: Maybe [List]
json = decodeStrict $(embedFile "test/IO/data/trello.json")

checklistJson :: Maybe [ChecklistItem]
checklistJson = (^. checkItems) <$> decodeStrict $(embedFile "test/IO/data/trello-checklists.json")

-- tests
test_trello :: TestTree
test_trello =
    testGroup
        "IO.Trello"
        [ testCase
              "Lists"
              (assertEqual "Parses list JSON" (Just 5) (length . (listToList <$>) <$> json))
        , testCase
              "Checklists"
              (assertEqual
                   "Parses checklist JSON"
                   (Just 5)
                   (length . (checklistItemToSubTask <$>) <$> checklistJson))
        ]
