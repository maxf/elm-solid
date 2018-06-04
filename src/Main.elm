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


port fetchUsername : String -> Cmd msg


port loginReturn : (AuthInfo -> msg) -> Sub msg


port usernameReturn : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loginReturn LogInReturn
        , usernameReturn UsernameFetched
        ]


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model "" Nothing, Cmd.none )


type alias Model =
    { webId : String -- empty string means no user is logged in
    , username : Maybe String
    }


initialModel : Model
initialModel =
    Model "" Nothing


type alias AuthInfo =
    { webId : String }


type Msg
    = LogIn
    | LogOut
    | LogInReturn AuthInfo
    | UrlHasChanged Location
    | UsernameFetched String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LogIn ->
            ( model, login "" )

        LogOut ->
            ( initialModel, Cmd.none )

        LogInReturn authInfo ->
            ( { model | webId = authInfo.webId }
            , fetchUsername authInfo.webId
            )

        UsernameFetched name ->
            ( { model
                | username =
                    if name == "" then
                        Nothing
                    else
                        Just name
              }
            , Cmd.none
            )

        UrlHasChanged _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    let
        userInfo =
            case model.webId of
                "" ->
                    [ text ("Logged in as " ++ (model.username |> Maybe.withDefault ""))
                    , button [ onClick LogOut ] [ text "Log out " ]
                    ]

                _ ->
                    [ button [ onClick LogIn ] [ text "Log in" ] ]
    in
        div [] userInfo
