#! /bin/bash

function usage() {
    echo "usage: $0 COMMAND"
    echo "  COMMAND is one of:"
    echo "    install: install everything to run the app"
    echo "    cleanup: remove everything created by running install"
    exit 1
}

BASE=`pwd`

function install() {
#    npm install
#    cd src
#    elm package install -y
    $COMPILE_ELM
}

function cleanup() {
  rm -rf node_modules src/elm-stuff public/javascripts/elm.js
}

COMPILE_ELM="$BASE/node_modules/.bin/elm make --output public/javascripts/elm.js src/Main.elm"

function watch_elm() {
    ls src/*.elm | entr -cdr bash -c "$COMPILE_ELM"
}

if [ $# -eq 0 ]; then
    usage
else
    case $1 in
        install)
            install
            ;;
        cleanup)
            cleanup
            ;;
        watch)
            watch_elm
            ;;
        *)
            usage
    esac
fi
