module Update exposing (Msg(..), update)

import Model exposing (Model, initialModel)
import Ports exposing (login, logout, fetchUsername)
import Navigation exposing (Location)
import Auth exposing (AuthInfo, fromJson)


type Msg
    = UserClickedLogIn
    | LogInReturn (Maybe String)
    | UserClickedLogOut
    | LogOutReturn (Maybe String)
    | UrlHasChanged Location
    | UsernameFetchedOk String
    | UsernameFetchedError String
    | LocalStorageRetrievedItem ( String, Maybe String )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserClickedLogIn ->
            ( model, login "" )

        LogInReturn (Just authJson) ->
            let
                authInfo =
                    Auth.fromJson authJson |> Result.toMaybe
                cmdMsg =
                    case (Debug.log ">>" authInfo) of
                        Nothing ->
                            Cmd.none

                        Just info ->
                            fetchUsername info.webId
            in
                ( { model | authInfo = authInfo }, cmdMsg )

        LogInReturn Nothing ->
            let
                _ =
                    Debug.log "Error" "Login failed"
            in
                ( model, Cmd.none )

        UserClickedLogOut ->
            ( initialModel, logout "" )

        LogOutReturn Nothing ->
            ( model, Cmd.none )

        LogOutReturn _ ->
            ( model, Cmd.none )

        UsernameFetchedOk name ->
            ( { model | username = Just name }, Cmd.none )

        UsernameFetchedError error ->
            ( { model | username = Just error }, Cmd.none )

        UrlHasChanged _ ->
            ( model, Cmd.none )

        LocalStorageRetrievedItem ( key, value ) ->
            case key of
                "solid-auth-client" ->
                    let
                        authInfo =
                            fromJson (value |> Maybe.withDefault "")
                                |> Result.toMaybe
                        cmdMsg =
                            case authInfo of
                                Nothing ->
                                    Cmd.none

                                Just info ->
                                    fetchUsername info.webId
                    in
                        ( { model | authInfo = authInfo }, cmdMsg )

                _ ->
                    ( model, Cmd.none )
