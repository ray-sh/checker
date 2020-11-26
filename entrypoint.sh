bin="/app/bin/checker"
eval "$bin eval \"Checker.Release.migrate\""
# start the elixir application
exec "$bin" "start"