module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


main =
    layout []
        organ


organ : Element msg
organ =
    row [ width fill, centerX, spacing 30, padding 20 ]
        [ title
        ]


title : Element msg
title =
    paragraph [ Font.size 20 ] [ text "Orgel, Orgel, Orgel, Orgel, Orgel" ]
