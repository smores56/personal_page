module Sudoku.Input exposing (viewInputNums)

import Html exposing (Html, b, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


viewInputNums : (Int -> msg) -> msg -> Html msg
viewInputNums clickNumber clearNumber =
    div
        [ class "sudoku-board" ]
        [ div [ class "sudoku-row" ]
            ((List.range 1 9 |> List.map (viewInputNum clickNumber))
                ++ [ numWrapper clearNumber "⌫" ]
            )
        ]


viewInputNum : (Int -> msg) -> Int -> Html msg
viewInputNum clickNumber num =
    numWrapper (clickNumber num) (String.fromInt num)


numWrapper : msg -> String -> Html msg
numWrapper handleClick content =
    div [ class "input-square", onClick handleClick ]
        [ b [] [ text content ] ]
