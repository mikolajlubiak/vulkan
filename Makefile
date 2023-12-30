CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan

all: shaders/*.spv vulkan

release: CFLAGS += -D NDEBUG
release: vulkan

vulkan: main.cpp
	clang++ $(CFLAGS) -o vulkan main.cpp $(LDFLAGS)

shaders/*.spv: shaders/shader.*
	glslc shaders/shader.vert -o shaders/vert.spv
	glslc shaders/shader.frag -o shaders/frag.spv

clean:
	rm -f vulkan shaders/*.spv
