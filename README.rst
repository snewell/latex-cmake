latex-common
============
latex-common is a collection of macros that make it easy to build LaTeX
documents using CMake.  The primary goal is being able to perform out of source
builds of LaTeX documents and use CMake to handle dependency management when
using features that require multiple steps to build (e.g., glossaries, indexes,
and bibliographies).

Requirements
------------
Right now latex-common only works in a Unix environment.  It assumes
:code:`/bin/sh` and :code:`/bin/touch` exist and work in the normal way.

Usage
-----
Configure the project using :code:`cmake` and use the :code:`install` target
(if you're using the :code:`make` geneartor, :code:`make install`)  Once the
files are installed include them in a CMake project like so:

.. code:: CMake

  include(/path/to/TexHelper.cmake)

That's it, you have macros available to build your documents.  If you run into
any errors with the :code:`include` line make sure you've set
:code:`CMAKE_MODULE_PATH` correctly.

Building Documents
------------------
Creating a document has two steps:

1. Defining the build order and dependencies
2. Adding a target for CMake

Examples are in the :code:`test` folder with comments.

Available Commands
------------------
The default tools macros are built for are the ones I use for my writing.
Without adding extra calls to :code:`build_create` or :code:`build_aux` you'll
get:

- lualatex
- pdflatex
- bibtex
- makeglossaries
- splitindex

Examples of each command are in the :code:`test` directory.

Extending Support
-----------------
Support for different buiders and support tools can be added using
:code:`build_create` (for document building tools like :code:`xetex`) and
:code:`build_aux` (for tools that work on auxillary data like :code:`bibtex`).
The macros will automatically search for the program and create helper macros
for use in your :code:`CMakeLists.txt` files.
