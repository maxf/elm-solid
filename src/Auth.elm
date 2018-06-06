module Auth exposing (..)

-- import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

type alias AuthInfo =
    { webId : WebId
    }

type alias WebId = String


fromJson : String -> Result String AuthInfo
fromJson json =
    Ok (AuthInfo "foobar")
