var path = require('path');
var merge = require('webpack-merge');

var root = path.join(__dirname, '../', '../');

module.exports = function generateConfig(elmLoaderQuery) {
  return {
    context: root,
    entry: {
      'order_form': path.join(root, 'app', 'assets', 'javascripts', 'elm', 'order_form.js'),
    },
    module: {
      loaders: [
        {
          test: /\.elm$/,
          loader: 'elm-webpack',
          exclude: [/elm-stuff/, /node_modules/],
          query: merge(
            {
              pathToMake: "node_modules/.bin/elm-make",
              warn: true,
              verbose: true,
              yes: true,
            },
            (elmLoaderQuery || {})
          )
        },
      ]
    },
    resolve: {
      extensions: ['', '.js', '.elm'],
      modulesDirectories: [
        'node_modules',
        path.join(root, 'app', 'assets', 'javascripts'),
      ],
    },
    output: {
      path: path.join(root, 'app', 'assets', 'javascripts'),
      filename: '[name].webpack.js',
      publicPath: '/assets',
    },
    plugins: [
    ],
    externals: {
    },
    // https://github.com/rtfeldman/elm-webpack-loader/tree/2b3d8bc5fb9c8ed5d568372c5a68e28b884c6495#noparse
    noParse: [/.elm$/],
  };
}
