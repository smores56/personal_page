module Components.AtWork exposing (atWorkTab)

import Data exposing (Job, allJobs)
import Html exposing (Html, a, b, br, div, i, li, p, span, text, ul)
import Html.Attributes exposing (class, href, style)


atWorkTab : Html msg
atWorkTab =
    div []
        (allJobs |> List.map jobBlock)


jobTitle : Job -> Html msg
jobTitle job =
    span [ style "font-size" "20px", style "margin-bottom" "10px" ]
        [ b [] [ text job.company ]
        , text (", " ++ job.location)
        ]


halfColumnList : String -> List String -> Html msg
halfColumnList title items =
    div [ class "six columns" ]
        [ span [] [ text title ]
        , br [] []
        , unorderedList items
        ]


unorderedList : List String -> Html msg
unorderedList items =
    ul []
        (items |> List.map (\item -> li [] [ i [] [ text item ] ]))


toolList : Job -> Html msg
toolList job =
    span []
        (text "Tools used: "
            :: (job.tools
                    |> List.map (\t -> a [ href t.url ] [ text t.name ])
                    |> List.intersperse (text ", ")
               )
        )


jobBlock : Job -> Html msg
jobBlock job =
    div []
        [ jobTitle job
        , br [] []
        , i [] [ text ("from " ++ job.startedAt ++ " to " ++ job.left) ]
        , br [] []
        , br [] []
        , p [] [ text job.description ]
        , div [ class "row" ]
            (if List.isEmpty job.accomplishments then
                [ unorderedList job.responsibilities
                ]

             else
                [ halfColumnList "My main accomplishments:" job.accomplishments
                , halfColumnList "My daily responsibilities:" job.responsibilities
                ]
            )
        , div [ class "row" ]
            [ toolList job ]
        , br [] []
        , br [] []
        ]
