port module Ports exposing (..)

-- import Auth exposing (AuthInfo)
-- outgoing ports


port login : String -> Cmd msg


port logout : String -> Cmd msg


port fetchUsername : String -> Cmd msg


port localStorageSetItem : ( String, String ) -> Cmd msg


port localStorageGetItem : String -> Cmd msg


port localStorageRemoveItem : String -> Cmd msg



-- Subscriptions


port loginReturn : (Maybe String -> msg) -> Sub msg


port logoutReturn : (Maybe String -> msg) -> Sub msg


port localStorageRetrievedItem : (( String, String ) -> msg) -> Sub msg


port usernameFetchedOk : (String -> msg) -> Sub msg


port usernameFetchedError : (String -> msg) -> Sub msg
