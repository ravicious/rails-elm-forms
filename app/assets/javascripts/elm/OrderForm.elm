module OrderForm exposing (main)

import Html exposing (..)
import Html.Attributes as Attrs exposing (..)
import Html.Events exposing (..)


-- Our imports

import Bootstrap exposing (defaultInputOptions, defaultSelectOptions)


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- Model


type alias Form =
    { quantity : String
    , unitPrice : String
    , customerName : String
    , customerEmail : String
    , product : String
    }


type alias Product =
    { id : Int
    , name : String
    }


type alias Flags =
    { products : List Product }


type alias Model =
    { form : Form
    , flags : Flags
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        model =
            { form =
                { quantity = ""
                , unitPrice = ""
                , customerName = ""
                , customerEmail = ""
                , product = ""
                }
            , flags = flags
            }
    in
        ( model, Cmd.none )



-- Update


type Msg
    = UpdateQuantity String
    | UpdateUnitPrice String
    | UpdateCustomerName String
    | UpdateCustomerEmail String
    | UpdateProduct String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ form } as model) =
    case msg of
        UpdateQuantity quantity ->
            let
                updatedForm =
                    { form | quantity = quantity }
            in
                ( { model | form = updatedForm }, Cmd.none )

        UpdateUnitPrice unitPrice ->
            let
                updatedForm =
                    { form | unitPrice = unitPrice }
            in
                ( { model | form = updatedForm }, Cmd.none )

        UpdateCustomerName customerName ->
            let
                updatedForm =
                    { form | customerName = customerName }
            in
                ( { model | form = updatedForm }, Cmd.none )

        UpdateCustomerEmail customerEmail ->
            let
                updatedForm =
                    { form | customerEmail = customerEmail }
            in
                ( { model | form = updatedForm }, Cmd.none )

        UpdateProduct productIdAsString ->
            let
                updatedForm =
                    { form | product = productIdAsString }
            in
                ( { model | form = updatedForm }, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        [ Html.form []
            [ div
                [ class "row" ]
                [ div [ class "col-md-3" ]
                    [ Bootstrap.formGroup "order" "product" <|
                        \fieldId fieldName ->
                            [ Bootstrap.label fieldId "Product"
                            , Bootstrap.selectWithOptions
                                { defaultSelectOptions
                                    | placeholder = Just "Choose the product"
                                }
                                [ id fieldId
                                , name fieldName
                                , onInput UpdateProduct
                                , required True
                                ]
                              <|
                                List.map
                                    (\product ->
                                        option [ value (toString product.id) ]
                                            [ text product.name ]
                                    )
                                    model.flags.products
                            ]
                    ]
                ]
            , div
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
