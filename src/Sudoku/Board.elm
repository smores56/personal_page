module Sudoku.Board exposing (emptyBoard, viewBoard, viewSquare)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import List.Extra as List
import Set
import Sudoku.Models exposing (Coordinates, PuzzleBoard, SquareValue(..), SudokuSquare)
import Sudoku.Utils exposing (zipBoardWithCoords)


type alias ViewBoardContext msg =
    { selected : Maybe Coordinates
    , showMistakes : Bool
    , clickSquare : Coordinates -> msg
    }


viewBoard : ViewBoardContext msg -> PuzzleBoard -> Html msg
viewBoard context board =
    let
        viewRow row =
            div [ class "sudoku-row" ]
                (row
                    |> List.map (viewSquare context)
                )
    in
    div
        [ class "sudoku-board" ]
        (board.squares
            |> zipBoardWithCoords
            |> List.groupsOf 9
            |> List.map viewRow
        )


squareBgColor : ViewBoardContext msg -> Coordinates -> SudokuSquare -> String
squareBgColor context coords square =
    let
        visiblyWrong =
            case square.current of
                Filled num ->
                    num /= square.expected && context.showMistakes

                _ ->
                    False

        isSelected =
            context.selected |> Maybe.map ((==) coords) |> Maybe.withDefault False
    in
    if square.current == PreFilled then
        "#ebebeb"

    else if visiblyWrong then
        if isSelected then
            "#d98282"

        else
            "#e8aeae"

    else if isSelected then
        "#adadad"

    else
        "#ffffff"


viewSquare : ViewBoardContext msg -> ( Coordinates, SudokuSquare ) -> Html msg
viewSquare context ( coords, square ) =
    let
        value =
            case square.current of
                PreFilled ->
                    String.fromInt square.expected

                Empty ->
                    ""

                Filled val ->
                    String.fromInt val
    in
    div
        ([ class "sudoku-square"
         , style "background-color" (squareBgColor context coords square)
         , onClick (context.clickSquare coords)
         ]
            ++ squareBorder coords
        )
        [ text value, div [ class "sudoku-note" ] [ text (square.notes |> Set.toList |> List.map String.fromInt |> String.join " ") ] ]


emptyBoard : PuzzleBoard
emptyBoard =
    { puzzleIndex = 0
    , squares = { expected = 0, current = Empty, notes = Set.empty } |> List.repeat 81
    }


squareBorder : Coordinates -> List (Html.Attribute msg)
squareBorder coords =
    [ ( "border", "1px solid black", True )
    , ( "border-top-width", "2px", modBy 3 coords.y == 0 )
    , ( "border-top-width", "4px", coords.y == 0 )
    , ( "border-bottom-width", "2px", modBy 3 coords.y == 2 )
    , ( "border-bottom-width", "4px", coords.y == 8 )
    , ( "border-left-width", "2px", modBy 3 coords.x == 0 )
    , ( "border-left-width", "4px", coords.x == 0 )
    , ( "border-right-width", "2px", modBy 3 coords.x == 2 )
    , ( "border-right-width", "4px", coords.x == 8 )
    ]
        |> List.filterMap
            (\( key, value, include ) ->
                if include then
                    Just (style key value)

                else
                    Nothing
            )
