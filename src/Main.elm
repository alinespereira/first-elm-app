module Main exposing (main)

import Browser exposing (Document, UrlRequest, application)
import Browser.Navigation exposing (Key)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
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
    { count : Int
    , content : String
    , reversedContent : Maybe String
    }


init : Maybe Int -> Url -> Key -> ( Model, Cmd Msg )
init flag url key =
    ( { count = 0, content = "", reversedContent = Nothing }, Cmd.none )


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
    | Reset
    | Change String
    | Reverse


view : Model -> Document Msg
view model =
    Document "My App" [ createIncrementer model ]


createIncrementer : Model -> Html Msg
createIncrementer model =
    let
        reversed =
            case model.reversedContent of
                Just s ->
                    s

                Nothing ->
                    ""
    in
    div [ class "container" ]
        [ div [ class "grid-container" ]
            [ div
                [ class "grid-x"
                ]
                [ h1 [] [ text "Counter" ]
                , div
                    [ class "cell"
                    ]
                    [ h2 [] [ text (String.fromInt model.count) ]
                    ]
                , div [ class "cell" ]
                    [ button
                        [ onClick Increment
                        , type_ "button"
                        , class "color-1"
                        , class "button"
                        ]
                        [ text "Increment" ]
                    , button
                        [ onClick Reset
                        , type_ "button"
                        , class "button"
                        , class "color-2"
                        ]
                        [ text "Reset" ]
                    , button
                        [ onClick Decrement
                        , type_ "button"
                        , class "button"
                        , class "color-3"
                        ]
                        [ text "Decrement" ]
                    ]
                , div
                    [ class "cell"
                    ]
                    [ h1 [] [ text "Reverse text" ]
                    ]
                , div
                    [ class "cell"
                    ]
                    [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
                    ]
                , div
                    [ class "cell" ]
                    [ button
                        [ onClick Reverse
                        , type_ "button"
                        , class "button"
                        , class "color-4"
                        ]
                        [ text "Reverse" ]
                    , button
                        [ onClick (Change "")
                        , type_ "button"
                        , class "button"
                        , class "color-5"
                        ]
                        [ text "Reset" ]
                    ]
                , div
                    [ class "cell"
                    ]
                    [ h2 [] [ text reversed ]
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

        Reset ->
            ( { model | count = 0 }, Cmd.none )

        Reverse ->
            case model.reversedContent of
                Just _ ->
                    ( model, Cmd.none )

                Nothing ->
                    case model.content of
                        "" ->
                            ( { model | reversedContent = Nothing }, Cmd.none )

                        str ->
                            ( { model | reversedContent = Just (String.reverse str) }, Cmd.none )

        Change s ->
            ( { model | content = s, reversedContent = Nothing }, Cmd.none )
