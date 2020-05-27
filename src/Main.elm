module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onClick)
import String exposing (fromInt)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


type alias Model =
    { count : Int }


init : Model
init =
    { count = 0 }


type Msg
    = Increment
    | Decrement


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "grid-container" ]
            [ div
                [ class "grid-x"
                ]
                [ div [ class "cell" ]
                    [ button
                        [ onClick Increment
                        , type_ "button"
                        , class "success"
                        , class "button"
                        ]
                        [ text "Increment" ]
                    ]
                , div
                    [ class "cell"
                    ]
                    [ h1 [] [ text (fromInt model.count) ]
                    ]
                , div [ class "cell" ]
                    [ button
                        [ onClick Decrement
                        , type_ "button"
                        , class "alert"
                        , class "button"
                        ]
                        [ text "Decrement" ]
                    ]
                ]
            ]
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }
