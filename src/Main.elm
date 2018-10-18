port module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Model exposing (Model, initialModel)
import Ports exposing (..)
import Update exposing (Msg(..), update)
import Url
import View exposing (view)


main : Program () Model Msg
main =
    Browser.application
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loginReturn LogInReturn
        , logoutReturn LogOutReturn
        , userInfoFetchedOk UserInfoFetchedOk
        , userInfoFetchedError UserInfoFetchedError
        , localStorageRetrievedItem LocalStorageRetrievedItem
        ]


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( initialModel url key, localStorageGetItem "solid-auth-client" )
