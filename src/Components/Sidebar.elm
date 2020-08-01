module Components.Sidebar exposing (sidebar)

import Html exposing (Html, a, br, div, h5, p, text)
import Html.Attributes exposing (href)


sidebar : Html msg
sidebar =
    div []
        (prelude ++ contactInfo)


prelude : List (Html msg)
prelude =
    [ p []
        [ text "I'm a full-stack software developer based in Atlanta, Georgia. I love learning new tools, "
        , text "languages, and techniques, but primarily work in Rust (though I've got plenty of experience "
        , text "in lots of areas)."
        ]
    , p []
        [ text "I graduated in 2019 from Georgia Tech with a B.S. in Computer Science earning Highest Honors. "
        , text "I had concentrations in intelligence and systems/architecture, and my favorite courses were OS "
        , text "Design and Compilers and Interpreters."
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
