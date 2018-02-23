#!/bin/bash

mkdir ./dist
mkdir -p ./src/components
mkdir -p ./src/containers
mkdir -p ./src/templates
mkdir -p ./webpack
mkdir __mocks__

touch ./src/templates/index.tpl.html
touch server.js
yarn init -y

# dependencies
# yarn add babel-plugin-react-css-modules
# yarn add babel-polyfill
#yarn add bluebird
yarn add express -D
yarn add react
yarn add react-dom
yarn add lodash

# devDependencies
yarn add postcss-import autoprefixer -D
yarn add babel-core -D
yarn add babel-eslint -D
yarn add babel-loader -D
yarn add babel-plugin-transform-class-properties -D
yarn add babel-plugin-transform-es2015-modules-commonjs -D
yarn add babel-plugin-transform-object-rest-spread -D
# yarn add babel-preset-bluebird -D
yarn add babel-preset-env -D
yarn add babel-preset-stage-0 -D
yarn add babel-preset-lodash -D
yarn add babel-preset-react -D
#yarn add babel-register -D
yarn add browserslist -D
#yarn add chai -D
yarn add cross-env -D
yarn add css-loader -D
#yarn add directory-named-webpack-plugin -D
yarn add enzyme -D
# yarn add eslint -D
# yarn add eslint-config-standard -D
# yarn add eslint-config-standard-react -D
# yarn add eslint-plugin-babel -D
# yarn add eslint-plugin-compat -D
# yarn add eslint-plugin-html -D
# yarn add eslint-plugin-import -D
# #yarn add eslint-plugin-jest -D
# yarn add eslint-plugin-lodash-fp -D
# yarn add eslint-plugin-mocha -D
# yarn add eslint-plugin-node -D
# yarn add eslint-plugin-promise -D
# yarn add eslint-plugin-react -D
# yarn add eslint-plugin-standard -D
yarn add extract-text-webpack-plugin -D
#yarn add file-loader -D
yarn add jest-enzyme -D
yarn add enzyme-adapter-react-16 -D
yarn add eslint-config-standard-react -D
yarn add eslint-config-standard -D

yarn add -D eslint-config-standard eslint-config-standard-react eslint-plugin-standard eslint-plugin-promise eslint-plugin-import eslint-plugin-node eslint-plugin-react


yarn add enzyme -D
yarn add html-webpack-plugin -D
yarn add identity-obj-proxy -D
yarn add jest babel-jest -D
# yarn add mocha -D
# yarn add mocha-eslint -D
# yarn add mocha-webpack@next -D
#yarn add jest-css-modules -D
#yarn add json-loader -D
# yarn add postcss-import -D
# yarn add postcss-loader -D
yarn add react-hot-loader@next -D
# yarn add react-test-renderer -D
yarn add style-loader -D
yarn add stylelint -D
yarn add stylelint-config-standard -D
yarn add stylelint-no-unsupported-browser-features -D
yarn add webpack webpack-dev-server -D
# yarn add webpack-dev-middleware -D
# yarn add webpack-hot-middleware -D

cat > .babelrc <<- EOF
{
  "presets": [
    ["env", {,
      "targets": {
        "browsers": ["last 2 versions", "last 2 ie versions", "last 3 safari versions"]
      },
      "debug": false
    }],
    "stage-0",
    "react",
    "lodash"
  ],
  "plugins": [
    "transform-class-properties",
    "transform-object-rest-spread",
    "transform-es2015-destructuring"
  ],
  "env": {
    "development": {
      "plugins": [
        "react-hot-loader/babel"
      ]
    }
  }
}
EOF

cat > ./webpack/webpack.config.js <<- EOF
const path = require('path')
const webpack = require('webpack')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const DirectoryNamedWebpackPlugin = require('directory-named-webpack-plugin')
module.exports = {
  devtool: 'cheap-module-eval-source-map',
  context: path.join(__dirname, '..', 'src'),
  node: {
    fs: 'empty',
    child_process: 'empty'
  },
  entry: {
    main: [
      'babel-polyfill',
      'react-hot-loader/patch',
      'webpack-hot-middleware/client?reload=true',
      'index.js'
    ]
  },
  output: {
    path: path.join(__dirname, '..', 'dist'),
    filename: 'bundle.js',
    publicPath: '/'
  },
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
          {loader: 'style-loader'},
          {loader: 'css-loader'},
          {loader: 'postcss-loader'}
        ]
      }
    ],
  },
  plugins: [
    // new StyleLintPlugin({customSyntax: 'postcss-scss'}),
    new ExtractTextPlugin({filename: 'style.css', disable: true}),
    new webpack.DefinePlugin({
      'environment': '\'development\'',
      NODE_ENV: JSON.stringify('development')
    }),
    new webpack.NoEmitOnErrorsPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({template: path.join(__dirname, '..', 'src', 'templates', 'index.tpl.html')})
  ],
  resolve: {
    modules: ['node_modules', 'src'],
    plugins: [
      new DirectoryNamedWebpackPlugin()
    ]
  }
}
EOF

cat > postcss.config.js <<- EOF
module.exports = {
  plugins: [
    require('postcss-import'),
    require('autoprefixer')
  ]
}
EOF

cat > ./src/templates/index.tpl.html <<- EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title></title>
</head>
<body>
    <div id="app"></div>
</body>
</html>
EOF

cat > ./server.js <<- EOF
const path = require('path')
const express = require('express')

const app = express()

const webpack = require('webpack')
const config = require('./webpack/webpack.config.js')
const isDevelopment = process.env.NODE_ENV !== 'production'
const DIST_DIR = path.join(__dirname, 'dist')
const HTML_FILE = path.join(DIST_DIR, 'index.html')

if (isDevelopment) {
  const compiler = webpack(config)
  app.use(require('webpack-dev-middleware')(compiler, {
    noInfo: true,
    publicPath: config.output.publicPath,
    stats: {
      colors: true
    }
  }))

  app.use(require('webpack-hot-middleware')(compiler))

  app.get('*', function (req, res) {
    res.sendFile(path.join(__dirname, 'src', 'templates', 'index.tpl.html'))
  })
} else {
  app.use(express.static(DIST_DIR))
  app.get('*', (req, res) => res.sendFile(HTML_FILE))
}
const server = app.listen(process.env.PORT || 3000, '0.0.0.0', (err) => {
  if (err) {
    console.log(err)
    return
  }
  const {address, port} = server.address()
  console.log('Listening at ', address, ':', port)
})
EOF
