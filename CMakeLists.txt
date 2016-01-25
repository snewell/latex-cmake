cmake_policy(VERSION 3.0)
project("latex-common" LANGUAGES NONE VERSION 0.1.0)
cmake_minimum_required(VERSION 3.0)

enable_testing()

add_subdirectory(test)

install(FILES TexHelper.cmake tex-wrapper.sh
        DESTINATION lib/cmake/TexHelper)
