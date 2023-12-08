#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

#include <iostream>
#include <stdexcept>
#include <cstdlib>
#include <vector>



const uint32_t WIDTH = 800;
const uint32_t HEIGHT = 600;



class HelloTriangleApplication {

public:

    void run() {

        initWindow();
        initVulkan();
        mainLoop();
        cleanup();

    }



private:

    void initWindow() {

        glfwInit();

        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
        glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

        window = glfwCreateWindow(WIDTH, HEIGHT, "Vulkan", nullptr, nullptr);

    }


    void initVulkan() {

        createInstance();

    }


    void mainLoop() {

        while (!glfwWindowShouldClose(window)) {
            glfwPollEvents();
        }

    }


    void cleanup() {

        vkDestroyInstance(instance, nullptr);

        glfwDestroyWindow(window);

        glfwTerminate();

    }


    void createInstance() {

        VkApplicationInfo appInfo{};
        appInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
        appInfo.pApplicationName = "Vulkan";
        appInfo.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
        appInfo.pEngineName = "No Engine";
        appInfo.engineVersion = VK_MAKE_VERSION(1, 0, 0);
        appInfo.apiVersion = VK_API_VERSION_1_0;


        uint32_t supportedExtensionCount = 0;
        vkEnumerateInstanceExtensionProperties(nullptr, &supportedExtensionCount, nullptr);

        std::vector<VkExtensionProperties> supportedExtensions(supportedExtensionCount);
        vkEnumerateInstanceExtensionProperties(nullptr, &supportedExtensionCount, supportedExtensions.data());

        std::cout << "available extensions:" << std::endl;
        for (const auto& supportedExtension : supportedExtensions) {
            std::cout << '\t' << supportedExtension.extensionName << std::endl;
        }



        VkInstanceCreateInfo createInfo{};
        createInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
        createInfo.pApplicationInfo = &appInfo;


        uint32_t glfwExtensionCount = 0;
        const char** glfwExtensions;

        glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwExtensionCount);

        std::cout << "glfw needed extensions:" << std::endl;
        std::cout << '\t' << *glfwExtensions << std::endl;


        bool allNeededGlfwExtensionsSupported = true;
        for (uint32_t i = 0; i < glfwExtensionCount; i++) {
            bool isExtensionSupported = false;
            for (const auto& supportedExtension : supportedExtensions) {
                if (strcmp(glfwExtensions[i], supportedExtension.extensionName) == 0) {
                    isExtensionSupported = true;
                    break;
                }
            }
            if (!isExtensionSupported) {
                allNeededGlfwExtensionsSupported = false;
                break;
            }
        }

        if (!allNeededGlfwExtensionsSupported) {
            throw std::runtime_error("not all needed glfw extensions supported");
        }


        createInfo.enabledExtensionCount = glfwExtensionCount;
        createInfo.ppEnabledExtensionNames = glfwExtensions;

        createInfo.enabledLayerCount = 0;


        if (vkCreateInstance(&createInfo, nullptr, &instance) != VK_SUCCESS) {
            throw std::runtime_error("failed to create instance");
        }

    }


    GLFWwindow* window;
    VkInstance instance;
};




int main() {

    HelloTriangleApplication app;


    try {
        app.run();
    }
    catch (const std::exception& e) {
        std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }


    return EXIT_SUCCESS;

}