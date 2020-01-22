CPPSRC		=	main.cpp
ASMSRC		=	avx.s
CSRC		=	align.c
CPPOBJ		=	$(CPPSRC:.cpp=.o)
ASMOBJ		=	$(ASMSRC:.s=.o)
COBJ		=	$(CSRC:.c=.o)
NAME		=	avx_test
CFLAGS		=	-Wall -Wextra -std=c11
CPPFLAGS	=	-Wall -Wextra -std=c++17
ASMFLAGS	=	
LDFLAGS		=	
CC			=	gcc
CPPC		=	g++
AS			=	nasm
LD			=	g++

UNAME_S = $(shell uname -s)
ifeq ($(UNAME_S), Linux)
	ASMFLAGS += -felf64
endif
ifeq ($(UNAME_S), Darwin)
	ASMFLAGS += -fmacho64
endif

all: $(NAME)

$(NAME): $(CPPOBJ) $(ASMOBJ) $(COBJ)
	$(LD) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CPPC) -c -o $@ $^ $(CPPFLAGS)

%.o: %.s
	$(AS) -o $@ $^ $(ASMFLAGS)

%.o: %.c
	$(CC) -c -o $@ $^ $(CFLAGS)

clean:
	rm -rf $(CPPOBJ) $(ASMOBJ) $(COBJ)

fclean: clean
	rm -rf $(NAME)

re: fclean all