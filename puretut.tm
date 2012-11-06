<TeXmacs|1.0.7.16>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#puretut-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|The Pure Tutorial<label|the-pure-tutorial>>

  Version 0.56, October 10, 2012

  Albert Gräf \<less\><hlink|Dr.Graef@t-online.de|mailto:Dr.Graef@t-online.de>\<gtr\>

  Copyright (c) 2011. This document is available under the <hlink|GNU Free
  Documentation License|http://www.gnu.org/copyleft/fdl.html>. This is work
  in progress, so please bear with us while we're slaving away on it. If
  you're an experienced programmer and would like to give a helping hand,
  please contact the first author listed above.

  <subsection|Introduction<label|introduction>>

  This tutorial introduces the Pure programming language by way of examples,
  explaining the major elements and concepts of the language along the way.
  The goal is to help you to quickly gather a basic understanding of Pure and
  master the initial learning curve.

  This document does not pretend to be an introduction to programming in
  general, so it certainly helps if you already have an idea what programming
  is all about and some familiarity with at least one other programming
  language such as C, Python or Lisp. Also, we don't give an exhaustive
  account of the Pure language, although we aim to discuss the most important
  language elements in some detail. Therefore you should consult the other
  available documentation, in particular <hlink|<em|The Pure
  Manual>|pure.tm>, if you want to learn more.

  So what is Pure, anyway? First, it is a <with|font-series|bold|functional>
  language, like, say, Lisp and Haskell, but don't let this scare you.
  Functional programming languages have a reputation of being difficult to
  use, which isn't entirely undeserved in some cases, but the difficulties
  are often due to a lack of familiarity, as most programmers today still
  learn their craft using <with|font-series|bold|imperative> languages such
  as Pascal, C and Java. It is no wonder that they are then at a loss when
  they first encounter a language which does (some, not all) things a bit
  differently. Fortunately, mainstream languages have been picking up
  powerful and convenient features from functional languages left and right,
  so that these features nowadays will be a lot more familiar to programmers
  than, say, 20 years ago. In any case, we hope that after working though
  this tutorial you get the feeling that Pure lets you solve many typical
  programming tasks just as easily and elegantly as other programming
  languages, and in many cases even much <em|more> easily and elegantly.

  Second, Pure uses <with|font-series|bold|term rewriting> as its model of
  computation. What this basically means is that all your function
  definitions are essentially collections of equations which are used to
  evaluate expressions in a symbolic fashion. This is probably one of Pure's
  most unusual aspects, but it gives the language a lot of power and
  flexibility. It is also surprisingly easy to understand once you grasp
  that, on an abstract level, all computations performed by the interpreter
  are really nothing but sequences of simple algebraic manipulations.

  Third, Pure is a <with|font-series|bold|dynamically typed> language. This
  is a conscious design decision motivated by the choice of computational
  model, but it also keeps the language simple and supports a freewheeling,
  interactive development style. Still, Pure programs are compiled to native
  code, so that they are executed with reasonable efficiency. Pure can't
  really compete with compiled statically typed languages such as Haskell and
  ML in terms of speed and type safety, but it's a small yet powerful
  language which is supposed to be both easy to learn and fun to use.

  Fourth, Pure provides a seamless interface to
  <with|font-series|bold|external functions> written in C, C++ and Fortran,
  and thus is open to the imperative world out there and its wealth of useful
  software libraries. To these ends, despite its name, Pure decidedly is not
  a ``purely'' functional language. Performing I/O and doing all kinds of
  other side-effects is very easy in Pure. In fact, the ease with which you
  can integrate functions from external libraries and the interactive
  interpreter-like environment also turn Pure into a useful
  <with|font-series|bold|scripting language> for many different purposes.

  Typographical Conventions

  Throughout the entire Pure documentation, Pure programs are set in
  typewriter font (adding a moderate amount of syntax highlighting for easier
  reading). For instance, here is a little Pure program which defines the
  factorial function:

  <\verbatim>
    fact n = if n\<gtr\>0 then n*fact (n-1) else 1;
  </verbatim>

  Such code fragments can be entered directly at the interpreter's prompt,
  but usually you will want to put them into a text file which can then be
  loaded in the interpreter, as described in the following section.

  Often we will also show sample interactions with the Pure interpreter in
  order to explain how the programs are to be used. For instance, an
  invocation of the above factorial function may look as follows:

  <\verbatim>
    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  In this example, you are supposed to type <verbatim|map> <verbatim|fact>
  <verbatim|(1..10);> at the command prompt of the interpreter, after which
  the result <verbatim|[1,2,6,24,120,720,5040,40320,362880,3628800]> will be
  printed. In general, all text after the prompt ``\<gtr\> '' is meant to be
  typed exactly as written (including the terminating semicolon), while the
  other lines indicate results and other responses printed by the
  interpreter.

  In some cases we will show commands to be typed at your system's command
  shell, which are indicated as follows (here ``$ '' is taken to denote the
  shell command prompt, which of course varies for different systems):

  <\verbatim>
    $ pure factorial.pure
  </verbatim>

  <subsection|Getting Started<label|getting-started>>

  Let us start out with a very brief overview of the Pure environment, so
  that you get a basic understanding of how all the bits and pieces fit
  together. For the sake of brevity, we strictly keep to the basics which are
  unlikely to change much with future releases of the Pure environment. For
  more detailed and up-to-date information, please refer to the <hlink|Pure
  website|http://pure-lang.googlecode.com/>, where you can find the required
  software and all available documentation, as well as a wiki with additional
  helpful information. (Since you're reading this tutorial, most likely you
  have already discovered this.) Another very useful resource is the
  <hlink|Pure mailing list|http://groups.google.com/group/pure-lang> where
  you can discuss Pure with fellow Pure programmers and ask any questions
  that you might have.

  <subsubsection|The Pure Interpreter<label|the-pure-interpreter>>

  The Pure language is implemented by an interactive program which lets you
  enter Pure programs and execute them. This program is called the Pure
  <with|font-series|bold|interpreter>. If you have used any kind of dynamic
  programming language such as Lisp, Python or Ruby then you should already
  be familiar with this concept.[1]

  So the first thing that you'll have to do in order to use Pure is to
  install the interpreter. For most examples in this text a basic
  installation (consisting of just the ``pure'' package containing the
  interpreter and the standard library) should be all that's needed. If some
  piece of code in this text requires any additional software, we will tell
  you where to find it in due course.

  The details of installing the interpreter vary depending on which operating
  system you use. You should first check whether there's a binary package for
  your system, this will make things easier. Otherwise you'll have to build
  the interpreter from source code. The necessary steps to do that are rather
  straightforward once you have all the requisite tools and libraries
  installed. In particular, you'll need the <hlink|GNU C++
  compiler|http://gcc.gnu.org/> and <hlink|GNU
  make|http://www.gnu.org/s/make/> to compile the program, as well as the
  <hlink|LLVM library|http://llvm.org/> which provides the compiler
  back-end the Pure interpreter uses to translate your Pure programs to
  executable code. Detailed installation instructions can be found in the
  <hlink|<em|Installing Pure (and LLVM)>|install.tm> manual.

  Having completed the installation, you should be able to invoke the
  interpreter from the command line just like any other program:

  <\verbatim>
    $ pure

    Pure 0.56 (x86_64-unknown-linux-gnu) Copyright (c) 2008-2011 by Albert
    Graef

    (Type 'help' for help, 'help copying' for license information.)

    Loaded prelude from /usr/local/lib/pure/prelude.pure.

    \;

    \<gtr\>
  </verbatim>

  As you can see, the interpreter greets you with a little sign-on message,
  so that you know that it's up and running and which version you have, and
  then leaves you at its command prompt. At this point you can start typing
  Pure code, such as definitions and expressions to be evaluated:

  <\verbatim>
    \<gtr\> fact n = if n\<gtr\>0 then n*fact (n-1) else 1;

    \<gtr\> map fact (1..10);

    [1,2,6,24,120,720,5040,40320,362880,3628800]
  </verbatim>

  Proceeding in this fashion, you can readily use the interpreter as a
  sophisticated kind of desktop calculator. Note, however, that even when
  entering Pure code interactively, you always have to terminate definitions
  and expressions with a semicolon, as shown above. In contrast to languages
  like Python, ``whitespace'' (that is, blanks, tabs and even newlines) are
  insignificant. That has the advantage that you can break complicated
  definitions and expressions into multiple lines without having to escape
  line ends. On the other hand, it means that the interpreter will just keep
  on sitting idle if you forget to enter the terminating semicolon. This may
  well happen quite a bit when you begin using Pure, but is nothing to worry
  about; just enter the semicolon on a line by itself to initiate the
  computation:

  <\verbatim>
    \<gtr\> 6*7 // oops, forgot the semicolon here

    \<gtr\> ;

    42
  </verbatim>

  To exit from the interpreter when you're finished, simply type the
  <verbatim|quit> command (or the end-of-file character, <verbatim|Ctrl-D> on
  Linux, Mac OSX and other Unix-like systems) at the beginning of the command
  line, immediately after the prompt. This will return you to the shell:

  <\verbatim>
    \<gtr\> quit

    $
  </verbatim>

  Often you may prefer to enter Pure code in a text editor and save it in a
  text file, called a <with|font-series|bold|script>, which can then be
  loaded in the interpreter. This can be done by specifying the name of the
  script file when invoking the interpreter:[2]

  <\verbatim>
    $ pure -i factorial.pure
  </verbatim>

  Instead, you can also run the script directly from the interpreter's
  command prompt like this:

  <\verbatim>
    \<gtr\> run factorial.pure
  </verbatim>

  The interpreter normally offers support for the <hlink|GNU
  readline|http://www.gnu.org/s/readline/> library, which lets you recall
  previously entered lines, edit them and resubmit the edited lines to the
  interpreter. This includes a history of past input lines which gets saved
  and reloaded whenever you exit and restart the interpreter. Another
  convenient readline feature is the completion of Pure keywords and
  functions.

  It is also possible to edit and run scripts from the Emacs text editor,
  using Emacs Pure mode, and there is syntax highlighting support for a
  number of other text editors. More information about alternative ways to
  invoke the Pure interpreter can be found on the <hlink|Using
  Pure|http://code.google.com/p/pure-lang/wiki/UsingPure> wiki page, and
  the interactive features of the interpreter are discussed at length in the
  corresponding section of <hlink|<em|The Pure Manual>|pure.tm>. Also, the
  <hlink|<em|Installing Pure (and LLVM)>|install.tm> document explains in
  detail what you need to do to set up Pure mode for use with Emacs.

  <subsubsection|The Standard Library<label|the-standard-library>>

  To equip the language with some useful programming facilities which will be
  used in almost every Pure program, an installation of the Pure interpreter
  always comes with a collection of Pure scripts which are collectively
  referred to as Pure's <with|font-series|bold|standard library>. A subset of
  the standard library, called the <with|font-series|bold|prelude>, is in
  fact loaded by default whenever you invoke the interpreter. The prelude
  defines most of the basic operations of the Pure language, such as
  arithmetic, logic, string and list processing. Without the prelude the
  interpreter won't be of much use for anything, so the first time you run
  the interpreter you should check that the prelude was properly loaded,
  which is indicated by a line like the following at the end of the sign-on
  message:

  <\verbatim>
    Loaded prelude from /usr/local/lib/pure/prelude.pure.
  </verbatim>

  If instead you see an error message which says that the prelude wasn't
  found, then there is some problem with your Pure installation which needs
  to be fixed before you can proceed. Maybe the library got installed in the
  wrong place or with the wrong access permissions, or the files are just
  missing. If you can't figure it out by yourself, consult a local computer
  wizard, contact the maintainer of the package that you used to install
  Pure, or ask for help on the <hlink|Pure mailing
  list|http://groups.google.com/group/pure-lang>.

  Besides the prelude, the standard library contains additional scripts or
  <with|font-series|bold|modules> which can be loaded when they are needed,
  by means of a special kind of <verbatim|using> declaration, also called an
  <with|font-series|bold|import clause>. For instance, the standard library
  function <hlink|<with|font-family|tt|sqrt>|purelib.tm#sqrt>, which computes
  the square root of a number, is contained in the <verbatim|math.pure>
  library script, which can be loaded as follows:

  <\verbatim>
    \<gtr\> using math;

    \<gtr\> sqrt 2;

    1.4142135623731
  </verbatim>

  Note that you only have to specify the basename of the script file here,
  the <verbatim|.pure> filename extension will be added automatically.

  There are a number of other useful modules in the standard library which we
  will introduce as we go along; for the gory details, you may refer to the
  <hlink|<em|Pure Library Manual>|purelib.tm>. In addition, there is a
  growing collection of so-called <with|font-series|bold|addon modules>,
  which don't ship with the interpreter but can be installed separately. You
  can find an overview of these on the <hlink|Addons|http://code.google.com/p/pure-lang/wiki/Addons>
  wiki page. And if all that is not enough for your programming needs, Pure
  also allows you to interface to existing code in other programming
  languages, such as C and Fortran, quite easily. With the wealth of
  ready-made libraries available on modern computer systems, this is a real
  boon, and we will discuss the corresponding facilities of the Pure language
  later on in this tutorial.

  <subsubsection|Hello, World<label|hello-world>>

  Assuming that you managed to get the Pure interpreter up and running,
  you're now ready to write and execute your first Pure program a.k.a.
  script. It's customary to start out with a little program which just prints
  the text ``Hello, world'' on the terminal:

  <\verbatim>
    using system;

    puts "Hello, world";
  </verbatim>

  This should be very familiar to C programmers; it is indeed the
  <hlink|<with|font-family|tt|puts>|purelib.tm#puts> function from the C
  library which is being called here. Note that no special ``main'' function
  is needed; the call to <hlink|<with|font-family|tt|puts>|purelib.tm#puts>
  will be evaluated just like any other toplevel expression while the
  program is being executed. You can put the two lines above into a file
  called, say, <verbatim|hello.pure> which can then be invoked from the
  command line as follows:

  <\verbatim>
    $ pure hello.pure

    Hello, world
  </verbatim>

  That's it. Congrats, you have just successfully executed your first Pure
  program!

  WIP, to be continued...

  Footnotes

  [1] The term ``interpreter'' is a bit of a misnomer here, since the Pure
  front-end actually never ``interprets'' any code, but rather compiles it to
  native code which can be executed much more efficiently. The front-end does
  this on the fly, whenever the code first needs to be executed; this is also
  known as <with|font-series|bold|JIT> (``just in time'') compilation. All
  this happens automatically, transparently to the user, so for all practical
  purposes the system works as if it actually was an interpreter, and offers
  about the same degree of dynamicity and interactivity. [2] Here the
  <verbatim|-i> option makes sure that we enter the interactive command loop
  after loading the script. Otherwise the interpreter would just run the
  script in batch mode and then exit immediately.

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|puretut-toc>>

  <\itemize>
    <item><hlink|The Pure Tutorial|#>\ 

    <\itemize>
      <item><hlink|Introduction|#introduction>\ 

      <item><hlink|Getting Started|#getting-started>\ 

      <\itemize>
        <item><hlink|The Pure Interpreter|#the-pure-interpreter>\ 

        <item><hlink|The Standard Library|#the-standard-library>\ 

        <item><hlink|Hello, World|#hello-world>
      </itemize>
    </itemize>
  </itemize>

  <hlink|toc|#puretut-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2010, Albert Gräf et al. Created using
  <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1pre.\ 
</body>
