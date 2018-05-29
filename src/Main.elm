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


port loginReturn : (AuthInfo -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    loginReturn LogInReturn


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model Nothing "ready", Cmd.none )


type alias AuthInfo =
    { webId : String }


type alias Model =
    { authInfo : Maybe AuthInfo
    , message : String
    }


type Msg
    = LogIn
    | LogOut
    | LogInReturn AuthInfo
    | UrlHasChanged Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LogIn ->
            ( { model | message = "Logging on" }, login "meh" )

        LogOut ->
            ( { model | authInfo = Nothing }, Cmd.none )

        LogInReturn authInfo ->
            ( { model | message = "Logged on", authInfo = Just authInfo }, Cmd.none )

        UrlHasChanged _ ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        userInfo =
            case model.authInfo of
                Just info ->
                    [ text ("Logged in as " ++ info.webId)
                    , button [ onClick LogOut ] [ text "Log out " ]
                    ]

                Nothing ->
                    [ button [ onClick LogIn ] [ text "Log in" ] ]

    in
        div [] userInfo
