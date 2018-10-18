module Update exposing (Msg(..), update)

import Auth exposing (AuthInfo, fromJson)
import Browser
import Browser.Navigation as Nav
import Http
import Model exposing (Model, Status(..), initialModel)
import Photos exposing (Album, fetchAlbum)
import Ports exposing (fetchUserInfo, login, logout)
import Url


type Msg
    = UserClickedLogIn
    | LogInReturn (Maybe String)
    | UserClickedLogOut
    | LogOutReturn (Maybe String)
    | UserInfoFetchedOk ( String, String )
    | UserInfoFetchedError String
    | PhotosRetrieved (Result Http.Error Album)
    | LocalStorageRetrievedItem ( String, Maybe String )
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserClickedLogIn ->
            ( model, login "" )

        UserClickedLogOut ->
            ( { model
                | authInfo = Nothing
                , username = Nothing
                , userDataUrl = Nothing
                , album = Album "Empty" []
                , status = NoError
              }
            , logout ""
            )

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
                        Nothing ->
                            -- not logged in
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
            ( { model | status = HttpError err }, Cmd.none )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

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
