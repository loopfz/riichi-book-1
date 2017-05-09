all: build

build:
	@docker build --tag=loopfz/riichi:latest .

book: book/RiichiBook1.pdf

book/RiichiBook1.pdf: book/*.tex
	# Build twice to resolve chapter links
	@docker run -it -v ${PWD}/book:/data --privileged loopfz/riichi lualatex RiichiBook1.tex
	@docker run -it -v ${PWD}/book:/data --privileged loopfz/riichi lualatex RiichiBook1.tex

interactive:
	@docker run -it -v ${PWD}/book:/data --privileged loopfz/riichi bash
