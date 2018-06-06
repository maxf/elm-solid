module View exposing (view)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Update exposing (Msg(UserClickedLogIn, UserClickedLogOut))


view : Model -> Html Msg
view model =
    let
        userInfo =
            case model.authInfo of
                Nothing ->
                    [ button [ onClick UserClickedLogIn ] [ text "Log in" ] ]

                Just info ->
                    [ text ("Logged in as " ++ info.webId )
                    , button [ onClick UserClickedLogOut ] [ text "Log out " ]
                    ]
    in
        div [] userInfo
