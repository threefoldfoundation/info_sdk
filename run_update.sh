set +ex
export GIT_UPDATE=0
export DEBUG=1
open http://localhost:3000/wiki#/
tfweb -c websitesandwikis.toml

