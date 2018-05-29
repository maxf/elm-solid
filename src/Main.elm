port module Main exposing (main)

import Navigation exposing (Location)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Navigation.program UrlHasChanged
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }


port login : String -> Cmd msg


port loginReturn : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    loginReturn LogInReturn


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model "ready", Cmd.none )


type alias Model =
    { message : String }


type Msg
    = LogIn
    | LogInReturn String
    | UrlHasChanged Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LogIn ->
            ( { model | message = "Logging on" }, login "meh" )

        LogInReturn message ->
            ( { model | message = message }, Cmd.none )

        UrlHasChanged _ ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.message ]
        , button [ onClick LogIn ] [ text "Log in" ]
        ]
