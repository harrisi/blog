.PHONY: install clean

install: 
	ln -s ../../scripts/pre-push .git/hooks/pre-push

clean:
	rm .git/hooks/pre-push
