// Webpack 2 config

const path = require('path');
const ROOT_PATH = path.resolve(__dirname);
const SRC_PATH = path.resolve(ROOT_PATH, 'src');
const BUILD_PATH = path.resolve(ROOT_PATH, '../apps/cms_web/priv/static');

const Webpack = require('webpack');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

const plugins = [
  new Webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: JSON.stringify('production')
    }
  }),
  new Webpack.optimize.UglifyJsPlugin({
    compress: {
      warnings: false
    }
  }),
  new ExtractTextPlugin("css/styles.css")
];

module.exports = {
  entry: {
    bundle: SRC_PATH + '/js/index'
  },
  output: {
    path: BUILD_PATH,
    publicPath: '',
    filename: 'js/[name].js'
  },
  resolve: {
    extensions: ['.js', '.jsx']
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: SRC_PATH,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          presets: ['es2015', 'stage-0']
        }
      },
      {
        test: /(\.css)$/, 
        loader: ExtractTextPlugin.extract("css-loader")
      },
      {test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: "file-loader"},
      {test: /\.woff2$/, loader: "url-loader?prefix=font/&limit=100000&mimetype=application/font-woff2"},
      {test: /\.woff$/, loader: "url-loader?prefix=font/&limit=100000&mimetype=application/font-woff"},
      {test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "url-loader?limit=10000&mimetype=application/octet-stream"},
      {test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: "url-loader?limit=10000&mimetype=image/svg+xml"},
      {test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'}
    ]
  },
  plugins: plugins
}