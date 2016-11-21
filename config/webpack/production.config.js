var webpack = require('webpack');
var merge = require('webpack-merge');
var generateConfig = require('./config.js');

var config = generateConfig()

module.exports = merge(
  config,
  {
    bail: true,
    plugins: config.plugins.concat([
      new webpack.DefinePlugin({
        "process.env": {
          NODE_ENV: JSON.stringify("production"),
        },
      }),
    ]),
  }
);
