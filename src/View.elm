module View exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Update exposing (Msg(..))


view : Model -> Html Msg
view model =
    let
        userInfo =
            case model.authInfo of
                Nothing ->
                    [ button [ onClick UserClickedLogIn ] [ text "Log in" ] ]

                Just info ->
                    [ text ("Logged in as " ++ (model.username |> Maybe.withDefault info.webId) )
                    , br [] []
                    , button [ onClick UserClickedLogOut ] [ text "Log out" ]
                    ]
    in
        div [] userInfo
