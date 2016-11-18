CC = g++
CFLAGS = -c -Wall
BUILD_PATH = build
OBJECTS = $(BUILD_PATH)/main.o
EXE = sudoku

all: $(EXE)

$(EXE): build $(OBJECTS)
	$(CC) $(OBJECTS) -o $(EXE)

$(BUILD_PATH)/main.o:
	$(CC) $(CFLAGS) main.cpp -o $(BUILD_PATH)/main.o

build:
	mkdir -p build

clean:
	rm -r $(BUILD_PATH) $(EXE)

