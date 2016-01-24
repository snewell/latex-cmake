
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
