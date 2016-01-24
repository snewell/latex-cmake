include(../TexHelper.cmake)

set(files "test.tex" "input.tex")
create_tex_output_pdflatex(test_pdflatex "test" "${files}")
add_custom_target(test.pdf DEPENDS test_pdflatex)

create_tex_output_pdflatex(glstest_pdflatex "gls-test" "gls-test.tex")
create_aux_output_makeglossaries(glstest_gls "gls-test" glstest_pdflatex)
create_tex_output_pdflatex(glstest_final "gls-test" glstest_gls)
add_custom_target(gls-test.pdf DEPENDS glstest_final)
