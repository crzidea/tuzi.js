#!/bin/sh
APP_PATH=$(pwd)
TUZI_PATH=$(dirname $(dirname $(readlink -f $0)))

# Copy files
FILES="server.js Gruntfile.js public"
for FILE in $FILES; do
  cp -rf $TUZI_PATH/$FILE $APP_PATH
done
# No .file supportted
cp -f $TUZI_PATH/gitignore $APP_PATH/.gitignore

# Check grunt
grunt --version >/dev/null 2>&1
ret=$?
if [[ $ret -ne 0 ]]; then
  npm install -g grunt-cli
fi

# Check bower
bower --version >/dev/null 2>&1
ret=$?
if [[ $ret -ne 0 ]]; then
  npm install -g bower
fi

# Check package.json
ls bower.json >/dev/null 2>&1
ret=$?
if [[ $ret -ne 0 ]]; then
  bower init
  bower install --save jquery#1
fi

# Check package.json
ls package.json >/dev/null 2>&1
ret=$?
if [[ $ret -ne 0 ]]; then
  npm init
fi

DEPENDENCIES="
  tuzi
  grunt
  grunt-contrib-watch
  grunt-contrib-uglify
  grunt-contrib-cssmin
  grunt-contrib-htmlmin
  grunt-ejs
  grunt-bump
"
npm install --save-dev $DEPENDENCIES

# Make dirs
mkdir -p public/js
mkdir -p public/css
mkdir -p public/img
mkdir -p dist/js
mkdir -p dist/css
ln -s ../public/img dist/img
