module Components.OnTheSide exposing (onTheSideTab)

import Html exposing (Html, br, button, div, i, p, text)
import Html.Attributes exposing (style, title)
import Html.Events exposing (onClick)
import Sudoku.Game exposing (Model, Msg)


onTheSideTab : msg -> (List String -> msg) -> (Msg -> msg) -> Model -> Html msg
onTheSideTab playTheLick playChord sudokuMsg model =
    div []
        [ p []
            [ text
                ("I love music, and I love learning more about why it works and how I can use it to express "
                    ++ "myself better. That's the great thing about music theory: it's fun to learn "
                )
            , i [] [ text "and" ]
            , text
                (" it makes you a better artist. Below are some of the more interesting chords that I've "
                    ++ "encountered in music written by others or that I stumbled upon while writing music or "
                    ++ "playing piano:"
                )
            ]
        , p [] (chords |> List.map (chordButton playChord))
        , p []
            [ text "And just for fun:"
            , button [ style "margin-left" "10px", onClick playTheLick ] [ text "The Lick" ]
            ]
        , p []
            [ text
                ("I think that Sudoku needs no explanation. It was fun to implement this all by myself, and "
                    ++ "writing it in Elm (which is what this site is written in) made my life pretty easy. There are 100 "
                    ++ "random puzzles of varying difficuly, so just hit the \"New Game\" button and have at it!"
                )
            ]
        , br [] []
        , Sudoku.Game.view model
            |> Html.map sudokuMsg
        ]


chordButton : (List String -> msg) -> Chord -> Html msg
chordButton playChord chord =
    button
        [ onClick (playChord chord.notes)
        , style "margin" "8px"
        , title (String.join ", " chord.notes)
        ]
        [ text chord.name ]


type alias Chord =
    { name : String
    , notes : List String
    }


chords : List Chord
chords =
    [ { name = "Bb9", notes = [ "Bb2", "Bb3", "F4", "A4", "C5", "D5" ] }
    , { name = "Abmaj9#11", notes = [ "Ab3", "Eb4", "G4", "Bb4", "C5", "D5" ] }
    , { name = "Dmaj7/E", notes = [ "E3", "D4", "F#4", "A4", "C#5" ] }
    , { name = "E7#9", notes = [ "E3", "B3", "E4", "G#4", "B4", "D5", "G5" ] }
    , { name = "C13#11", notes = [ "C4", "E4", "G4", "Bb4", "D5", "F#5" ] }
    , { name = "F7b9#11", notes = [ "F4", "A4", "C5", "Eb5", "Gb5", "B5" ] }
    , { name = "Db9add4", notes = [ "Db3", "Ab3", "Cb5", "Eb5", "F5", "Gb5" ] }
    , { name = "D/Eb", notes = [ "Eb3", "D4", "F#4", "A4", "D5" ] }
    , { name = "Bm13b9", notes = [ "B3", "D#4", "F#4", "G#4", "C5" ] }
    , { name = "Emin11", notes = [ "E3", "B3", "G4", "A4", "D5", "F#5" ] }
    , { name = "Fmaj7/Ebmaj7", notes = [ "Eb3", "Bb3", "D4", "F4", "G4", "A4", "C5", "E5" ] }
    ]
