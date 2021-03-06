{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module IO.HTTP.GitHub.Card
    ( MaybeCard(MaybeCard)
    , maybeCardToTask
    , content_url
    ) where

import ClassyPrelude

import Control.Lens (makeLenses, (^.))

import qualified Data.Taskell.Task      as T (Task, new)
import           IO.HTTP.Aeson          (deriveFromJSON)
import           IO.HTTP.GitHub.Utility (cleanUp)

data MaybeCard = MaybeCard
    { _note        :: Maybe Text
    , _content_url :: Maybe Text
    } deriving (Eq, Show)

-- strip underscores from field labels
$(deriveFromJSON ''MaybeCard)

-- create lenses
$(makeLenses ''MaybeCard)

-- operations
maybeCardToTask :: MaybeCard -> Maybe T.Task
maybeCardToTask card = T.new . cleanUp <$> card ^. note
