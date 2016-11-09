module Main exposing (main)

import Html.App
import Html exposing (..)


main : Program Never
main =
    Html.App.beginnerProgram
        { model = "Hello, world!"
        , view = \model -> text model
        , update = \_ model -> model
        }
