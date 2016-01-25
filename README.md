# latex-common
latex-common is a collection of macros that make it easy to build LaTeX
documents using CMake.  The primary goal is being able to perform out of source
builds of LaTeX documents and use CMake to handle dependency management when
using features that require multiple steps to build (e.g., glossaries, indexes,
and bibliographies).

## Requirements
Right now latex-common only works in a Unix environment.  It assumes `/bin/sh`
and `/bin/touch` exist and work in the normal way.

## Usage
Configure the project using `cmake` and use the `install` target (if you're
using the `make` geneartor, `make install`)  Once the files are installed
include them in a CMake project like so: `include(/path/to/TexHelper.cmake)`
That's it, you have macros available to build your documents.  If you run into
any errors with the `include` line make sure you've set `CMAKE_MODULE_PATH`
correctly.

### Building Documents
Creating a document has two steps:

1. Defining the build order and dependencies
2. Adding a target for CMake

Examples are in the `test` folder with comments.

### Available Commands
The default tools macros are built for are the ones I use for my writing.
Without adding extra calls to `build_create` or `build_aux` you'll get:

* lualatex
* pdflatex
* bibtex
* makeglossaries
* splitindex

Examples of each command are in the `test` directory.

## Extending Support
Support for different buiders and support tools can be added using
`build_create` (for document building tools like `xetex`) and `build_aux` (for
tools that work on auxillary data like `bibtex`).  The macros will
automatically search for the program and create helper macros for use in your
`CMakeLists.txt` files.
