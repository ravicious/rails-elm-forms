module Main exposing (main)

import Html.App
import Html exposing (..)
import Html.Attributes as Attrs exposing (..)
import Html.Events exposing (..)


main : Program Never
main =
    Html.App.beginnerProgram
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
                    [ div [ class "form-group" ]
                        [ label [ for "order_quantity" ] [ text "Quantity" ]
                        , input
                            [ type' "number"
                            , id "order_quantity"
                            , name "order_quantity"
                            , onInput UpdateQuantity
                            , class "form-control"
                            , required True
                            , Attrs.min "1"
                            , step "1"
                            ]
                            []
                        ]
                    ]
                ]
            , div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ div
                        [ class "form-group" ]
                        [ label [ for "order_unit_price" ] [ text "Unit price" ]
                        , div [ class "input-group" ]
                            [ span [ class "input-group-addon" ] [ text "$" ]
                            , input
                                [ type' "number"
                                , id "order_unit_price"
                                , name "order_unit_price"
                                , onInput UpdateUnitPrice
                                , class "form-control"
                                , required True
                                , Attrs.min "0"
                                , step "0.01"
                                ]
                                []
                            ]
                        , span [ class "help-block" ]
                            [ text "Please refer to our pricing guide for the optimal prices." ]
                        ]
                    ]
                ]
            , div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ div
                        [ class "form-group" ]
                        [ label [ for "order_customer_name" ] [ text "Customer name" ]
                        , input
                            [ type' "text"
                            , id "order_customer_name"
                            , name "order_customer_name"
                            , onInput UpdateCustomerName
                            , class "form-control"
                            ]
                            []
                        ]
                    ]
                ]
            , div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ div
                        [ class "form-group" ]
                        [ label [ for "order_customer_email" ] [ text "Customer email" ]
                        , input
                            [ type' "email"
                            , id "order_customer_email"
                            , name "order_customer_email"
                            , onInput UpdateCustomerEmail
                            , class "form-control"
                            ]
                            []
                        ]
                    ]
                ]
            , div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ button [ type' "submit", class "btn btn-default" ]
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
