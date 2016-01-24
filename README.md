# latex-common
latex-common is a collection of macros that make it easy to build LaTeX documents using CMake.  The primary goal is being able to perform out of source builds of LaTeX documents and use CMake to handle dependency management when using features that require multiple steps to build (e.g., glossaries, indexes, and bibliographies).

## Requirements
Right now latex-common only works in a Unix environment.  It assumes `/bin/sh` and `/bin/touch` exist and work in the normal way.

## Usage
Drop `TexHelper.cmake` and `tex-wrapper.sh` in a folder somewhere.  Once the files are in place include them in a CMake project like so:
`include(/path/to/TexHelper.cmake)`
That's it, you have macros available to build your documents.

### Building Documents
Creating a document has two steps:

1. Defining the build order and dependencies
2. Adding a target for CMake

Examples are in the `test` folder with comments.

## Extending Support
Support for different buiders and support tools can be added using `build_create` (for document building tools like `xetex`) and `build_aux` (for tools that work on auxillary data like `bibtex`).  The macros will automatically search for the program and create helper macros for use in your `CMakeLists.txt` files.
