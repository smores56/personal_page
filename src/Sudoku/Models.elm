module Sudoku.Models exposing (Coordinates, PuzzleBoard, SquareValue(..), SudokuSquare)

import Set


type alias SudokuSquare =
    { expected : Int
    , current : SquareValue
    , notes : Set.Set Int
    }


type SquareValue
    = PreFilled
    | Empty
    | Filled Int


type alias PuzzleBoard =
    { puzzleIndex : Int
    , squares : List SudokuSquare
    }


type alias Coordinates =
    { x : Int
    , y : Int
    }
