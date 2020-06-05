mix local.rebar --force
mix local.hex --force
mix deps.get --only prod
MIX_ENV=prod mix compile
MIX_ENV=prod mix release --overwrite
rm -rf ./tmp
kill $(ps -efw | grep image_throw | grep -v grep | awk '{print $2}')
_build/prod/rel/image_throw/bin/image_throw daemon_iex
rm -rf config
rm -rf lib
