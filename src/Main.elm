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
            40


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
            , Font.size 16
            ]
            (organ
                m
            )
        ]
    }


organ : Model -> Element msg
organ model =
    row [ width (fill |> maximum 600), centerX, spacing 30, paddingEach { left = 16, right = 16, top = 20, bottom = 20 } ]
        [ column
            [ width fill, spacing 20 ]
            [ title model.device
            , description
            , composers
            , musicians
            , dates
            ]
        ]


description =
    paragraph [] [ text """Im Laufe der zweiten Novemberwoche 2021 wird die Komponistin und Organistin Lauren Redhead ein identisches Programm auf fünf Orgel aufführen, die sich in verschiedenen Berliner Bezirken befinden. Das Programm besteht aus sieben neu in Auftrag gegebenen Werken für Orgel und Elektronik.
Einerseits waren Orgeln einmal Laboratorien. Sie ermöglichten eine handwerkliche Experimentation mit spektralen oder raumakustischen Aspekten. Andererseits ist der Orgelklang durch seinen festgelegten rituellen und funktionalen Gebrauch bestimmt. Neue Musik für Orgel zu schreiben ist somit eine Herausforderung. Komponist:innen sehen sich mit starren Bedeutungssystemen konfrontiert, die sich nur schwer aufbrechen lassen. Die sieben Komponist:innen, die in diesem Projekt neue Werke für Orgel und Elektronik schreiben, nähern sich der Orgel jede/r ausgehend von ihrer eigenen Arbeit. Das zeigt sich in kompositorischen Ansätzen, die sich z.B. mit regelbasierten Systemen, Raumklang, Klangsynthese und fiktionaler Ethnographie auseinandersetzen.""" ]


composers =
    paragraph [] [ text "Mit neuen Werken von Lin Yang, Lula Romero, Irene Galindo Quero, Fredrik Wallberg, Luc Döbereiner, Lauren Redhead, Uday Krishnakumar" ]


musicians =
    column []
        [ paragraph [] [ text "Lauren Redhead, Orgel" ]
        , paragraph [] [ text "Luc Döbereiner, Electronics" ]
        , paragraph [] [ text "Alistair Zaldua, Electronics" ]
        ]


dates =
    column [ spacing 20 ]
        [ column []
            [ text "Mo, 08/11/2021, 19:00 Uhr"
            , text
                "Kaiser-Friedrich-Gedächtniskirche"
            , text "Händelallee 20, Berlin"
            ]
        , column
            []
            [ text "Mi, 10/11/2021, 19:30 Uhr"
            , text "Pfarrkirche Weißensee"
            , text "Berliner Allee 184, Berlin"
            ]
        , column []
            [ text "Do, 11/11/2021, 20:00 Uhr"
            , text "Paul-Gerhardt-Kirche Schöneberg"
            , text "Hauptstraße 48, Berlin"
            ]
        , column []
            [ text "Sa, 13/11/2021, 19:30 Uhr"
            , text "Alte Pfarrkirche Pankow"
            , text "Breite Str. 37, Berlin"
            ]
        , column []
            [ text "So, 14/11/2021, 18:00 Uhr"
            , text "Taborkirche"
            , text "Taborstraße 17, Berlin"
            ]
        ]


title : Device -> Element msg
title d =
    paragraph [ Font.size (titleSize d), Font.bold ]
        [ text "Orgel, Orgel, Orgel, Orgel, Orgel"
        ]
