module Components.PersonalProjects exposing (projectsTab)

import Data exposing (Project, Tool, allProjects)
import Html exposing (Html, a, br, div, p, span, text)
import Html.Attributes exposing (class, href, style)


projectsTab : Html msg
projectsTab =
    div []
        [ p []
            [ text "Most of my development time outside of work goes towards maintaining "
            , a [ href "https://gleeclub.gatech.edu/glubhub/#/login" ] [ text "GlubHub" ]
            , text
                (", the official website for the Georgia Tech Glee Club, of which I am the webmaster. It manages "
                    ++ "all events, music, grades, attendance, and whatnot for the club, and so it is inaccessible by "
                    ++ "the public, but you can access the public-facing site "
                )
            , a [ href "https://gleeclub.gatech.edu/" ] [ text "here" ]
            , text
                (" to learn about the Georgia Tech Glee Club (and even put in a request for an event, if you so "
                    ++ "desire)."
                )
            ]
        , p []
            [ text
                ("The website is written in TypeScript using React Native (previously Elm), and runs on a GraphQL "
                    ++ "API written in Crystal. Check out the repositories for the "
                )
            , a [ href "https://github.com/GleeClub/glubhub_react" ] [ text "frontend" ]
            , text " and the "
            , a [ href "https://github.com/smores56/grease_crystal" ] [ text "backend" ]
            , text " to learn more about how and why things are written the way they are."
            ]
        , p []
            [ text "Besides that, here are some of my other side projects:"
            ]
        , div []
            (allProjects |> List.map projectBlock)
        ]


projectBlock : Project -> Html msg
projectBlock project =
    div [ class "row" ]
        [ div [ class "row" ]
            [ span [ style "font-size" "25px" ] [ text project.name ]
            , a [ class "button u-pull-right", href project.github ]
                [ text "on GitHub" ]
            ]
        , p [] [ text project.description ]
        , toolList project.toolsUsed
        , br [] []
        , br [] []
        ]


toolList : List Tool -> Html msg
toolList tools =
    span []
        (text "Tools used: "
            :: (tools
                    |> List.map (\t -> a [ href t.url ] [ text t.name ])
                    |> List.intersperse (text ", ")
               )
        )
