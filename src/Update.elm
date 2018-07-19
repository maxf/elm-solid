module Update exposing (Msg(..), update)

import Model exposing (Model, Status(..), initialModel)
import Ports exposing (login, logout, fetchUserInfo)
import Auth exposing (AuthInfo, fromJson)
import Navigation exposing (Location)
import Http
import Photos exposing (Album, fetchAlbum)


type Msg
    = UserClickedLogIn
    | LogInReturn (Maybe String)
    | UserClickedLogOut
    | LogOutReturn (Maybe String)
    | UrlHasChanged Location
    | UserInfoFetchedOk (String, String)
    | UserInfoFetchedError String
    | PhotosRetrieved (Result Http.Error Album)
    | LocalStorageRetrievedItem ( String, Maybe String )



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserClickedLogIn ->
            ( model, login "" )

        UserClickedLogOut ->
            ( initialModel, logout "" )

        LogInReturn (Just authJson) ->
            let
                authInfo =
                    Auth.fromJson authJson |> Result.toMaybe

                cmdMsg =
                    case authInfo of
                        Nothing ->
                            Cmd.none

                        Just info ->
                            fetchUserInfo info.webId
            in
                ( { model | authInfo = authInfo }, cmdMsg )

        LogInReturn Nothing ->
            let
                _ =
                    Debug.log "Error" "Login failed"
            in
                ( model, Cmd.none )

        LogOutReturn Nothing ->
            ( model, Cmd.none )

        LogOutReturn _ ->
            ( model, Cmd.none )

        UserInfoFetchedOk ( name, storageUrl ) ->
            let
                nextAction =
                    case model.authInfo of
                        Nothing -> -- not logged in
                            Cmd.none
                        Just authInfo ->
                            Photos.fetchAlbum storageUrl PhotosRetrieved
            in
                ( { model | username = Just name, userDataUrl = Just storageUrl }
                , nextAction
                )

        UserInfoFetchedError error ->
            ( { model | username = Just error, userDataUrl = Nothing }, Cmd.none )

        PhotosRetrieved (Ok album) ->
            ( { model | album = album }, Cmd.none )

        PhotosRetrieved (Err err) ->
            ( { model | status = HttpError err } , Cmd.none )

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
                                    fetchUserInfo info.webId
                    in
                        ( { model | authInfo = authInfo }, cmdMsg )

                _ ->
                    ( model, Cmd.none )
