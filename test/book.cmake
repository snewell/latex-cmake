# This example builds a textbook, meaning we need a glossary, index, and 
# bibliography.  We'll start by doing our initial build (to create the aux
# file) and the first pass for each of our tools.
create_tex_output_pdflatex(booktest_pdflatex "book" "book.tex")
create_aux_output_makeglossaries(booktest_gls "book" booktest_pdflatex)
create_aux_output_splitindex(booktest_index "book" booktest_pdflatex)
create_aux_output_bibtex(booktest_bib "book" booktest_pdflatex)

# At this point we can make our target that puts all the work together.  We'll
# define a variable for our required tasks (each of the above) and create one
# last job to bulid after everything is run.  Lastly, like always, we'll add
# a target CMake will add to our build system (e.g., make).
set(required_tasks "booktest_gls" "booktest_index" "booktest_bib")
create_tex_output_pdflatex(booktest_final "book" "${required_tasks}")
add_custom_target(book.pdf DEPENDS booktest_final)

# For more complex documents with things like glossary entries that reference
# other glossary entries it may require multiple passes for some of the aux
# tools.  If we had that problem here we could just add more calls to
# create_tex_output_pdflatex and the necessary subtasks, then update the
# dependencies like normal.  For this document we'll add a "full" build so
# we'll end up with a complete document from a clean build environment.
create_tex_output_pdflatex(booktest_second "book" booktest_final)
add_custom_target(book_full DEPENDS booktest_second)

create_tex_document(OUTPUT book2.pdf
                    STEPS pdflatex
                    MAIN_FILE book.tex
                    RESULT_TARGET result_target
                    ALL
                   )
create_tex_document(OUTPUT book2-aux
                    STEPS
                        makeglossaries
                        splitindex
                        bibtex
                    MAIN_FILE book
                    DEPENDENCIES ${result_target}
                    RESULT_TARGET result_target
                   )
create_tex_document(OUTPUT book2.pdf-final
                    STEPS
                        pdflatex
                        pdflatex
                    MAIN_FILE book.tex
                    DEPENDENCIES ${result_target}
                   )
