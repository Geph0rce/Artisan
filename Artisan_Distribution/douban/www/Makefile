.PHONY: help i a ab



help:
	@echo targets: i(iphone), a(android), ab(android-build)

i:
	cp lib/ios/cordova-3.6.3.js cordova.js; python static/make.py

a:
	cp lib/android/cordova-3.6.4.js cordova.js; python static/make.py

ab: a
	cd ../..; ./build.sh
