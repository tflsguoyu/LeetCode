CC = g++
CFLAGS = -c -Wall
BUILD_PATH = build
OBJECTS = $(BUILD_PATH)/main.o \
		  $(BUILD_PATH)/hello.o \
		  $(BUILD_PATH)/factorial.o
EXE = computeFactorial

all: $(EXE)

$(EXE): build $(OBJECTS)
	$(CC) $(OBJECTS) -o $(EXE)

$(BUILD_PATH)/main.o:
	$(CC) $(CFLAGS) main.cpp -o $(BUILD_PATH)/main.o

$(BUILD_PATH)/hello.o:
	$(CC) $(CFLAGS) hello.cpp -o $(BUILD_PATH)/hello.o

$(BUILD_PATH)/factorial.o: 
	$(CC) $(CFLAGS) factorial.cpp -o $(BUILD_PATH)/factorial.o

build:
	mkdir -p build

clean:
	rm -r $(BUILD_PATH) $(EXE)

