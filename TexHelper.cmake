set(SH "/bin/sh")
set(TOUCH "/bin/touch")

set(build_script "${CMAKE_SOURCE_DIR}/tex-wrapper.sh")

macro   (wrap_tex_wrapper tool output target_file dependency)
    add_custom_command(OUTPUT ${output}
                       COMMAND ${SH} ${build_script} ${CMAKE_CURRENT_SOURCE_DIR} ${tool} ${target_file}
                       COMMAND ${TOUCH} ${output}
                       DEPENDS ${dependency})
endmacro(wrap_tex_wrapper)

macro   (create_tex_output tool output root_name dependency)
    wrap_tex_wrapper(${tool} ${output} "${root_name}.tex" "${dependency}")
endmacro(create_tex_output)

macro   (create_aux_output tool output root_name dependency)
    add_custom_command(OUTPUT ${output}
                       COMMAND ${tool} ${root_name}
                       COMMAND ${TOUCH} ${output}
                       DEPENDS ${dependency})
endmacro(create_aux_output)

macro   (build_create tool)
    find_program(path_${tool} ${tool})
    if   (path_${tool})
        macro   (create_tex_output_${tool} output root dependency)
            create_tex_output(${${path}_${tool}} ${tool} ${output} ${root} "${dependency}")
        endmacro(create_tex_output_${tool})
    endif(path_${tool})
endmacro(build_create)

macro   (build_aux tool)
    find_program(path_${tool} ${tool})
    if   (path_${tool})
        macro   (create_aux_output_${tool} output root dependency)
            create_aux_output(${${path}_${tool}} ${tool} ${output} ${root} "${dependency}")
        endmacro(create_aux_output_${tool})
    endif(path_${tool})
endmacro(build_aux)

build_create("pdflatex")
build_aux("makeglossaries")
