
build: components index.js
	@component build --dev

components: component.json
	@component install --dev

clean:
	rm -fr build components template.js

test: build
	open test/index.html
	
.PHONY: clean
