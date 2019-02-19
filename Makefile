MIX_ENV?=dev

deps:
	mix deps.get
	mix deps.compile
compile: deps
	mix compile
run: export BOT_TOKEN = $(shell cat bot.token)
run: compile
	mix run --no-halt
clean:
	rm -rf _build
purge: clean
	rm -rf deps
	rm mix.lock

# scompile stands for systemd compile
scompile:
	mix local.hex --force
	mix local.rebar --force
	mix deps.get
	mix compile
# srun stands for systemd run
srun: export BOT_TOKEN = $(shell cat bot.token)
srun: scompile
	mix run --no-halt

.PHONY: deps compile run clean purge scompile srun
