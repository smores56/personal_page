port module Main exposing (main)

import Browser
import Browser.Events exposing (onKeyPress)
import Components.Sidebar exposing (sidebar)
import Components.Tabs exposing (TabName(..), tabs)
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class, style)
import Sudoku.Game exposing (Msg(..), keyDecoder)
import Time exposing (Posix, millisToPosix)



---- MODEL ----


type alias Model =
    { tab : TabName
    , sudoku : Sudoku.Game.Model
    }


init : Int -> ( Model, Cmd Msg )
init now =
    ( { tab = TabWork
      , sudoku = Sudoku.Game.init (millisToPosix now)
      }
    , Cmd.none
    )



---- UPDATE ----


port playChord : List String -> Cmd msg


port playTheLick : () -> Cmd msg


type Msg
    = SelectTab TabName
    | SudokuMsg Sudoku.Game.Msg
    | PlayChord (List String)
    | PlayTheLick
    | TickNow Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectTab tab ->
            ( { model | tab = tab }, Cmd.none )

        SudokuMsg m ->
            let
                ( sudoku, sudokuMsg ) =
                    Sudoku.Game.update m model.sudoku
            in
            ( { model | sudoku = sudoku }, Cmd.map SudokuMsg sudokuMsg )

        PlayChord chord ->
            ( model, playChord chord )

        PlayTheLick ->
            ( model, playTheLick () )

        TickNow now ->
            let
                sudoku =
                    model.sudoku
            in
            ( { model | sudoku = { sudoku | now = now } }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "row" ]
            [ h1 [ style "text-align" "center", style "font-size" "60px" ]
                [ text "Sam Mohr" ]
            ]
        , div [ class "row" ]
            [ div [ class "four columns u-pull-left" ]
                [ sidebar ]
            , div [ class "eight columns" ]
                [ tabs
                    { currentTab = model.tab
                    , sudoku = model.sudoku
                    , sudokuMsg = SudokuMsg
                    , clickTab = SelectTab
                    , playChord = PlayChord
                    , playTheLick = PlayTheLick
                    }
                ]
            ]
        ]



---- PROGRAM ----


main : Program Int Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions =
            \_ ->
                Sub.batch
                    [ onKeyPress keyDecoder |> Sub.map SudokuMsg
                    , Time.every 200 TickNow
                    ]
        }
