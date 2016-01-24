# This document has a bibliography so we need to do three steps.  Our first step
# is to build the document like noraml.  Once that finishs we need to run
# bibtex, making it depend on our first step passing.  Then we can run pdflatex
# again to get our completed document.
#
# To get the "final" document we might need to run pdflatex one more time, so 
# if the document doesn't look right you can force the target to run using your
# build system (e.g., make -B sources.pdf).  This should only be need on the
# first run of a clean environment so we won't do it by defualt, but you can do
# it with one extra call to create_tex_output_pdflatex if you want it running
# in all cases.
create_tex_output_pdflatex(bibtest_pdflatex "sources" "sources.tex")
create_aux_output_bibtex(bibtest_bib "sources" bibtest_pdflatex)
create_tex_output_pdflatex(bibtest_final "sources" bibtest_bib)
add_custom_target(sources.pdf DEPENDS bibtest_final)
