<TeXmacs|1.0.7.16>

<style|<tuple|generic|puredoc>>

<\body>
  <hlink|toc|#pure-tk-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|faust2pd.tm> \|
  <hlink|previous|pure-gtk.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <section*|pure-tk<label|module-tk>>

  Version 0.3, October 10, 2012

  Albert Graef \<less\><hlink|Dr.Graef@t-online.de|mailto:Dr.Graef@t-online.de>\<gtr\>

  Pure's <hlink|Tcl/Tk|http://www.tcl.tk> interface.

  <subsection|Introduction<label|introduction>>

  This module provides a basic interface between Pure and Tcl/Tk. The
  operations of this module allow you to execute arbitrary commands in the
  Tcl interpreter, set and retrieve variable values in the interpreter, and
  invoke Pure callbacks from Tcl/Tk.

  A recent version of Tcl/Tk is required (8.0 or later should do). You can
  get this from <hlink|http://www.tcl.tk|http://www.tcl.tk>. Both releases in
  source form and binary releases for Windows and various Unix systems are
  provided there.

  Some information on how to use this module can be found below. But you'll
  find that pure-tk is very easy to use, so you might just want to look at
  the programs in the examples folder to pick it up at a glance. A very basic
  example can be found in tk_hello.pure; a slightly more advanced example of
  a tiny but complete Tk application is in tk_examp.pure.

  pure-tk also offers special support for Peter G. Baum's
  <hlink|Gnocl|http://www.gnocl.org/> extension which turns Tcl into a
  frontend for <hlink|GTK+|http://www.gtk.org/> and
  <hlink|Gnome|http://www.gnome.org/>. If you have Gnocl installed then you
  can easily create GTK+/Gnome applications, either from Tcl sources or from
  <hlink|Glade|http://glade.gnome.org/> UI files, using the provided
  gnocl.pure module. See the included uiexample.pure and the accompanying
  Glade UI file for a simple example. Also, some basic information on using
  Gnocl with pure-tk can be found in the <hlink|Tips and
  Tricks|#tips-and-tricks> section below.

  One nice thing about Tcl/Tk is that it provides a bridge to a lot of other
  useful libraries. A prominent example is <hlink|VTK|http://www.vtk.org/>, a
  powerful open-source 3D visualization toolkit which comes with full Tcl/Tk
  bindings. The examples directory contains a simple example (earth.pure and
  earth.tcl) which shows how you can employ these bindings to write cool
  animated 3D applications using either Tk or Gnocl as the GUI toolkit.

  <subsection|Copying<label|copying>>

  Copyright (c) 2010 by Albert Gr�f, all rights reserved. pure-tk is
  distributed under a BSD-style license, see the COPYING file for details.

  <subsection|Installation<label|installation>>

  Get the latest source from <hlink|http://pure-lang.googlecode.com/files/pure-tk-0.3.tar.gz|http://pure-lang.googlecode.com/files/pure-tk-0.3.tar.gz>.

  As with the other addon modules for Pure, running <verbatim|make>
  <verbatim|&&> <verbatim|sudo> <verbatim|make> <verbatim|install> should
  usually do the trick. This requires that you have Pure and Tcl/Tk
  installed. <verbatim|make> tries to guess your Pure installation directory
  and platform-specific setup. If it gets this wrong, you can set some
  variables manually. In particular, <verbatim|make> <verbatim|install>
  <verbatim|prefix=/usr> sets the installation prefix. Please see the
  Makefile for details.

  <with|font-series|bold|Note:> When starting a new interpreter, the Tcl/Tk
  initialization code looks for some initialization files which it executes
  before anything else happens. Usually these files will be found without any
  further ado, but if that does not happen automatically, you must set the
  TCL_LIBRARY and TK_LIBRARY environment variables to point to the Tcl and Tk
  library directories on your system.

  All programs in the examples subdirectory have been set up so that they can
  be compiled to native executables, and a Makefile is provided in that
  directory to handle this. So after installing pure-tk you just need to type
  <verbatim|make> there to compile the examples. (This step isn't necessary,
  though, you can also just run the examples with the Pure interpreter as
  usual.)

  <subsection|Basic Usage<label|basic-usage>>

  <\description>
    <item*|tk cmd<label|tk>>execute a Tcl command
  </description>

  You can submit a command to the Tcl interpreter with <verbatim|tk>
  <verbatim|cmd> where <verbatim|cmd> is a string containing the command to
  be executed. If the Tcl command returns a value (i.e., a nonempty string)
  then <hlink|<with|font-family|tt|tk>|#tk> returns that string, otherwise
  it returns <verbatim|()>.

  <hlink|<with|font-family|tt|tk>|#tk> also starts a new instance of the
  Tcl interpreter if it is not already running. To stop the Tcl interpreter,
  you can use the <hlink|<with|font-family|tt|tk_quit>|#tk-quit> function.

  <\description>
    <item*|tk_quit<label|tk-quit>>stop the Tcl interpreter
  </description>

  Note that, as far as pure-tk is concerned, there's only one Tcl interpreter
  per process, but of course you can create secondary interpreter instances
  in the Tcl interpreter using the appropriate Tcl commands.

  Simple dialogs can be created directly using Tk's <verbatim|tk_messageBox>
  and <verbatim|tk_dialog> functions. For instance:

  <\verbatim>
    tk "tk_dialog .warning \\"Warning\\" \\"Are you sure?\\" warning 0 Yes No
    Cancel";
  </verbatim>

  Other kinds of common dialogs are available; see the Tcl/Tk manual for
  information.

  For more elaborate applications you probably have to explicitly create some
  widgets, add the appropriate callbacks and provide a main loop which takes
  care of processing events in the Tcl/Tk GUI. We discuss this in the
  following.

  <subsection|Callbacks<label|callbacks>>

  pure-tk installs a special Tcl command named <verbatim|pure> in the
  interpreter which can be used to implement callbacks in Pure. This command
  is invoked from Tcl as follows:

  <\verbatim>
    pure function args ...
  </verbatim>

  It calls the Pure function named by the first argument, passing any
  remaining (string) arguments to the callback. If the Pure callback returns
  a (nonempty) string, that value becomes the return value of the
  <verbatim|pure> command, otherwise the result returned to the Tcl
  interpreter is empty.

  Pure callbacks are installed on Tk widgets just like any other, just using
  the <verbatim|pure> command as the actual callback command. For instance,
  you can define a callback which gets invoked when a button is pushed as
  follows:

  <\verbatim>
    using tk, system;

    tk "button .b -text {Hello, world!} -command {pure hello}; pack .b";

    hello = puts "Hello, world!";
  </verbatim>

  <subsection|The Main Loop<label|the-main-loop>>

  <\description>
    <item*|tk_main<label|tk-main>>call the Tk main loop
  </description>

  The easiest way to provide a main loop for your application is to just call
  <hlink|<with|font-family|tt|tk_main>|#tk-main> which keeps processing
  events in the Tcl interpreter until the interpreter is exited. You can
  terminate the interpreter in a Pure callback by calling
  <hlink|<with|font-family|tt|tk_quit>|#tk-quit>. Thus a minimalistic Tcl/Tk
  application coded in Pure may look as follows:

  <\verbatim>
    using tk;

    tk "button .b -text {Hello, world!} -command {pure tk_quit}; pack .b";

    tk_main;
  </verbatim>

  The main loop terminates as soon as the Tcl interpreter is exited, which
  can happen, e.g., in response to a callback which invokes the
  <hlink|<with|font-family|tt|tk_quit>|#tk-quit> function (as shown above)
  or Tcl code which destroys the main window (<verbatim|destroy>
  <verbatim|.>). The user can also close the main window from the window
  manager in order to exit the main loop.

  <subsection|Accessing Tcl Variables<label|accessing-tcl-variables>>

  <\description>
    <item*|tk_set var val<label|tk-set>>

    <item*|tk_unset var<label|tk-unset>>

    <item*|tk_get var<label|tk-get>>set and get Tcl variables
  </description>

  pure-tk allows your script to set and retrieve variable values in the Tcl
  interpreter with the <hlink|<with|font-family|tt|tk_set>|#tk-set>,
  <hlink|<with|font-family|tt|tk_unset>|#tk-unset> and
  <hlink|<with|font-family|tt|tk_get>|#tk-get> functions. This is useful,
  e.g., to change the variables associated with entry and button widgets, and
  to retrieve the current values from the application. For instance:

  <\verbatim>
    \<gtr\> tk_set "entry_val" "some string";

    "some string"

    \<gtr\> tk_get "entry_val";

    "some string"

    \<gtr\> tk_unset "entry_val";

    ()

    \<gtr\> tk_get "entry_val";

    tk_get "entry_val"
  </verbatim>

  Note that <hlink|<with|font-family|tt|tk_set>|#tk-set> returns the
  assigned value, so it is possible to chain such calls if several variables
  have to be set to the same value:

  <\verbatim>
    \<gtr\> tk_set "foo" $ tk_set "bar" "yes";

    "yes"

    \<gtr\> map tk_get ["foo","bar"];

    ["yes","yes"]
  </verbatim>

  <subsection|Conversions Between Pure and Tcl
  Values<label|conversions-between-pure-and-tcl-values>>

  As far as pure-tk is concerned, all Tcl values are strings (in fact, that's
  just what they are at the Tcl language level, although the Tcl interpreter
  uses more elaborate representations of objects such as lists internally).
  There are no automatic conversions of any kind. Thus, the arguments passed
  to a Pure callback and the result returned by
  <hlink|<with|font-family|tt|tk>|#tk> are simply strings in Pure land. The
  same holds for the <hlink|<with|font-family|tt|tk_set>|#tk-set> and
  <hlink|<with|font-family|tt|tk_get>|#tk-get> functions.

  However, there are a few helper functions which can be used to convert
  between Tcl and Pure data. First, the following operations convert Pure
  lists to corresponding Tcl lists and vice versa:

  <\description>
    <item*|tk_join xs<label|tk-join>>

    <item*|tk_split s<label|tk-split>>convert between Pure and Tcl lists
  </description>

  <\verbatim>
    \<gtr\> tk_join ["0","1.0","Hello, world!"];

    "0 1.0 {Hello, world!}"

    \<gtr\> tk_split ans;

    ["0","1.0","Hello, world!"]
  </verbatim>

  The <hlink|<with|font-family|tt|tk_str>|#tk-str> and
  <hlink|<with|font-family|tt|tk_val>|#tk-val> operations work in a similar
  fashion, but they also do automatic conversions for numeric values (ints,
  bigints and doubles):

  <\description>
    <item*|tk_str xs<label|tk-str>>

    <item*|tk_val s<label|tk-val>>convert between Pure and Tcl values with
    numeric conversions
  </description>

  <\verbatim>
    \<gtr\> tk_str [0,1.0,"Hello, world!"];

    "0 1.0 {Hello, world!}"

    \<gtr\> tk_val ans;

    [0,1.0,"Hello, world!"]
  </verbatim>

  In addition, these operations also convert single atomic values:

  <\verbatim>
    \<gtr\> tk_str 1.0;

    "1.0"

    \<gtr\> tk_val ans;

    1.0
  </verbatim>

  <subsection|Tips and Tricks<label|tips-and-tricks>>

  Here are a few other things that are worth keeping in mind when working
  with pure-tk.

  <\itemize>
    <item>Errors in Tcl/Tk commands can be handled by giving an appropriate
    definition of the <verbatim|tk_error> function, which is invoked with an
    error message as its single argument. For instance, the following
    implementation of <verbatim|tk_error> throws an exception:

    <\verbatim>
      tk_error msg = throw msg;
    </verbatim>

    If no definition for this function is provided, then errors cause a
    literal <verbatim|tk_error> <verbatim|msg> expression to be returned as
    the result of the <hlink|<with|font-family|tt|tk>|#tk> function. You
    can then check for such results and take an appropriate action.

    <item>The Tcl interpreter, when started, displays a default main window,
    which is required by most Tk applications. If this is not desired (e.g.,
    if only the basic Tcl commands are needed), you can hide this window
    using a <verbatim|tk> <verbatim|"wm> <verbatim|withdraw> <verbatim|.">
    command. To redisplay the window when it is needed, use the <verbatim|tk>
    <verbatim|"wm> <verbatim|deiconify> <verbatim|."> command. It is also
    common practice to use <verbatim|wm> <verbatim|withdraw> and
    <verbatim|wm> <verbatim|deiconify> while creating the widgets of an
    application, in order to reduce ``flickering''.

    <item>Instead of calling <hlink|<with|font-family|tt|tk_main>|#tk-main>,
    you can also code your own main loop in Pure as follows:

    <\verbatim>
      main = do_something $$ main if tk_ready;

      \ \ \ \ \ = () otherwise;
    </verbatim>

    Note that the <verbatim|tk_ready> function checks whether the Tcl
    interpreter is still up and running, after processing any pending events
    in the interpreter. This setup allows you to do your own custom idle
    processing in Pure while the application is running. However, you have to
    be careful that your <verbatim|do_something> routine runs neither too
    short nor too long (a few milliseconds should usually be ok). Otherwise
    your main loop may turn into a busy loop and/or the GUI may become very
    sluggish and unresponsive. Thus it's usually better to just call
    <hlink|<with|font-family|tt|tk_main>|#tk-main> and do any necessary
    background processing using the Tcl interpreter's own facilities (e.g.,
    by setting up a Pure callback with the Tcl <verbatim|after> command).

    <item>The <hlink|<with|font-family|tt|tk>|#tk> function can become
    rather tedious when coding larger Tk applications. Usually, you will
    prefer to put the commands making up your application into a separate Tcl
    script. One way to incorporate the Tcl script into your your Pure program
    is to use the Tcl <verbatim|source> command, e.g.:

    <\verbatim>
      tk "source myapp.tcl";
    </verbatim>

    However, this always requires the script to be available at runtime.
    Another method is to read the script into a string which is assigned to a
    Pure constant, and then invoke the <hlink|<with|font-family|tt|tk>|#tk>
    command on this string value:

    <\verbatim>
      using system;

      const ui = fget $ fopen "myapp.tcl" "r";

      tk ui;
    </verbatim>

    This still reads the script at runtime if the Pure program is executed
    using the Pure interpreter. However, you can now compile the Pure program
    to a native executable (see the Pure manual for details on this), in
    which case the text of the Tcl script is included verbatim in the
    executable. The compiled program can then be run without having the
    original Tcl script file available:

    <\verbatim>
      $ pure -c myapp.pure -o myapp

      $ ./myapp
    </verbatim>

    This is also the method to use for running existing Tk applications,
    e.g., if you create the interface using some interface builder like
    <hlink|vtcl|http://vtcl.sourceforge.net>.
  </itemize>

  <\itemize>
    <item>The Tcl <verbatim|package> command allows you to load additional
    extensions into the Tcl interpreter at runtime. For instance:

    <\verbatim>
      tk "package require Gnocl";
    </verbatim>

    This loads Peter G. Baum's <hlink|Gnocl|http://www.gnocl.org/>
    extension which turns Tcl into a frontend for
    <hlink|GTK+|http://www.gtk.org/> and
    <hlink|Gnome|http://www.gnome.org/>. In fact, pure-tk includes a special
    module to handle the nitty-gritty details of creating a GTK+/Gnome
    application from a <hlink|Glade|http://glade.gnome.org/> UI file and
    set up Pure callbacks as specified in the UI file. To use this, just
    import the gnocl.pure module into your Pure scripts:

    <\verbatim>
      using gnocl;
    </verbatim>

    Note that the Glade interface requires that you have a fairly recent
    version of Gnocl installed (Gnocl 0.9.94g has been tested). The other
    facilities provided by the gnocl.pure module should also work with older
    Gnocl versions such as Gnocl 0.9.91. Please see the gnocl.pure module and
    the corresponding examples included in the sources for more information.

    <item>The Tcl <verbatim|exit> procedure, just as in tclsh or wish, causes
    exit from the current process. Since the Tcl interpreter hosted by the
    pure-tk module runs as part of a Pure program and not as a separate child
    process, this might not be what you want. If you'd like <verbatim|exit>
    to only exit the Tcl interpreter, without exiting the Pure program, you
    can redefine the <verbatim|exit> procedure, e.g., as follows:

    <\verbatim>
      tk "proc exit { {returnCode 0} } { pure tk_quit }";
    </verbatim>

    If you want to do something with the exit code provided by
    <verbatim|exit>, you will have to provide an appropriate callback
    function, e.g.:

    <\verbatim>
      tk "proc exit { {returnCode 0} } { pure quit_cb $returnCode }";
    </verbatim>

    A suitable implementation of <verbatim|quit_cb> might look as follows:

    <\verbatim>
      quit_cb 0 = puts "Application exited normally." $$ tk_quit;

      quit_cb n = printf "Application exited with exit code %d.\\n" n $$

      \ \ \ \ \ \ \ \ \ \ \ \ tk_quit otherwise;
    </verbatim>

    <item>If you need dialogs beyond the standard kinds of message boxes and
    common dialogs, you will have to do these yourself using a secondary
    toplevel. The dialog toplevel is just like the main window but will only
    be shown when the application needs it. You can construct both non-modal
    and modal dialogs this way, the latter can be implemented using Tk's
    <verbatim|grab> command.
  </itemize>

  <subsubsection*|<hlink|Table Of Contents|index.tm><label|pure-tk-toc>>

  <\itemize>
    <item><hlink|pure-tk|#>\ 

    <\itemize>
      <item><hlink|Introduction|#introduction>\ 

      <item><hlink|Copying|#copying>\ 

      <item><hlink|Installation|#installation>\ 

      <item><hlink|Basic Usage|#basic-usage>\ 

      <item><hlink|Callbacks|#callbacks>\ 

      <item><hlink|The Main Loop|#the-main-loop>\ 

      <item><hlink|Accessing Tcl Variables|#accessing-tcl-variables>\ 

      <item><hlink|Conversions Between Pure and Tcl
      Values|#conversions-between-pure-and-tcl-values>\ 

      <item><hlink|Tips and Tricks|#tips-and-tricks>
    </itemize>
  </itemize>

  Previous topic

  <hlink|Pure GTK+ Bindings|pure-gtk.tm>

  Next topic

  <hlink|faust2pd: Pd Patch Generator for Faust|faust2pd.tm>

  <hlink|toc|#pure-tk-toc> <hlink|index|genindex.tm>
  <hlink|modules|pure-modindex.tm> \| <hlink|next|faust2pd.tm> \|
  <hlink|previous|pure-gtk.tm> \| <hlink|Pure Language and Library
  Documentation|index.tm>

  <copyright> Copyright 2009-2010, Albert Gr�f et al. Created using
  <hlink|Sphinx|http://sphinx.pocoo.org/> 1.1pre.\ 
</body>
