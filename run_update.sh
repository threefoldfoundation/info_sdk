set +ex
export GIT_UPDATE=1
export DEBUG=0
open http://localhost:3000/wiki#/
tfweb -c websitesandwikis.toml

