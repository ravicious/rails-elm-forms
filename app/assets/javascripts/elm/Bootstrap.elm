module Bootstrap
    exposing
        ( formGroup
        , label
        , input
        , inputWithOptions
        , defaultInputOptions
        , InputOptions
        )

{-| This module aims to reduce the amount of boilerplate one has to write while working
on Boostrap 3 forms.
-}

import Html exposing (..)
import Html.Attributes exposing (..)
import String


-- Form group


{-| `formGroup` is based on Rails form field helper conventions. Given an "object" and a "property",
it generates an ID and a Rails-style name (`object[property]`). Then passes the id and the name
to its third argument – a function rendering the actual HTML body.

So instead of having to write:

    div [ class "form-group" ]
        [ Bootstrap.label "object_property" "Property"
        , Bootstrap.input
            [ id "object_property"
            , name "object[property]"
            , …
            ]
        ]

We can write:

    Bootstrap.formGroup "object" "property" <|
        \fieldId fieldName ->
            [ Boostrap.label fieldId "Property"
            , Boostrap.input
                [ id fieldId
                , name fieldName
                ]
            ]

This saves us from the burden of keeping the label and the input IDs in sync and generating
a correct name for the input.

Note: While Rails helpers support arbitrary level of nesting [1], our implementation assumes
we're always referring to a single property on a single object, that is `object[property]`.
A support for the arbitrary nesting level can be added. However, it's non-trivial to implement
and the current assumptions suit our needs. If it happens that there's a need to generate names for,
let's say, arrays of hashes, one can always implement it manually based on the Rails guide below.

[1] http://guides.rubyonrails.org/form_helpers.html#combining-them
-}
formGroup : String -> String -> (String -> String -> List (Html msg)) -> Html msg
formGroup objectName propertyName renderFormGroup =
    let
        fieldId =
            objectName ++ "_" ++ propertyName

        fieldName =
            objectName ++ "[" ++ propertyName ++ "]"
    in
        div [ class "form-group" ] <|
            renderFormGroup fieldId fieldName



-- Label


{-| A wrapper for the standard HTML label. Saves us from using the `for` and `text` Html
functions every time.
-}
label : String -> String -> Html msg
label forText labelText =
    Html.label [ for forText ] [ text labelText ]



-- Inputs


{-| A record representing the Bootstrap input-specific features like input addons and help blocks.
See `inputWithOptions` docs for more details.

`helpBlock` is implemented as `Maybe (Html msg)` instead of `String`, since sometimes you
may want to use links or other HTML tags inside help blocks.
-}
type alias InputOptions msg =
    { prepend : String
    , helpBlock : Maybe (Html msg)
    }


defaultInputOptions : InputOptions msg
defaultInputOptions =
    { prepend = ""
    , helpBlock = Nothing
    }


{-| A wrapper for input field which implements some of the Bootstrap input features such as
input addons [1] and help blocks [2].

`inputWithOptions` requires you to specify all the options upfront. To cope with that, you may want
to use the `defaultInputOptions` record in order to specify only the options you need:

    Bootstrap.inputWithOptions
        { defaultInputOptions
            | prepend = "$"
        }
        -- Rest of the arguments for `inputWithOptions`.

Please note that `defaultInputOptions` needs to be an unqualified import in your module since
Elm doesn't allow qualified names in record update syntax. [3]

    import Bootstrap exposing (defaultInputOptions)

[1] http://getbootstrap.com/components/#input-groups
[2] http://getbootstrap.com/css/#forms-help-text
[3] https://github.com/elm-lang/elm-plans/issues/16
-}
inputWithOptions : InputOptions msg -> List (Attribute msg) -> Html msg
inputWithOptions { prepend, helpBlock } inputAttributes =
    let
        attributesToOverwrite =
            [ class "form-control" ]

        -- Elm parses the list of attributes left to right. It means that if we have two
        -- attributes for the "id" attribute, the last one is going to overwrite the previous ones.
        overwrittenAttributes =
            inputAttributes ++ attributesToOverwrite

        inputNode =
            -- We can safely assume we're not going to need to pass children to input,
            -- so instead we can always put an empty list.
            -- This saves us from passing it each time to `inputWithOptions`.
            Html.input overwrittenAttributes []

        -- The exact Bootstrap syntax for input addons and the help block is order-dependent:
        -- we can't add the help block before the addon. Thus, we have to use a record for
        -- the input options and implement Bootstrap features step-by-step.
        inputNodeWithPrepend =
            if not <| String.isEmpty prepend then
                div [ class "input-group" ]
                    [ span [ class "input-group-addon" ] [ text prepend ]
                    , inputNode
                    ]
            else
                inputNode

        inputNodeWithHelpBlock =
            case helpBlock of
                Just htmlNode ->
                    div []
                        [ inputNodeWithPrepend
                        , span [ class "help-block" ] [ htmlNode ]
                        ]

                Nothing ->
                    inputNodeWithPrepend
    in
        inputNodeWithHelpBlock


{-| A wrapper for `inputWithOptions` which always uses the default input options. Useful in cases
where you just don't want to use any of the Bootstrap features, but keep your module unified in how
it generates forms.
-}
input : List (Attribute msg) -> Html msg
input =
    inputWithOptions defaultInputOptions
