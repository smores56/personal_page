module Components.Skills exposing (skillsTab)

import Data exposing (Tool, personalLanguages, proficientLanguages)
import Html exposing (Html, a, div, h5, p, text)
import Html.Attributes exposing (href)
import List.Extra as List


skillsTab : Html msg
skillsTab =
    div []
        (languageBlock ++ devEnvironment)


languageBlock : List (Html msg)
languageBlock =
    [ h5 [] [ text "Programming languages" ]
    , p []
        ((text "I am proficient in "
            :: languageList proficientLanguages
         )
            ++ [ text "." ]
        )
    , p []
        (text
            ("In addition to these languages, I enjoy learning new languages whenever I find "
                ++ "one I've not encountered before. I find that learning different languages broadens my "
                ++ "perspective when tackling problems in popular languages. Some such languages are "
            )
            :: languageList personalLanguages
        )
    , p []
        [ text "A great place to look for such languages is "
        , a [ href "https://www.reddit.com/r/ProgrammingLanguages/" ] [ text "r/ProgrammingLanguages" ]
        , text ", which is a popular forum for language announcements of all kinds."
        ]
    ]


languageList : List Tool -> List (Html msg)
languageList languages =
    let
        link pl =
            a [ href pl.url ] [ text pl.name ]
    in
    case ( List.init languages, List.last languages ) of
        ( Just firstLangs, Just lastLang ) ->
            case ( List.head firstLangs, List.length firstLangs ) of
                ( Just firstLang, 1 ) ->
                    [ link firstLang, text " and ", link lastLang ]

                _ ->
                    (firstLangs |> List.map link |> List.intersperse (text ", ")) ++ [ text ", and ", link lastLang ]

        _ ->
            languages |> List.map link |> List.intersperse (text ", ")


devEnvironment : List (Html msg)
devEnvironment =
    [ h5 [] [ text "Dev environment" ]
    , p []
        [ text "I run Linux (Ubuntu 18.04) and stick with Visual Studio code "
        , text "for the ease-of-use and language server support."
        ]
    ]
