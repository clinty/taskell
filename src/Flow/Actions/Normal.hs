module Flow.Actions.Normal (event) where

import Graphics.Vty.Input.Events
import Data.Char (isDigit)
import Flow.State

-- Normal 
event :: Event -> Stateful

-- quit
event (EvKey (KChar 'q') _) = quit

-- add/edit
event (EvKey (KChar 'e') _) = startInsert
event (EvKey (KChar 'i') _) = startInsert
event (EvKey (KChar 'a') _) = (startInsert =<<) . newItem
event (EvKey (KChar 'O') _) = (startInsert =<<) . above 
event (EvKey (KChar 'o') _) = (startInsert =<<) . below

-- add list
event (EvKey (KChar 'N') _) = createListStart
event (EvKey (KChar 'X') _) = (write =<<) . deleteCurrentList

-- navigation
event (EvKey (KChar 'k') _) = previous
event (EvKey (KChar 'j') _) = next
event (EvKey (KChar 'h') _) = left
event (EvKey (KChar 'l') _) = right
event (EvKey (KChar 'G') _) = bottom

-- moving items
event (EvKey (KChar 'K') _) = (write =<<) . up
event (EvKey (KChar 'J') _) = (write =<<) . down
event (EvKey (KChar 'H') _) = (write =<<) . moveLeft
event (EvKey (KChar 'L') _) = (write =<<) . moveRight
event (EvKey (KChar ' ') _) = (write =<<) . moveRight

-- removing items
event (EvKey (KChar 'D') _) = (write =<<) . delete

-- moving lists
event (EvKey (KChar '>') _) = (write =<<) . listRight
event (EvKey (KChar '<') _) = (write =<<) . listLeft

-- selecting lists
event (EvKey (KChar n) _)
    | isDigit n = selectList n
    | otherwise = return

-- fallback
event _ = return
