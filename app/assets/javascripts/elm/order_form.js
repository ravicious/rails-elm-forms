var Elm = require('./OrderForm.elm')

var node = document.getElementById('order_form')
// jQuery's `data`, as opposed to HTMLElement.dataset, automatically parses the values from JSON
// and supports IE 10. Since we already have jQuery loaded, let's use it here.
var flags = $(node).data()
var app = Elm.OrderForm.embed(node, flags)
