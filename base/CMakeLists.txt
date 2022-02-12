file(GLOB BASE_SRC "*.cpp" "*.hpp" "*.h" "../external/imgui/*.cpp")

file(GLOB EXT_VULKAN "../external/vulkan/*.h")
file(GLOB EXT_IMGUI "../external/imgui/*.h")
file(GLOB EXT_KTX "../external/ktx/include/*.h")
file(GLOB EXT_GLM "../external/glm/glm/*.hpp")
file(GLOB BASE_HEADERS "*.hpp" "*.h")
set(PROJECT_HEADERS ${BASE_HEADERS} ${EXT_VULKAN} ${EXT_IMGUI} ${EXT_KTX} ${EXT_GLM})

set(KTX_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../external/ktx)
set(KTX_SOURCES
    ${KTX_DIR}/lib/texture.c
    ${KTX_DIR}/lib/hashlist.c
    ${KTX_DIR}/lib/checkheader.c
    ${KTX_DIR}/lib/swap.c
    ${KTX_DIR}/lib/memstream.c
    ${KTX_DIR}/lib/filestream.c)

add_library(base STATIC ${BASE_SRC} ${PROJECT_HEADERS} ${KTX_SOURCES})

if(WIN32)
    target_link_libraries(base ${Vulkan_LIBRARY} ${WINLIBS})
 else(WIN32)
    target_link_libraries(base ${Vulkan_LIBRARY} ${XCB_LIBRARIES} ${WAYLAND_CLIENT_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
endif(WIN32)



source_group("src" FILES ${BASE_SRC})

source_group("hdr" FILES ${BASE_HEADERS})

source_group("ext/ktx/hdr" FILES ${EXT_KTX})
source_group("ext/ktx/src" FILES ${KTX_SOURCES})

source_group("ext/imgui" FILES ${EXT_IMGUI})

source_group("ext/glm" FILES ${EXT_GLM})

source_group("ext/vulkan" FILES ${EXT_VULKAN})


set(CMAKE_VERBOSE_MAKEFILE ON)