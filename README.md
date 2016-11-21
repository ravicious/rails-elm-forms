# rails-elm-forms

This project explores ways in which an Elm app can be integrated with an existing Rails application.

# Conventions

## Any Elm main module should live in `app/assets/javascripts/elm` along with a JS script which handles the Elm app setup

By "main module" we mean an Elm module which exports a `main` function which calls a variant of
`Html.program`. If you have an `OrderForm.elm` file, there should be a file called `order_form.js`
beside it. `order_form.js` should require the Elm file and embed the Elm app:

```javascript
var Elm = require('./OrderForm.elm')

var node = document.getElementById('order_form')
var app = Elm.OrderForm.embed(node)
```

`order_form.js` is then compiled by webpack and required by the Rails app. This is because we leave
all the Elm compilation steps to webpack and Sprockets have to handle only a clean JS file.

## Any app-related modules should be nested under the main module namespace

If you have a main module `Foo` and another module `Bar` with `Foo`-specific functions, the `Bar`
module should be called `Foo.Bar`. This helps with properly namespacing the apps since they all
live in the same folder.

## Files compiled by `webpack` should have `.webpack.js` extension

It's easier to ignore all `*.webpack.js` files in .gitignore than add a new .gitignore statement
for each new webpack entry point. Such files are build artifacts and we don't want to keep them
in the repo.

## Passing data from the server to the Elm app is done through HTML `data` attributes

First the server puts the data into the view through the `data` attribute of the node in which
the Elm app is embedded in. Then the JS file reads the `data` tag – usually by using `jQuery.data`,
since it automatically parses the JSON string in the `data` attribute to a JS object.

Then the JS file passes the JS object as flags to the Elm app and that's it.

# Compiling the Elm app

You can compile all Elm apps by issuing the following command:

```
npm run webpack-dev-build
```

`npm run webpack-watch` recompiles an app on each change to its source files (including Elm files
thanks to [elm-webpack-loader](https://github.com/rtfeldman/elm-webpack-loader)).
