# Aliases to stop, start and restart Postgres
# Paths noted below are for Postgress installed via Homebrew on OSX

alias startmongo="mongod --fork --logpath /var/log/mongodb.log"
alias stopmongo="mongo --shell 'use admin; db.shutdownServer()'"
alias restartmongo='stopmongo && sleep 1 && startmongo'
