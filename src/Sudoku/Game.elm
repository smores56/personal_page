module Sudoku.Game exposing (Model, Msg, init, keyDecoder, update, view)

import Html exposing (Html, br, button, div, h5, i, input, label, p, span, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck, onClick)
import Json.Decode as Decode
import List.Extra as List
import Random exposing (Seed)
import Set
import Sudoku.Board exposing (emptyBoard, viewBoard)
import Sudoku.Input exposing (viewInputNums)
import Sudoku.Models exposing (Coordinates, PuzzleBoard, SquareValue(..), SudokuSquare)
import Sudoku.Starters exposing (puzzleFromStarter, starterPuzzles)
import Sudoku.Utils exposing (boardIsComplete, elapsedTime, secondsReadable, updateAtCoords)
import Time exposing (Posix)



---- MODEL ----


type alias Model =
    { board : Maybe PuzzleBoard
    , selected : Maybe Coordinates
    , notesMode : Bool
    , showMistakes : Bool
    , startedTime : Maybe Posix
    , finishedTime : Maybe Posix
    , seed : Seed
    , now : Posix
    }


init : Posix -> Model
init now =
    { board = Nothing
    , selected = Nothing
    , notesMode = False
    , showMistakes = False
    , startedTime = Nothing
    , finishedTime = Nothing
    , seed = Random.initialSeed (Time.posixToMillis now)
    , now = now
    }



---- UPDATE ----


type Msg
    = ClickSquare Coordinates
    | RequestNewGame
    | InputNumber Int
    | ClearSquare
    | ClearSelection
    | ToggleNotesMode
    | ToggleShowMistakes


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickSquare coords ->
            case model.board of
                Nothing ->
                    ( model, Cmd.none )

                Just _ ->
                    ( { model
                        | selected =
                            if model.selected == Just coords then
                                Nothing

                            else
                                Just coords
                      }
                    , Cmd.none
                    )

        RequestNewGame ->
            ( pickNewPuzzle model, Cmd.none )

        InputNumber num ->
            ( inputNumber num model, Cmd.none )

        ClearSquare ->
            let
                mapper square =
                    if model.notesMode then
                        { square | notes = Set.empty }

                    else if square.current /= PreFilled then
                        { square | current = Empty }

                    else
                        square
            in
            ( model
                |> mapSelectedSquare mapper
                |> (\m -> { m | selected = Nothing })
            , Cmd.none
            )

        ClearSelection ->
            ( { model | selected = Nothing }, Cmd.none )

        ToggleNotesMode ->
            ( { model | notesMode = not model.notesMode }, Cmd.none )

        ToggleShowMistakes ->
            ( { model | showMistakes = not model.showMistakes }, Cmd.none )


pickNewPuzzle : Model -> Model
pickNewPuzzle model =
    let
        generator =
            Random.int 0 (List.length starterPuzzles - 1)

        ( index, newSeed ) =
            Random.step generator model.seed

        newPuzzle =
            starterPuzzles
                |> List.getAt index
                |> Maybe.map puzzleFromStarter
    in
    case newPuzzle of
        Just puzzle ->
            { model
                | board = Just { puzzleIndex = index, squares = puzzle }
                , startedTime = Just model.now
                , finishedTime = Nothing
                , seed = newSeed
            }

        Nothing ->
            model


inputNumber : Int -> Model -> Model
inputNumber num model =
    let
        mapper square =
            if model.notesMode then
                { square
                    | notes =
                        if square.notes |> Set.member num then
                            square.notes |> Set.remove num

                        else
                            square.notes |> Set.insert num
                }

            else if square.current /= PreFilled then
                { square | current = Filled num }

            else
                square

        updatedModel =
            model
                |> mapSelectedSquare mapper
                |> (\m ->
                        { m
                            | selected =
                                if model.notesMode then
                                    model.selected

                                else
                                    Nothing
                        }
                   )
    in
    if
        updatedModel.board
            |> Maybe.map (\b -> boardIsComplete b.squares)
            |> Maybe.withDefault False
    then
        { updatedModel | finishedTime = Just updatedModel.now }

    else
        updatedModel


mapSelectedSquare : (SudokuSquare -> SudokuSquare) -> Model -> Model
mapSelectedSquare mapper model =
    case ( model.board, model.selected ) of
        ( Just board, Just selected ) ->
            { model | board = Just { board | squares = board.squares |> updateAtCoords selected mapper } }

        _ ->
            model



---- SUBSCRIPTIONS ----


keyDecoder : Decode.Decoder Msg
keyDecoder =
    let
        parseKey key =
            case String.toInt key of
                Just x ->
                    if x >= 1 && x <= 9 then
                        Decode.succeed (InputNumber x)

                    else
                        Decode.fail ""

                Nothing ->
                    if key == " " then
                        Decode.succeed ClearSelection

                    else if key == "c" then
                        Decode.succeed ClearSquare

                    else if key == "n" then
                        Decode.succeed ToggleNotesMode

                    else if key == "m" then
                        Decode.succeed ToggleShowMistakes

                    else
                        Decode.fail ""
    in
    Decode.field "key" Decode.string
        |> Decode.andThen parseKey



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        board =
            model.board |> Maybe.withDefault emptyBoard

        context =
            { selected = model.selected
            , showMistakes = model.showMistakes
            , clickSquare = ClickSquare
            }

        playTime =
            p
                (style "font-size" "40px"
                    :: (case model.finishedTime of
                            Just _ ->
                                [ style "color" "darkgreen" ]

                            Nothing ->
                                []
                       )
                )
                [ elapsedTime model |> secondsReadable |> text ]
    in
    div []
        [ div [ class "eight columns" ]
            [ viewBoard context board
            , br [] []
            , viewInputNums InputNumber ClearSquare
            , br [] []
            ]
        , div [ class "four columns" ]
            [ playTime
            , button [ onClick RequestNewGame, style "margin-bottom" "12px" ] [ text "New Game" ]
            , label []
                [ input [ type_ "checkbox", onCheck (\_ -> ToggleShowMistakes), checked model.showMistakes ] []
                , span [ class "label-body" ] [ text "Show Mistakes" ]
                ]
            , label []
                [ input [ type_ "checkbox", onCheck (\_ -> ToggleNotesMode), checked model.notesMode ] []
                , span [ class "label-body" ] [ text "Notes Mode" ]
                ]
            , br [] []
            , h5 [] [ text "Controls:" ]
            , controlsTable
            ]
        ]


controlsTable : Html Msg
controlsTable =
    let
        controls =
            [ ( "1-9", "input a number" )
            , ( "n", "toggle notes" )
            , ( "m", "show mistakes" )
            , ( "c", "clear square" )
            , ( "space", "clear selection" )
            ]
    in
    table [ class "controls" ]
        [ thead []
            [ tr []
                [ th [] [ text "Key" ]
                , th [] [ text "Action" ]
                ]
            ]
        , tbody []
            (controls
                |> List.map
                    (\( k, v ) ->
                        tr []
                            [ td [] [ i [] [ text k ] ]
                            , td [] [ text v ]
                            ]
                    )
            )
        ]
