CXXFLAGS := -Wall -Wextra -pedantic
LDFLAGS = -lglfw -lvulkan

DEBUGFLAGS := --debug
RELEASEFLAGS := -O3 -march=native -mtune=native

all: shaders/*.spv debug

debug: *.cpp
	clang++ $(CXXFLAGS) $(DEBUGFLAGS) $(LDFLAGS) -o $@ $^

release: *.cpp
	clang++ $(CXXFLAGS) $(RELEASEFLAGS) $(LDFLAGS) -o $@ $^

shaders/*.spv: shaders/shader.*
	glslc -O shaders/shader.vert -o shaders/vert.spv
	glslc -O shaders/shader.frag -o shaders/frag.spv

clean:
	rm -f release debug shaders/*.spv
