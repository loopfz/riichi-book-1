all: build

build:
	@docker build --tag=loopfz/riichi:latest .
