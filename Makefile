CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan

main: main.cpp
	glslc shaders/shader.vert -o shaders/vert.spv
	glslc shaders/shader.frag -o shaders/frag.spv
	clang++ $(CFLAGS) -o vulkan main.cpp $(LDFLAGS)

clean:
	rm -f vulkan shaders/*.spv
