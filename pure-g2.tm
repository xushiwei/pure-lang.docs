<TeXmacs|1.0.7.16>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-g2-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gl.tm> \|
  <hlink|previous|pure-xml.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-g2<label|module-g2>>

  Version 0.2, October 10, 2012

  Albert Graef \<less\><hlink|Dr.Graef@t-online.de|mailto:Dr.Graef@t-online.de>\<gtr\>

  This is a straight wrapper of the g2 graphics library, see
  <hlink|http://g2.sf.net/|http://g2.sf.net/>.

  License: BSD-style, see the COPYING file for details.

  Get the latest source from <hlink|http://pure-lang.googlecode.com/files/pure-g2-0.2.tar.gz|http://pure-lang.googlecode.com/files/pure-g2-0.2.tar.gz>.

  g2 is a simple, no-frills 2D graphics library, distributed under the LGPL.
  It's easy to use, portable and supports PostScript, X11, PNG and Win32.
  Just the kind of thing that you need if you want to quickly knock out some
  basic graphics, and whipping out the almighty OpenGL or GTK/Cairo seems
  overkill.

  To use this module, you need to have libg2 installed as a shared library
  (libg2.so, .dll etc.) in a place where the Pure interpreter can find it.

  Documentation still needs to be written, so for the time being please see
  g2.pure and have a look at the examples provided in the distribution.

  Run <verbatim|make> <verbatim|install> to copy g2.pure to the Pure library
  directory. This tries to guess the prefix under which Pure is installed; if
  this doesn't work, you'll have to set the prefix variable in the Makefile
  accordingly.

  The Makefile also provides the following targets:

  <\itemize>
    <item><verbatim|make> <verbatim|examples> compiles the examples to native
    executables.

    <item><verbatim|make> <verbatim|clean> deletes the native executables for
    the examples, as well as some graphics files which are produced by
    running g2_test.pure.

    <item><verbatim|make> <verbatim|generate> regenerates the g2.pure module.
    This requires that you have pure-gen installed, as well as the g2 header
    files (you can point pure-gen to the prefix under which g2 is installed
    with the g2prefix variable in the Makefile). This step shouldn't normally
    be necessary, unless you find that the provided wrapper doesn't work with
    your g2 version. The g2.pure in this release has been generated from g2
    0.72.
  </itemize>

  Previous topic

  <hlink|Pure-XML - XML/XSLT interface|pure-xml.tm>

  Next topic

  <hlink|Pure OpenGL Bindings|pure-gl.tm>

  <hlink|toc|#pure-g2-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|pure-gl.tm> \|
  <hlink|previous|pure-xml.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2010, Albert Gräf et al. Created using
  <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1pre.\ 
</body>
