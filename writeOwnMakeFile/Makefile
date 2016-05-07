all: computeFactorial

computeFactorial: main.o hello.o factorial.o
	g++ main.o hello.o factorial.o -o computeFactorial

main.o: main.cpp
	g++ -c -Wall main.cpp

hello.o: hello.cpp
	g++ -c -Wall hello.cpp

factorial.o: factorial.cpp
	g++ -c -Wall factorial.cpp

clean:
	rm -rf *.o computeFactorial

