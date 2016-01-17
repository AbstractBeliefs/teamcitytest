CC = clang
CFLAGS = -std=c11 -Wall
LFLAGS = -lm
SOURCES = main.c
EXECUTABLE = TeamCityTest
OBJECTS = $(SOURCES:.c=.o)


# Core library
all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(CFLAGS) $(LFLAGS) $(OBJECTS) -o $(EXECUTABLE)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


# Run
run: $(EXECUTABLE)
	./$(EXECUTABLE)

# Release (aka SANIC MODE)
release: CFLAGS += -O3
release: CC = gcc
release: clean $(EXECUTABLE)
	time ./$(EXECUTABLE)

# Debug
debug: CFLAGS += -ggdb -pg
debug: clean $(EXECUTABLE)
	gdb -tui --args $(EXECUTABLE)

# Utility
clean:
	rm -f $(EXECUTABLE) $(OBJECTS)

.PHONY: clean all run debug release
