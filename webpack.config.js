const path = require('path');

module.exports = {
  entry: './src/index.js',
  mode: "development",
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {
    rules: [
      { test: /\.pegjs$/, use: 'pegjs-loader?dependencies={"logic":"./logic.js"}' }
    ]
  },
};
