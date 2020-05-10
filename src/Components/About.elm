module Components.About exposing (about)

import Html exposing (Html, a, br, div, h5, p, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class, href)


about : Html msg
about =
    div []
        (prelude ++ contactInfo ++ languages ++ devEnvironment)


prelude : List (Html msg)
prelude =
    [ p []
        [ text "I'm a full-stack software developer based in Atlanta, Georgia. I love learning new tools, "
        , text "languages, and techniques, but primarily work in Rust (though I've got plenty of experience "
        , text "in lots of areas)."
        ]
    , p []
        [ text "I graduated in 2019 from Georgia Tech with a B.S. in Computer Science, with threads in "
        , text "intelligence and media. My favorite courses were OS Design and Compilers and Interpreters."
        ]
    , p []
        [ text "I also sing and play music on the side, and love music theory. I can "
        , text "talk for hours about software, music, movies, and games."
        ]
    ]


contactInfo : List (Html msg)
contactInfo =
    [ h5 [] [ text "Come find me" ]
    , text "Email me at "
    , a [ href "mailto:sam@mohr.codes" ] [ text "sam@mohr.codes" ]
    , br [] []
    , text "Find me on "
    , a [ href "https://linkedin.com/in/samuel-mohr" ] [ text "LinkedIn" ]
    , br [] []
    , text "Check out my "
    , a [ href "https://github.com/smores56" ] [ text "GitHub" ]
    , br [] []
    , br [] []
    ]


languages : List (Html msg)
languages =
    let
        experience =
            [ ( [ "Rust", "TypeScript", "Elm", "Python" ]
              , "Great!"
              )
            , ( [ "Java", "C" ]
              , "Pretty Good"
              )
            , ( [ "Haskell", "C++" ]
              , "It's been a while..."
              )
            , ( [ "Kotlin", "Zig", "Mint", "Idris", "Pony", "Formality", "Unison", "etc." ]
              , "I read the docs"
              )
            ]
    in
    [ h5 [] [ text "Programming languages" ]
    , table [ class "u-full-width" ]
        [ thead []
            [ tr []
                [ th [] [ text "Names" ]
                , th [] [ text "Proficiency" ]
                ]
            ]
        , tbody []
            (experience
                |> List.map
                    (\( langs, level ) ->
                        tr []
                            [ td [] [ text (String.join ", " langs) ]
                            , td [] [ text level ]
                            ]
                    )
            )
        ]
    ]


devEnvironment : List (Html msg)
devEnvironment =
    [ h5 [] [ text "Dev environment" ]
    , p []
        [ text "I run Linux (Ubuntu 18.04) and stick with Visual Studio code "
        , text "for the ease-of-use and language server support."
        ]
    ]
