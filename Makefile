CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan

vulkan: main.cpp shaders/*.spv
	clang++ $(CFLAGS) -o vulkan main.cpp $(LDFLAGS)

shaders/*.spv: shaders/shader.*
	glslc shaders/shader.vert -o shaders/vert.spv
	glslc shaders/shader.frag -o shaders/frag.spv

clean:
	rm -f vulkan shaders/*.spv
