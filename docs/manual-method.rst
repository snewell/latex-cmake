Manually Configuring a Project
==============================
This method is available if the `automatic method`_ won't work for some reason.
It provides more control of the steps and targets your project provides, but
requires more intimate knowledge of how CMake works with custom targets.


Loading Module
--------------
Make sure the :code:`TexHelper` module is loaded; you'll need a line similar to
the following:

.. code:: CMake

  # if TexHelper is available in CMAKE_MODULE_PATH
  include(TexHelper)
  # or if it's not
  include(/path/to/TexHelper.cmake)

Once that's done, you'll need to declare the steps to build your document.
Generally documents are split into two broad camps:

1. Steps that require processing by :code:`latex` or the moral equivalent
2. Steps that run on a processed document (e.g., indexing, glossaries, bibtex)


LaTeX Steps
-----------
For anything that falls into the former camp, you'll need to add lines like the
following to your :code:`CMakeLists.txt`:

.. code:: CMake

  create_tex_output_lualatex(output_name some_file dependencies)
  # - output_name is a build-generated output used for dependency management
  # - some_file is the main tex file *without* the .tex extension
  # - dependencies is a list of things to depend on (both files and build
  #   targets)

Note that you'll need one of these entries that corresponds to each time you'd
have to invoke :code:`pdflatex` (or the moral equivalent) when building a
document manually; you might need multiple lines that are identical other than
:code:`dependencies`.

Each latex driver requires a custom invocation (i.e.,
:code:`create_tex_output_lualatex` is not the same as
:code:`create_tex_output_pdflatex`).  Some wrappers are automatically provided,
but if your project uses one not handled by upstream you'll need to add support
(see `Supporting New Tools`_).


Auxillary Steps
---------------
For anything in the latter camp, you'll need lines like the following:

.. code:: CMake

  create_aux_output_bibtex(output_name some_file dependencies)
  # - some_file will probably be identical for every step in a single document

In most cases, :code:`dependencies` for these tarets will be one or more
:code:`output_name`s from :code:`create_tex_output` lines.  These commands will
be invoked using the :code:`.aux` file.


Adding Targets
--------------
After the :code:`create_tex_output` and :code:`create_aux_output` lines are
complete, you'll need to make a target for your build system.  Add a line like
the following:

.. code:: CMake

  add_custom_target(target_name DEPENDS output_name)
  # - target_name is what you'll use in your build system (e.g., make
  #   target_name)
  # - output_name is the output of whatever step you want this target to build

At this point you should have proper dependency management to build your
documents.


Supporting New Tools
--------------------
Macros are provided to support tools not handled by upstream.  The macros are
trivial to use, and the wrappers provided by upstream are generated using the
same macros.

.. code:: CMake

  build_create("lualatex")
  build_create("pdflatex")

  build_aux("bibtex")
  build_aux("makeglossaries")
  build_aux("splitindex")

All tools are expected to follow invocation conventions (e.g., passing along
either :code:`some_file.tex` or :code:`some_file` (for auxillary tools) is
sufficient).  If the tool doesn't follow those conventions, you'll probably
want to make a simple wrapper script and use that.  In practice, I've used this
to wrap :code:`mk4ht` so the correct arguments are passed along.


Examples
--------
Examples using this method are available in the test_ folder with inline
comments explaining what's happening and why.


.. _automatic method: automatic-method.rst
.. _test: ../test
