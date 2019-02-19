MIX_ENV?=dev

deps:
	mix deps.get
	mix deps.compile
compile: deps
	mix compile
run: export BOT_TOKEN = $(shell cat bot.token)
run: compile
	mix run --no-halt
iex:
	iex -S mix
