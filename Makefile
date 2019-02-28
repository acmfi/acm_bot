MIX_ENV?=dev

deps:
	mix deps.get
	mix deps.compile
compile: deps
	mix compile

release: export MIX_ENV = prod
release: deps
	mix release

run: export BOT_TOKEN = $(shell cat bot.token)
run: export PRICES_PATH = path/to/file
run: compile
	mix run --no-halt

clean:
	rm -rf _build

purge: clean
	rm -rf deps
	rm mix.lock

sinstall:
	mix local.hex --force
	mix local.rebar --force

# scompile stands for systemd compile
scompile: sinstall
scompile: deps
scompile: release
# srun stands for systemd run
srun: export BOT_TOKEN = $(shell cat bot.token)
srun: export PRICES_PATH = path/to/file
srun: scompile
	_build/prod/rel/acm_bot/bin/acm_bot foreground

.PHONY: deps compile release run clean purge scompile srun
