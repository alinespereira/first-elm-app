module Main exposing (main)

import Browser exposing (Document, UrlRequest, application, document)
import Browser.Navigation exposing (Key)
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onClick)
import String exposing (fromInt)
import Url exposing (Url)


main : Program (Maybe Int) Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = onUrlChange
        , onUrlRequest = onUrlRequest
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { count : Int }


init : Maybe Int -> Url -> Key -> ( Model, Cmd Msg )
init flag url key =
    case flag of
        Just _ ->
            ( { count = 0 }, Cmd.none )

        Nothing ->
            ( { count = 0 }, Cmd.none )


onUrlChange : Url -> Msg
onUrlChange url =
    Increment


onUrlRequest : UrlRequest -> Msg
onUrlRequest urlRequest =
    Increment


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Msg
    = Increment
    | Decrement


view : Model -> Document Msg
view model =
    Document "My App" [ createIncrementer model ]


createIncrementer : Model -> Html Msg
createIncrementer model =
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )
