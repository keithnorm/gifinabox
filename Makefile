dev-server :
	./env.sh ./node_modules/coffee-script/bin/coffee server.coffee

dev-load-prod-backup :
	pg_restore --verbose --clean --no-acl --no-owner -d gg-dev `ls tmp/prod-dump* | sort | tail -1`
	make dev-rebuild-db

dev-rebuild-db :
	./env.sh ./node_modules/coffee-script/bin/coffee server.coffee

# ---

reloader :
	make dev-reload-server &
	./node_modules/coffee-script/bin/coffee -wo ./public/javascripts/ ./public/coffeescripts/

# Restarts the server when a file changes, if rbbe (*) is installed the active
# browser tab will also reload once the server comes up
# (*) rbbe = reload-browser browser extension, see: https://github.com/quackingduck/reload-browser/downloads
dev-reload-server :
	RELOAD_BROWSER_ON_LISTEN=yes ./env.sh ./node_modules/wach/bin/wachs \
		-o server.coffee,./views/* \
		./node_modules/coffee-script/bin/coffee server.coffee

# These two reloaders require the browser extension to work. Install it. It's
# great.

