#!/bin/sh

if [ ! -d "node_modules/.bin" ]; then
  echo "Be sure to run \`npm install\` before building GraphiQL."
  exit 1;
fi

rm -rf dist/ && mkdir -p dist/ &&
babel src --ignore __tests__ --out-dir dist/ &&
browserify -g browserify-shim -s GraphiQL dist/index.js > graphiql.js &&
browserify -g browserify-shim -g uglifyify -s GraphiQL dist/index.js | uglifyjs -c --screw-ie8 > graphiql.min.js &&
cat css/*.css > graphiql.css
