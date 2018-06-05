port module Ports exposing (..)

import Auth exposing (AuthInfo)

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
