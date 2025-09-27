nix develop . --command bash -c "cargo new $1"

cp "$1/*" .

rm -fr "$1"
