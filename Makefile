CPPSRC		=	main.cpp
ASMSRC		=	avx.s
CPPAS 		=	$(CPPSRC:.cpp=.S)
CPPOBJ		=	$(CPPSRC:.cpp=.o)
ASMOBJ		=	$(ASMSRC:.s=.o)
NAME		=	avx_test
CPPFLAGS	=	-Wall -Wextra -std=c++17
ASMFLAGS	=	-felf64
CNAFLAGS	=	-Wall -Wextra -mno-red-zone -fno-asynchronous-unwind-tables -S
LDFLAGS		=	
CC			=	g++
AS			=	nasm
LD			=	g++

all: $(NAME)

$(NAME): $(CPPOBJ) $(ASMOBJ)
	$(LD) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CC) -c -o $@ $^ $(CPPFLAGS)

%.o: %.s
	$(AS) -o $@ $^ $(ASMFLAGS)

clean:
	rm -rf $(CPPOBJ) $(ASMOBJ)

fclean: clean
	rm -rf $(NAME)

re: fclean all