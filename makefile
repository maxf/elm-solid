BASEDIR=$(shell pwd)
ALL_THE_THINGS=node_modules src/elm-stuff public/javascripts/elm.js

all: $(ALL_THE_THINGS)

node_modules: package.json
	npm install

src/elm-stuff: src/elm-package.json
	cd src && \
	$(BASEDIR)/node_modules/.bin/elm-package install -y

public/javascripts/elm.js: src/*.elm
	cd src && \
	$(BASEDIR)/node_modules/.bin/elm-make *.elm --debug --yes --warn --output=../public/javascripts/elm.js

clean:
	rm -rf $(ALL_THE_THINGS)

run: $(ALL_THE_THINGS)
	npm start
