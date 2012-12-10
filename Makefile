COFFEE=$(shell find coffee-box -name '*.coffee')
COFFEEC=node_modules/coffee-script/bin/coffee

all: $(COFFEE:.coffee=.js) 

run: all node_modules
	node .

populate:
	$(COFFEEC) scripts/populate

%.js: %.coffee node_modules
	$(COFFEEC) -c $<

node_modules:
	npm install

.PHONY: all run
