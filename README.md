# rails-elm-forms

This project explores ways in which an Elm app can be integrated with an existing Rails application.

# Conventions

## Files compiled by `elm make` should have .elm.js extension.

This has a couple of benefits. First, it's easier to ignore such files – they are build artifacts
and we don't have to keep them in the repo. Second, imagine you create an Elm app for making
an order form dynamic. You compile it to a file named `order_form.js`. But to run an Elm app
compiled to JS, you need to embed it on the page by calling `Elm.Main.embed`. How are you going to
name the files which embeds the Elm app? `order_form_setup.js`? It's seems easier to just add
the `.elm.js` extension to `elm make` artifacts.

# Compiling the Elm app

For now, you can compile it by issuing the following commands:

```
cd app/assets/javascripts/order_form
make
```

`make watch` recompiles the app on each change to a `.elm` file in the app directory.

For now we're not employing Google Closure Compiler for dead code removal.
Later the compilation step is going to be solved by using
[elm-webpack-loader](https://github.com/rtfeldman/elm-webpack-loader) or a similar tool.
