module View exposing (view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http exposing (Error(..))
import Model exposing (Model, Status(..))
import Update exposing (Msg(..))


view : Model -> Browser.Document Msg
view model =
    let
        userInfo =
            case model.authInfo of
                Nothing ->
                    [ button [ onClick UserClickedLogIn ] [ text "Log in" ] ]

                Just info ->
                    [ text ("Logged in as " ++ (model.username |> Maybe.withDefault info.webId))
                    , br [] []
                    , text ("Your storage is at " ++ (model.userDataUrl |> Maybe.withDefault "?"))
                    , br [] []
                    , button [ onClick UserClickedLogOut ] [ text "Log out" ]
                    ]

        message =
            case model.status of
                NoError ->
                    "Ok"

                HttpError err ->
                    humanReadableHttpError err
    in
    { title = "elm-solid"
    , body =
        [ div []
            [ div [] userInfo
            , div [ class "message" ] [ text message ]
            ]
        ]
    }


humanReadableHttpError : Http.Error -> String
humanReadableHttpError error =
    case Debug.log "Http error: " error of
        BadUrl message ->
            "Bar url provided: " ++ message

        Timeout ->
            "Timeout exceeded"

        NetworkError ->
            "Network error"

        BadStatus response ->
            "Bad response status: "
                ++ String.fromInt response.status.code
                ++ ", "
                ++ response.status.message

        BadPayload message _ ->
            "Bad payload received: " ++ message
