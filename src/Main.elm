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



-- outgoing ports


port login : String -> Cmd msg


port fetchUsername : String -> Cmd msg


port localStorageSetItem : ( String, String ) -> Cmd msg


port localStorageGetItem : String -> Cmd msg


port localStorageRemoveItem : String -> Cmd msg



-- Subscriptions


port loginReturn : (AuthInfo -> msg) -> Sub msg


port localStorageRetrievedItem : (( String, Maybe String ) -> msg) -> Sub msg


port usernameReturn : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loginReturn LogInReturn
        , usernameReturn UsernameFetched
        , localStorageRetrievedItem LocalStorageRetrievedItem
        ]


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model "" Nothing, localStorageGetItem "solid-auth-client" )


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
    | LocalStorageRetrievedItem ( String, Maybe String )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LogIn ->
            ( model, login "" )

        LogOut ->
            ( initialModel, Cmd.none )

        LogInReturn authInfo ->
            ( { model | webId = authInfo.webId }, fetchUsername authInfo.webId )

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

        LocalStorageRetrievedItem ( key, value ) ->
            case key of
                "solid-auth-client" ->
                    -- value is a json string, which we'll now proceed to decode
                    ( model | username = getUserNameFromAuthInfo value
                    , Cmd.none
                    )
                _ ->
                    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    let
        userInfo =
            case model.webId of
                "" ->
                    [ button [ onClick LogIn ] [ text "Log in" ] ]

                _ ->
                    [ text ("Logged in as " ++ (model.username |> Maybe.withDefault ""))
                    , button [ onClick LogOut ] [ text "Log out " ]
                    ]
    in
        div [] userInfo
