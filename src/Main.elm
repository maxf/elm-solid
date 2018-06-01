port module Main exposing (main)

import Navigation exposing (Location)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import JsonLd exposing (..)

main : Program Never Model Msg
main =
    Navigation.program UrlHasChanged
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }


port login : String -> Cmd msg


port loginReturn : (AuthInfo -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    loginReturn LogInReturn


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model Nothing Nothing, Cmd.none )


type alias Model =
    { webId : String -- empty string means no user is logged in
    , username : Maybe String
    }

initialModel =
    Model "" Nothing

type alias AuthInfo =
    { webId : String }


type Msg
    = LogIn
    | LogOut
    | LogInReturn AuthInfo
    | UrlHasChanged Location
    | UsernameFetched (Result String String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LogIn ->
            ( model, login "" )

        LogOut ->
            ( initialModel, Cmd.none )

        LogInReturn authInfo ->
            ( { model | webId = authInfo.webId }
            , fetchUsername
            )

        UsernameFetched (Ok name) ->
            ( { model | name = name }, Cmd.none )

        UsernameFetched (Err name) ->
            ( { model | name = "no name" }, Cmd.none )

        UrlHasChanged _ ->
            ( model, Cmd.none )



fetchUsername -- fetch the user's card and retrieve the name from the results


view : Model -> Html Msg
view model =
    let
        userInfo =
            case model.webId of
                Just id ->
                    [ text ("Logged in as " ++ model.username)
                    , button [ onClick LogOut ] [ text "Log out " ]
                    ]

                Nothing ->
                    [ button [ onClick LogIn ] [ text "Log in" ] ]

    in
        div [] userInfo
