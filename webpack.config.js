const {join} = require('path')
const webpack = require('webpack')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const context = join(process.cwd(), 'src')
const output = {
  path: join(process.cwd(), 'dist'),
  filename: 'bundle.js',
  publicPath: '/'
}
const template = join(context, 'templates', 'index.tpl.html')
module.exports = {
  devtool: 'cheap-module-eval-source-map',
  context,
  node: {
    fs: 'empty',
    child_process: 'empty'
  },
  entry: 'index.js',
  output,
  module: {
    rules:
    [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: { loader: 'babel-loader' }
      },
      {
        test: /\.css$/,
        use: [
          'style-loader',
          {
            loader: 'css-loader',
            options: {
              modules: true,
              camelCase: true
            }
          },
          'postcss-loader'
        ]
      }
    ]
  },
  plugins: [
    // new StyleLintPlugin({customSyntax: 'postcss-scss'}),
    new ExtractTextPlugin({filename: 'style.css', disable: process.env.NODE_ENV !== 'production'}),
    new webpack.DefinePlugin({
      'environment': '\'development\'',
      NODE_ENV: JSON.stringify('development')
    }),
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({template})
  ],
  resolve: {
    modules: ['node_modules', 'src']
  }
}
