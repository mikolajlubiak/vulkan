project "Core"
   kind "StaticLib"
   language "C++"
   cppdialect "C++20"
   targetdir "Binaries/%{cfg.buildcfg}"
   staticruntime "off"

   files { "Source/**.hpp", "Source/**.cpp" }

   includedirs
   {
      "Source",

      "../Libraries/Vulkan/Include",
      "../Libraries/glfw/include",
      "../Libraries/glm",
      "../Libraries/stb",
      "../Libraries/tinyobjloader",
   }

   links
   {
      "vulkan-1.lib",
      "glfw3.lib",

   }

   libdirs
   {
      "../Libraries/glfw/lib-vc2022",
      "../Libraries/Vulkan/Lib",
   }

   targetdir ("../Binaries/" .. OutputDir .. "/%{prj.name}")
   objdir ("../Binaries/Intermediates/" .. OutputDir .. "/%{prj.name}")

   filter "system:windows"
       systemversion "latest"
       defines { }

   filter "configurations:Debug"
       defines { "DEBUG" }
       runtime "Debug"
       symbols "On"

   filter "configurations:Release"
       defines { "RELEASE" }
       runtime "Release"
       optimize "On"
       symbols "On"

   filter "configurations:Dist"
       defines { "DIST" }
       runtime "Release"
       optimize "On"
       symbols "Off"