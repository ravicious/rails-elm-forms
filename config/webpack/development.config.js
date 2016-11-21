var webpack = require('webpack');
var merge = require('webpack-merge');
var BellOnBundlerErrorPlugin = require('bell-on-bundler-error-plugin');

var generateConfig = require('./config.js');
var config = generateConfig({debug: true})

module.exports = merge(
  config,
  {
    debug: true,
    devtool: 'eval',
    output: {
      pathinfo: true,
      devtoolModuleFilenameTemplate: '[resourcePath]',
      devtoolFallbackModuleFilenameTemplate: '[resourcePath]?[hash]',
    },
    plugins: config.plugins.concat([
      new webpack.DefinePlugin({
        "process.env": {
          NODE_ENV: JSON.stringify("development"),
        },
      }),
      new BellOnBundlerErrorPlugin(),
    ]),
  }
);
