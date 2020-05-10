module Sudoku.Utils exposing (boardIsComplete, elapsedTime, secondsReadable, updateAtCoords, zipBoardWithCoords)

import List.Extra as List
import Sudoku.Models exposing (Coordinates, SquareValue(..), SudokuSquare)
import Time exposing (Posix, posixToMillis)


updateAtCoords : Coordinates -> (a -> a) -> List a -> List a
updateAtCoords coords mapper =
    List.updateAt (coords.y * 9 + coords.x) mapper


boardIsComplete : List SudokuSquare -> Bool
boardIsComplete =
    List.all
        (\sq ->
            case sq.current of
                PreFilled ->
                    True

                Empty ->
                    False

                Filled num ->
                    num == sq.expected
        )


zipBoardWithCoords : List SudokuSquare -> List ( Coordinates, SudokuSquare )
zipBoardWithCoords =
    List.indexedMap (\index sq -> ( { x = modBy 9 index, y = index // 9 }, sq ))


elapsedTime : { a | startedTime : Maybe Posix, finishedTime : Maybe Posix, now : Posix } -> Int
elapsedTime { startedTime, finishedTime, now } =
    case ( startedTime, finishedTime ) of
        ( Just start, Just finish ) ->
            (posixToMillis finish - posixToMillis start) // 1000

        ( Just start, Nothing ) ->
            (posixToMillis now - posixToMillis start) // 1000

        _ ->
            0


secondsReadable : Int -> String
secondsReadable seconds =
    (seconds // 60 |> String.fromInt)
        ++ ":"
        ++ (seconds |> modBy 60 |> String.fromInt |> String.padLeft 2 '0')
