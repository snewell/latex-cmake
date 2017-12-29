# This document has a glossary so we need to do three steps.  Our first step
# looks very similar normal.  After we have the first pass we'll build the
# glossary, depending on the first task (glstest_pdflatex).  Lastly we'll build
# our document again after the glossary is run (glstest_final) and create a
# target for CMake (gls-test.pdf).
create_tex_output_pdflatex(glstest_pdflatex "gls-test" "gls-test.tex")
create_aux_output_makeglossaries(glstest_gls "gls-test" glstest_pdflatex)
create_tex_output_pdflatex(glstest_final "gls-test" glstest_gls)
add_custom_target(gls-test.pdf DEPENDS glstest_final)

create_tex_document(TARGET glstest2.pdf
                    STEPS pdflatex
                    MAIN_FILE gls-test.tex
                    RESULT_TARGET result_target
                    ALL
                   )
create_tex_document(TARGET gls-test2-index
                    STEPS
                        makeglossaries
                    MAIN_FILE gls-test
                    DEPENDENCIES ${result_target}
                    RESULT_TARGET result_target
                   )
create_tex_document(TARGET glstest2.pdf-final
                    STEPS
                        pdflatex
                    MAIN_FILE gls-test.tex
                    DEPENDENCIES ${result_target}
                   )
