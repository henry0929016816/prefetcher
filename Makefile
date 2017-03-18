CFLAGS = -msse2 --std gnu99 -O0 -Wall -Wextra
EXEC = naive_transpose sse_transpose sse_prefetch_transpose
GIT_HOOKS := .git/hooks/applied

all: $(GIT_HOOKS) main.c $(EXEC)

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo
SRCS_common = main.c
sse_prefetch_transpose: $(SRCS_common) 
	$(CC) $(CFLAGS) -DSSE_PRE -o $@\
		$(SRCS_common) 
sse_transpose: $(SRCS_common) 
	$(CC) $(CFLAGS) -DSSE -o $@\
		$(SRCS_common)
naive_transpose: $(SRCS_common) 
	$(CC) $(CFLAGS) -DNAIVE -o $@\
		$(SRCS_common) 

clean:
	$(RM) $(EXEC)
