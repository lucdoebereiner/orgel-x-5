module Main exposing (Model, Msg, init, main, organ, subscriptions, title, update, view)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


main : Program () Model Msg
main =
    Browser.document
        { view = view
        , init = \() -> init
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Model =
    ()


init : ( Model, Cmd Msg )
init =
    ( (), Cmd.none )


type alias Msg =
    ()


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view m =
    { title = "Orgel, Orgel, Orgel, Orgel, Orgel"
    , body =
        [ layout
            [ Font.size 18
            , Font.family
                [ Font.typeface "Inconsolata"
                , Font.monospace
                ]
            ]
            organ
        ]
    }


organ : Element msg
organ =
    row [ width fill, centerX, spacing 30, padding 20 ]
        [ title
        ]


title : Element msg
title =
    paragraph [ Font.size 20 ] [ text "Orgel, Orgel, Orgel, Orgel, Orgel" ]
