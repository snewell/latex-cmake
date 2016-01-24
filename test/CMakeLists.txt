include(../TexHelper.cmake)

# This document is split into multiple files, so make life easier for us and
# store the filenames in a variable
set(files "test.tex" "input.tex")
# We're going to create a document using pdflatex.  The symbolic name for this
# task is "test_pdflatex" (we can depend on this name for other tasks).  We'll
# run pdflatex against "test.tex" (note no ".tex" in the second argument) and
# depend on the set of files we created earlier.
create_tex_output_pdflatex(test_pdflatex "test" "${files}")
# The previous line doesn't do much by itself so we'll create a target for
# CMake.  The name of our target is "test.pdf" and it depends on 
# "test_pdflatex" (i.e., the name of the previous task).  Now we can build the
# document by doing something like "make test.pdf".
add_custom_target(test.pdf DEPENDS test_pdflatex)

# This document has a glossary so we need to do three steps.  Our first step
# looks very similar to above, then we'll build the glossary and make it
# depend on the first task (glstest_pdflatex).  Lastly we'll build our
# document again after the glossary is run (glstest_final) and create a target
# for CMake (gls-test.pdf).
create_tex_output_pdflatex(glstest_pdflatex "gls-test" "gls-test.tex")
create_aux_output_makeglossaries(glstest_gls "gls-test" glstest_pdflatex)
create_tex_output_pdflatex(glstest_final "gls-test" glstest_gls)
add_custom_target(gls-test.pdf DEPENDS glstest_final)
