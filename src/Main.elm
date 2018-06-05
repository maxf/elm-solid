port module Main exposing (main)

import Navigation exposing (Location)
import Model exposing (Model, initialModel)
import Update exposing (Msg(..), update)
import View exposing (view)


main : Program Never Model Msg
main =
    Navigation.program UrlHasChanged
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ loginReturn LogInReturn
        , usernameReturn UsernameFetched
        , localStorageRetrievedItem LocalStorageRetrievedItem
        ]


init : Location -> ( Model, Cmd Msg )
init location =
    ( Model "" Nothing, localStorageGetItem "solid-auth-client" )
