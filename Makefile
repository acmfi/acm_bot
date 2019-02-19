MIX_ENV?=dev

deps:
	mix deps.get
	mix deps.compile
compile: deps
	mix compile
token: export BOT_TOKEN = $(shell cat bot.token)
run: token compile
	mix run --no-halt
iex:
	iex -S mix

# scompile stands for systemd compile
scompile:
	mix local.hex --force
	mix local.rebar --force
	mix deps.get
	mix compile
# srun stands for systemd run
srun: token scompile
	mix run --no-halt

.PHONY: deps compile token run iex scompile srun
