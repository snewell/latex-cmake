set(SH "/bin/sh")
set(TOUCH "/bin/touch")

set(build_script "${CMAKE_CURRENT_LIST_DIR}/tex-wrapper.sh")

function   (trace_message message)
    if   (TEXHELPER_TRACING)
        message(STATUS "${message}")
    endif(TEXHELPER_TRACING)
endfunction(trace_message)

include(CMakeParseArguments)

function(create_tex_document)
    set(options
            ALL
       )
    set(oneValueArgs
            MAIN_FILE
            OUTPUT
            RESULT_TARGET
       )
    set(multiValueArgs
            DEPENDENCIES
            STEPS
       )
    cmake_parse_arguments(CMAKE_HELPER "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(CMAKE_HELPER_DEPENDENCIES)
        set(tex_depends ${CMAKE_HELPER_DEPENDENCIES})
    else()
        set(tex_depends ${CMAKE_HELPER_MAIN_FILE})
    endif()

    set(count 0)
    foreach(command ${CMAKE_HELPER_STEPS})
        math(EXPR count "${count} + 1")
        set(last_target "${CMAKE_HELPER_OUTPUT}_${command}.${count}")
        set(full_deps ${full_deps} ${last_target})
        add_custom_command(OUTPUT ${last_target}
                                COMMAND ${SH} ${build_script} ${CMAKE_CURRENT_SOURCE_DIR} ${command} ${CMAKE_HELPER_MAIN_FILE}
                                COMMAND ${TOUCH} ${last_target}
                                DEPENDS ${tex_depends}
                          )
    endforeach()
    if(CMAKE_HELPER_ALL)
        add_custom_target(${CMAKE_HELPER_OUTPUT}
                            ALL
                            DEPENDS ${full_deps}
                         )
    else()
        add_custom_target(${CMAKE_HELPER_OUTPUT}
                            DEPENDS ${full_deps}
                         )
    endif()

    if(CMAKE_HELPER_RESULT_TARGET)
        set(${CMAKE_HELPER_RESULT_TARGET} ${full_deps} PARENT_SCOPE)
    endif()
endfunction()

function(wrap_tex_wrapper tool output target_file dependency)
    add_custom_command(OUTPUT ${output}
                       COMMAND ${SH} ${build_script} ${CMAKE_CURRENT_SOURCE_DIR} ${tool} ${target_file}
                       COMMAND ${TOUCH} ${output}
                       DEPENDS ${dependency})
endfunction(wrap_tex_wrapper)

function(create_tex_output tool output root_name dependency)
    wrap_tex_wrapper(${tool} ${output} "${root_name}.tex" "${dependency}")
endfunction(create_tex_output)

function(create_aux_output tool output root_name dependency)
    wrap_tex_wrapper(${tool} ${output} "${root_name}" "${dependency}")
endfunction(create_aux_output)

macro   (build_create tool)
    find_program(path_${tool} ${tool})
    if   (path_${tool})
        trace_message("Found ${tool} (${path_${tool}})")
        trace_message("Adding create_tex_output_${tool}")
        function(create_tex_output_${tool} output root dependency)
            create_tex_output(${${path}_${tool}} ${path_${tool}} ${output} ${root} "${dependency}")
        endfunction(create_tex_output_${tool})
    endif(path_${tool})
    unset(path_${tool})
endmacro(build_create)

macro   (build_aux tool)
    find_program(path_${tool} ${tool})
    if   (path_${tool})
        trace_message("Found ${tool} (${path_${tool}})")
        trace_message("Adding create_aux_output_${tool}")
        macro   (create_aux_output_${tool} output root dependency)
            create_aux_output(${${path}_${tool}} ${path_${tool}} ${output} ${root} "${dependency}")
        endmacro(create_aux_output_${tool})
    endif(path_${tool})
    unset(path_${tool})
endmacro(build_aux)

build_create("lualatex")
build_create("pdflatex")

build_aux("bibtex")
build_aux("makeglossaries")
build_aux("splitindex")
