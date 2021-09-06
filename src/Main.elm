module Main exposing (Model, Msg, init, main, organ, subscriptions, title, update, view)

import Browser
import Browser.Dom as Dom
import Browser.Events as Events
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Task


main : Program () Model Msg
main =
    Browser.document
        { view = view
        , init = \() -> init
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch [ Events.onResize (\values -> SetScreenSize values) ]


type Device
    = Mobile
    | Desktop


fromElDevice : Element.Device -> Device
fromElDevice d =
    case ( d.class, d.orientation ) of
        ( Phone, _ ) ->
            Mobile

        ( Tablet, Portrait ) ->
            Mobile

        _ ->
            Desktop


titleSize : Device -> Int
titleSize d =
    case d of
        Mobile ->
            20

        Desktop ->
            30


textSize : Device -> Int
textSize d =
    case d of
        Mobile ->
            20

        Desktop ->
            20


type alias Model =
    { device : Device
    }


init : ( Model, Cmd Msg )
init =
    ( { device = Desktop }, Task.perform InitViewport Dom.getViewport )


type Msg
    = SetScreenSize Int Int
    | InitViewport Dom.Viewport


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InitViewport vp ->
            let
                vpInt =
                    { height = round vp.viewport.height
                    , width = round vp.viewport.width
                    }

                _ =
                    Debug.log "inint size" (classifyDevice vpInt)

                _ =
                    Debug.log "init" (classifyDevice vpInt |> fromElDevice)
            in
            ( { device = classifyDevice vpInt |> fromElDevice }, Cmd.none )

        SetScreenSize x y ->
            let
                classifiedDevice =
                    classifyDevice
                        { width = x
                        , height = y
                        }

                _ =
                    Debug.log "classified" (fromElDevice classifiedDevice)
            in
            ( { device = fromElDevice classifiedDevice }, Cmd.none )


view m =
    { title = "Orgel, Orgel, Orgel, Orgel, Orgel"
    , body =
        [ layout
            [ Font.family
                [ Font.typeface "Inconsolata"
                , Font.monospace
                ]
            ]
            (organ
                m
            )
        ]
    }


organ : Model -> Element msg
organ model =
    row [ width (fill |> maximum 600), centerX, spacing 30, paddingEach { left = 10, right = 10, top = 20, bottom = 20 } ]
        [ title model.device
        ]


title : Device -> Element msg
title d =
    paragraph [ Font.size (titleSize d), Font.bold ] [ text "Orgel, Orgel, Orgel, Orgel, Orgel" ]
