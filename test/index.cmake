# Indexes are basically identical to glossaries and require three steps to
# build.  Check glossaries.cmake if you need to see how the structure works.
create_tex_output_pdflatex(indextest_pdflatex "index" "index.tex")
create_aux_output_splitindex(indextest_index "index" indextest_pdflatex)
create_tex_output_pdflatex(indextest_final "index" indextest_index)
add_custom_target(index.pdf DEPENDS indextest_final)

create_tex_document(TARGET index2.pdf
                    STEPS pdflatex
                    MAIN_FILE index.tex
                    RESULT_TARGET result_target
                    ALL
                   )
create_tex_document(TARGET index2-index
                    STEPS
                        splitindex
                    MAIN_FILE index
                    DEPENDENCIES ${result_target}
                    RESULT_TARGET result_target
                   )
create_tex_document(TARGET index2.pdf-final
                    STEPS
                        pdflatex
                    MAIN_FILE index.tex
                    DEPENDENCIES ${result_target}
                   )
