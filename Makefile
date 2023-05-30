.PHONY: install build run clean

install: 
	ln -s ../../scripts/pre-push .git/hooks/pre-push

build:
	./scripts/pre-push -l

run: build
	live-server src

clean:
	rm .git/hooks/pre-push
	rm build/blog.tar.gz
	rmdir build
	rm src/post/*.html
