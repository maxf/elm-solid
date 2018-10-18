port module Ports exposing (fetchUserInfo, localStorageGetItem, localStorageRemoveItem, localStorageRetrievedItem, localStorageSetItem, login, loginReturn, logout, logoutReturn, userInfoFetchedError, userInfoFetchedOk)

-- import Auth exposing (AuthInfo)
-- outgoing ports


port login : String -> Cmd msg


port logout : String -> Cmd msg


port fetchUserInfo : String -> Cmd msg


port localStorageSetItem : ( String, String ) -> Cmd msg


port localStorageGetItem : String -> Cmd msg


port localStorageRemoveItem : String -> Cmd msg



-- Subscriptions


port loginReturn : (Maybe String -> msg) -> Sub msg


port logoutReturn : (Maybe String -> msg) -> Sub msg


port localStorageRetrievedItem : (( String, Maybe String ) -> msg) -> Sub msg


port userInfoFetchedOk : (( String, String ) -> msg) -> Sub msg


port userInfoFetchedError : (String -> msg) -> Sub msg
