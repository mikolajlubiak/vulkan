CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan

main: main.cpp
	clang++ $(CFLAGS) -o vulkan main.cpp $(LDFLAGS)

test: vulkan
	./vulkan

clean:
	rm -f vulkan shaders/*.spv

.PHONY: test clean
