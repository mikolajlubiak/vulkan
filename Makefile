CFLAGS = -std=c++20 -Ofast -mtune=native
LDFLAGS = -lglfw -lvulkan

all: shaders/*.spv vulkan

release: CFLAGS += -D NDEBUG
release: all

vulkan: main.cpp
	clang++ $(CFLAGS) -o vulkan main.cpp $(LDFLAGS)

shaders/*.spv: shaders/shader.*
	glslc -O shaders/shader.vert -o shaders/vert.spv
	glslc -O shaders/shader.frag -o shaders/frag.spv

clean:
	rm -f vulkan shaders/*.spv
