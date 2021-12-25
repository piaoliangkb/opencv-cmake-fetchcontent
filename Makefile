.PHONY: build configure run clean

# Generate binary file for Android platform
# https://docs.opencv.org/4.x/db/d05/tutorial_config_reference.html
# https://www.cnblogs.com/willhua/p/12496577.html

configure:
	cmake -B build

build: configure
	cmake --build build --parallel 8

run: build
	./build/bin/main

clean:
	cmake --build build --target clean
