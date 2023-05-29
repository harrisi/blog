.PHONY: install clean

install: 
	ln -s scripts/pre-push .git/hooks/

clean:
	rm .git/hooks/pre-push
