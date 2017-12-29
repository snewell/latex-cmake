Best Practices
==============

1. Understand the dependencies your document requires.  Usually this is
   straightforward (:code:`pdflatex`, auxillary tools, :code:`pdflatex`) but it
   can get complicated if you have glossary entries that reference other
   entries.  If your documents don't come out right, try running without
   dependencies (:code:`make -B your-target`) to figure out what steps are
   missing.
2. Add the *most common* build step to :code:`ALL`, exclude the others.  Since
   you probably don't care about resolving all your
   references/glossaries/indexes/whatever as you're writing the document, those
   are good candidates to ignore until you need a fully resolved document (this
   makes your builds faster since there are fewer steps).
3. Make sure you have a target for the final version of any document that
   depends on processed glossaries/references/etc.  A good name for this is
   something like :code:`target-name-final` so you don't have to search for it
   in your target list.
