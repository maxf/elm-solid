module Update exposing (Msg(..), update)

import Model exposing (Model, initialModel)
import Ports exposing (login, fetchUsername)
import Auth exposing (AuthInfo)
import Navigation exposing (Location)


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
                    ( { model | username = getUserNameFromAuthInfo value }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )
