module Main exposing (main)

import Html exposing (..)
import Html.Attributes as Attrs exposing (..)
import Html.Events exposing (..)


-- Our imports

import Bootstrap exposing (defaultInputOptions)


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }



-- Model


type alias Form =
    { quantity : String
    , unitPrice : String
    , customerName : String
    , customerEmail : String
    }


type alias Model =
    { form : Form }


init : Model
init =
    { form =
        { quantity = ""
        , unitPrice = ""
        , customerName = ""
        , customerEmail = ""
        }
    }



-- Update


type Msg
    = UpdateQuantity String
    | UpdateUnitPrice String
    | UpdateCustomerName String
    | UpdateCustomerEmail String


update : Msg -> Model -> Model
update msg ({ form } as model) =
    case msg of
        UpdateQuantity quantity ->
            let
                updatedForm =
                    { form | quantity = quantity }
            in
                { model | form = updatedForm }

        UpdateUnitPrice unitPrice ->
            let
                updatedForm =
                    { form | unitPrice = unitPrice }
            in
                { model | form = updatedForm }

        UpdateCustomerName customerName ->
            let
                updatedForm =
                    { form | customerName = customerName }
            in
                { model | form = updatedForm }

        UpdateCustomerEmail customerEmail ->
            let
                updatedForm =
                    { form | customerEmail = customerEmail }
            in
                { model | form = updatedForm }



-- View


view : Model -> Html Msg
view model =
    div []
        [ Html.form []
            [ div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ Bootstrap.formGroup "order" "quantity" <|
                        \fieldId fieldName ->
                            [ Bootstrap.label fieldId "Quantity"
                            , Bootstrap.input
                                [ id fieldId
                                , name fieldName
                                , type_ "number"
                                , onInput UpdateQuantity
                                , required True
                                , Attrs.min "1"
                                , step "1"
                                ]
                            ]
                    ]
                ]
            , div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ Bootstrap.formGroup "order" "unit_price" <|
                        \fieldId fieldName ->
                            [ Bootstrap.label fieldId "Unit price"
                            , Bootstrap.inputWithOptions
                                { defaultInputOptions
                                    | prepend = "$"
                                    , helpBlock =
                                        Just <|
                                            text "Please refer to our pricing guide for the optimal prices."
                                }
                                [ id fieldId
                                , name fieldName
                                , type_ "number"
                                , onInput UpdateUnitPrice
                                , required True
                                , Attrs.min "0"
                                , step "0.01"
                                ]
                            ]
                    ]
                ]
            , div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ Bootstrap.formGroup "order" "customer_name" <|
                        \fieldId fieldName ->
                            [ Bootstrap.label fieldId "Customer name"
                            , Bootstrap.input
                                [ id fieldId
                                , name fieldName
                                , type_ "text"
                                , onInput UpdateCustomerName
                                ]
                            ]
                    ]
                ]
            , div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ Bootstrap.formGroup "order" "customer_email" <|
                        \fieldId fieldName ->
                            [ Bootstrap.label fieldId "Customer email"
                            , Bootstrap.input
                                [ id fieldId
                                , name fieldName
                                , type_ "email"
                                , onInput UpdateCustomerEmail
                                ]
                            ]
                    ]
                ]
            , div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ button [ type_ "submit", class "btn btn-default" ]
                        [ text "Submit"
                        ]
                    ]
                ]
            ]
        , div [ class "row" ] [ div [ class "col-md-3" ] [ hr [] [] ] ]
        , div [ class "row" ]
            [ div [ class "col-md-4" ]
                [ text "Elm model:"
                , pre [] [ text (toString model) ]
                ]
            ]
        ]
