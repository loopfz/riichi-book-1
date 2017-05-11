INITIAL_COMMIT		=	6587a780
INITIAL_LINECOUNT	=	6642	

SRC_FOLDER			=	book

MAIN_FILE			=	RiichiBook1
LATEX_FILES			=	${SRC_FOLDER}/*.tex
TARGET				=	${SRC_FOLDER}/${MAIN_FILE}.pdf

DOCKER_IMAGE		=	loopfz/riichi-latex

all:		book

book:		${TARGET}

${TARGET}:	${LATEX_FILES}
	# Build twice to resolve chapter links
	@docker run -it -v ${PWD}/${SRC_FOLDER}:/data --privileged ${DOCKER_IMAGE} lualatex --interaction=nonstopmode --halt-on-error ${MAIN_FILE}.tex
	@docker run -it -v ${PWD}/${SRC_FOLDER}:/data --privileged ${DOCKER_IMAGE} lualatex --interaction=nonstopmode --halt-on-error ${MAIN_FILE}.tex

interactive:
	@docker run -it -v ${PWD}/${SRC_FOLDER}:/data --privileged ${DOCKER_IMAGE} bash

progress:
	@REMAIN=`{ for f in ${LATEX_FILES}; do git blame $$f; done } | grep ${INITIAL_COMMIT} | wc -l`; \
	echo $$REMAIN lines from original document; \
	echo Progress: `expr \( \( ${INITIAL_LINECOUNT} - $$REMAIN \) \* 100 \) / ${INITIAL_LINECOUNT}`\%
