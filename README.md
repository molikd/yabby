<div id="page_1">

<div id="dimg1">![](yabby_images/yabby1x1.jpg)</div>

Yabby User Guide

| 

Copyright <span class="ft1"></span>c

 | 

Vladimir Liki´c

 |

with contributions from:

 |

Peter Wolynec

 |

Sean Lithgow

 |

YABBY version 0.1

 |

Yabby is a lightweight bioinformatics workbench that provides a centralized framework for the management and reuse of Perl program scripts. The speciﬁc design goal of Yabby is to allow easy writing of extensions and new functionality.

</div>

<div id="page_2">

<div id="id_1">

Contents

| 

Basics

 | 

1

 |
| 

1.1

 | 

Introduction . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

1

 |
| 

1.2

 | 

Installation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

2

 |

1.2.1 Checking Perl . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

2

 |

1.2.2

 | 

Downloading Yabby . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

2

 |

1.2.3 Linux installation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

3

 |

1.2.4 Windows Installation . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

4

 |
| 

1.3

 | 

Running Yabby . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

6

 |

1.3.1

 | 

An interactive session . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

6

 |

1.3.2

 | 

Yabby command scripts . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

6

 |

1.3.3

 | 

Executing Unix commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

7

 |
| 

1.4

 | 

Understanding how Yabby works . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

8

 |

1.4.1

 | 

The exchange of data between command scripts . . . . . . . . . . . . . . . . . . .

 | 

8

 |

<span class="ft6">1.4.2</span><span class="ft7">The workspace . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11</span>

<span class="ft6">1.4.3</span><span class="ft7">The data formats . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12</span>

| 

Tutorial

 | 

15

 |

<span class="ft6">2.1</span><span class="ft9">Working with sequences . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15 2.1.1 </span><nobr>Swiss-Prot</nobr> related commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26

<span class="ft6">2.2</span><span class="ft11">Housekeeping commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30</span>

<span class="ft6">2.3</span><span class="ft11">Working with sequence motifs . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32</span>

</div>

<div id="id_2">

i

</div>

</div>

<div id="page_3">

<div id="dimg1">![](yabby_images/yabby3x1.jpg)</div>

| 

ii

 | 

CONTENTS

 |

<span class="ft6">2.4</span><span class="ft11">Working with the HMMER output . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34</span>

| 

2.5

 | 

Running NCBI BLAST from Yabby . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

35

 |
| 

2.6

 | 

EMBOSS ’needle’ commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

37

 |

<span class="ft6">2.7</span><nobr><span class="ft11">Stand-alone</span></nobr> commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40

<span class="ft6">2.8</span><span class="ft11">Extending Yabby . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41</span>

<span class="ft6">2.8.1</span><span class="ft7">Creating a new Yabby command: seq letter . . . . . . . . . . . . . . . . . . . . . . 41</span>

<span class="ft6">2.8.2</span><span class="ft7">Extending seq letter to work on all sequences . . . . . . . . . . . . . . . . . . . . . 44</span>

2.8.3 Adding a command switch . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45

<span class="ft6">2.8.4</span><span class="ft7">A command that creates an object . . . . . . . . . . . . . . . . . . . . . . . . . . . 48</span>

<span class="ft6">2.8.5</span><span class="ft7">Creating a new object type . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52</span>

<span class="ft6">2.8.6</span><span class="ft7">Some additional explanations and programming conventions . . . . . . . . . . . . . 56</span>

| 

Command reference

 | 

57

 |

<span class="ft6">3.1</span><span class="ft11">General commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57</span>

| 

3.1.1

 | 

delete . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

57

 |
| 

3.1.2

 | 

dump . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

58

 |

<span class="ft6">3.1.3</span><span class="ft7">ﬂush . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58</span>

<span class="ft6">3.1.4</span><span class="ft7">license . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59</span>

3.1.5 help . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60

<span class="ft6">3.1.6</span><span class="ft7">print . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60</span>

<span class="ft6">3.1.7</span><span class="ft7">restore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62</span>

<span class="ft6">3.1.8</span><span class="ft7">what . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62</span>

<span class="ft6">3.2</span><span class="ft11">Sequence commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63</span>

<span class="ft6">3.2.1</span><span class="ft7">seq comment . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63</span>

<span class="ft6">3.2.2</span><span class="ft7">seq compl . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64</span>

<span class="ft6">3.2.3</span><span class="ft7">seq genbank . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64</span>

3.2.4 seq info . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65

3.2.5 seq load . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66

</div>

<div id="page_4">

<div id="dimg1">![](yabby_images/yabby4x1.jpg)</div>

<div id="id_1">

| 

CONTENTS

 | 

iii

 |

<span class="ft6">3.2.6</span><span class="ft7">seq op . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67</span>

3.2.7 seq os . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67

<span class="ft6">3.2.8</span><span class="ft7">seq pattern . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68</span>

<span class="ft6">3.2.9</span><span class="ft7">seq pick . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 69</span>

<span class="ft6">3.2.10</span><span class="ft13">seq sprot os . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70</span>

<span class="ft6">3.2.11</span><span class="ft13">seq strip . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71</span>

3.2.12 seq uniprot . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72

3.2.13 seq unique . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72

<span class="ft6">3.3</span><nobr><span class="ft11">Swiss-Prot</span></nobr> related commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73

3.3.1 sprot fetch . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73

<span class="ft6">3.3.2</span><span class="ft7">sprot os . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74</span>

<span class="ft6">3.4</span><span class="ft11">HMMER commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74</span>

<span class="ft6">3.4.1</span><span class="ft7">hmm score extract . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74</span>

<span class="ft6">3.4.2</span><span class="ft7">hmm score2seq . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75</span>

3.5 Sequence motifs commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76

<span class="ft6">3.5.1</span><span class="ft7">motif load . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76</span>

<span class="ft6">3.5.2</span><span class="ft7">motif cmp . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 77</span>

<span class="ft6">3.5.3</span><span class="ft7">motif meme . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 77</span>

<span class="ft6">3.6</span><span class="ft11">BLAST commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78</span>

<span class="ft6">3.6.1</span><span class="ft7">blast . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78</span>

| 

3.6.2

 | 

blast

 | 

info . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

79

 |
| 

3.6.3

 | 

blastg . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

80

 |
| 

3.7 Protein <nobr>three-dimensional</nobr> structure commands . . . . . . . . . . . . . . . . . . . . . . . .

 | 

81

 |

<span class="ft6">3.7.1</span><span class="ft7">mol load . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 81</span>

<span class="ft6">3.7.2</span><span class="ft7">mol2seq . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 82</span>

</div>

<div id="id_2">

| 

3.7.3

 | 

pdb

 | 

conv . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

82

 |
| 

3.7.4

 | 

pdb

 | 

model . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

83

 |
| 

3.8 EMBOSS commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

 | 

85

 |

</div>

</div>

<div id="page_5">

<div id="dimg1">![](yabby_images/yabby5x1.jpg)</div>

| 

iv

 | 

CONTENTS

 |

<span class="ft6">3.8.1</span><span class="ft7">emboss needle . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 85</span>

3.8.2 emboss needl2 . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86

<span class="ft6">3.9</span><span class="ft11">Miscellaneous commands . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86</span>

<span class="ft6">3.9.1</span><span class="ft7">pfam fetch . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86</span>

<span class="ft6">3.9.2</span><span class="ft7">sprot split . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 87</span>

</div>

<div id="page_6">

<div id="id_1">

Basics

<span class="ft16">1.1</span><span class="ft17">Introduction</span>

Many bioinformatics tasks are solved by writing of specialised programs, typically using scripting lan- guages that allow rapid development and are supported by well developed libraries. When the level of generality is required, or when such programs manipulate large data ﬁles, testing and debugging may involve considerable eﬀort and time. In spite of their inherent value, such programs typically end up scattered with <nobr>project-speciﬁc</nobr> data ﬁles, and are often lost after the completion of the project as a result of data, interest, or people migration.

Applications in bioinformatics involve a variety of tasks, for example sequence analysis, database search- ing, analysis of instrumentation data, and so on. General purpose scripting languages such as Perl, Python and others are particularly well suited for applications in bioinformatics. However, the advantage of scripting languages are often diminished by the <span class="ft2">ad hoc </span>development process, where little thought given to long term retention and <nobr>re-use</nobr> of resulting program scripts.

Bioinformatics data structures are often represented as text. Because of its exceptional text processing capabilities, strong library support, and open source nature, the Perl programming language is very popular for applications in bioinformatics. Prominent examples of bioinformatics packages developed in Perl include BioPerl, a set of programming libraries with particular strengths in manipulation and analysis of sequence data, and MMTSB, a set of utilities and libraries for the analysis of structural, simulation, and prediction data. The availability of high quality libraries makes Perl even more attractive for applications in bioinformatics. However, inasmuch as the totality of Perl features aids in rapid development of custom program scripts, this also exacerbates the problem of proliferation of <nobr>in-house</nobr> program scripts, and therefore the problem of their management, long term retention, and <nobr>re-use.</nobr>

Yabby aims to support a long term retention of dissipate Perl program scripts developed for bioinformat- ics, and is also an environment for the execution of these scripts. Yabby consists of an interactive shell and a library of program scripts that provide a speciﬁc functionality. The shell provides the command line interface to the user, and a mechanism to execute library program scripts. Program scripts can have either <nobr>stand-alone</nobr> functionality, or they can be a part of a larger processing pipeline. In the latter case, they exchange the data through the common data model. For this purpose two diﬀerent data formats are used, <nobr>two-dimensional</nobr> tables and XML. Yabby is modular and extensible, and allows users to modify existing functionality and to easily add new functionality.

</div>

<div id="id_2">

1

</div>

</div>

<div id="page_7">

| 

2

 | 

Chapter 1\. Basics

 |

Yabby is released as open source, under the GNU Public License version 2.

<span class="ft16">1.2</span><span class="ft17">Installation</span>

<span class="ft21">1.2.1</span><span class="ft22">Checking Perl</span>

Yabby has been developed with Perl version 5.X, a freely available general purpose scripting language. Perl stands for ”Practical Extraction and Report Language” and is particularly well suited for the ma- nipulation of data stored in plain text ﬁles.

Before attempting the installation, it is highly recommended to check if the Perl interpreter is present on your computer system. For example, on a Linux system,

$ perl <nobr>-v</nobr>

This is perl, v5.8.5 built for <nobr>i386-linux-thread-multi</nobr>

Copyright <nobr>1987-2004,</nobr> Larry Wall

Perl may be copied only under the terms of either the Artistic License or the GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on this system using ‘man perl’ or ‘perldoc perl’. If you have access to the Internet, point your browser at http://www.perl.com/, the Perl Home Page.

Perl 5 and later is required for Yabby. The next step is to ﬁnd where exactly is the Perl interpreter located, as this information will be required for Yabby installation:

$ which perl /usr/local/bin/perl

<span class="ft21">1.2.2</span><span class="ft22">Downloading Yabby</span>

Yabby source code can be browsed from the Google Code servers, at the URL: http://code.google.com/p/yabby/. Under the section ”Source” one can ﬁnd the instructions for downloading the source code. The same

page provides the link under ”This project’s Subversion repository can be viewed in your web browser” which allows one to browse the source code on the server without actually downloading it.

Google servers maintain the source code by the program called ’subversion’ (an <nobr>open-source</nobr> version con- trol system). To download the source code one needs to use the subversion client program called ’svn’. The

</div>

<div id="page_8">

<div id="dimg1">![](yabby_images/yabby8x1.jpg)</div>

| 

1.2\. Installation

 | 

3

 |

’svn’ client exists for all mainstream operating systems<span class="ft29">1</span>, for more information see http://subversion.tigris.org/. The book about subversion is freely available <nobr>on-line</nobr> at <nobr>http://svnbook.red-bean.com/.</nobr> Subversion has extensive functionality however only the very basic functionality is needed to download Yabby. Assuming that the computer is connected to the internet, the following command will download the latest Yabby source code in the current directory:

$ svn checkout http://yabby.googlecode.com/svn/trunk/ yabby

<span class="ft25">A</span><span class="ft30">yabby/yabby.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/LICENSE</span>

<span class="ft25">A</span><span class="ft30">yabby/lib</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/blast.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/hmm_score2seq.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/seq_strip.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/seq_comment.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/hmm_score_extract.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/blastg.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/motif_cmp.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/seq_unique.pl</span>

<span class="ft25">A</span><span class="ft30">yabby/lib/yabby_seq.pm</span>

....further output deleted....

<span class="ft21">1.2.3</span><span class="ft22">Linux installation</span>

The installation of Yabby requires that the ﬁle ’yabby/lib/yabby.pl’ is modiﬁed in order to set the path to the Perl language interpreter, and the path to Yabby libraries.

If Yabby code was downloaded in the directory /home/jake/ (and therefore the script ’yabby.pl’ is located in /home/jake/yabby/), to set the path to Yabby libraries the following two lines need to be set:

use lib "/home/jake/yabby/lib"; $LIB_DIR = "/home/jake/yabby/lib";

The path to the Perl interpreter is set in the ﬁrst line of the ﬁle ’yabby.pl’:

#!/usr/bin/perl

The script yabby.pl needs to have executable permissions:

<span class="ft25">$</span><span class="ft31">chmod +x yabby.pl</span>

<span class="ft32">1</span>For example, on Linux CentOS 4 the RPM package <nobr>’subversion-1.3.2-1.rhel4.i386.rpm’</nobr> provides the subversion client ’svn’.

</div>

<div id="page_9">

| 

4

 | 

Chapter 1\. Basics

 |

If this is all set, running the script ’yabby.pl’ will start Yabby:

<span class="ft25">$</span><span class="ft31">yabby.pl</span>

<span class="ft25">-</span><span class="ft31">YABBY version 0.1 -</span>

[ 35 command(s) ready ]

yabby>

It is often useful to create a symbolic link in a directory which is included the PATH variable, such as /usr/local/bin or /bin:

ln <nobr>-s /home/jake/yabby/yabby.pl /home/jake/bin/yabby</nobr>

This would allow Yabby to be run from any directory, simply by typing ’yabby’. When a particular Yabby command relies on an external program or library (such as NCBI BLAST), additional conﬁguration may be needed to allow Yabby to ﬁnd the appropriate ﬁles.

<span class="ft21">1.2.4</span><span class="ft22">Windows Installation</span>

Note that Yabby has been developed and tested on Linux, and should work equally well on any Unix system. There are two ways to install yabby on Windows:

<span class="ft2">1.</span><span class="ft34">Using Cygwin. Cygwin is a complete Unix environment on Windows, and Linux/Unix installation instructions apply. Yabby is expected to work with full functionality under Cygwin.</span>

<span class="ft2">2.</span><span class="ft34">Using ActivePerl. Yabby can work in this environment, however the testing was limited and not all commands will work. A detailed installation instructions are given below.</span>

Installing ActivePerl

The perl interpreter must be installed, we recommend to to install ActiveState’s ActivePerl.

http://www.activestate.com/Products/activeperl/

At this site one can obtain a free copy of the ActivePerl installer, which will then need to executed to install the interpreter.

</div>

<div id="page_10">

<div id="id_1">

| 

1.2\. Installation

 | 

5

 |

Installing a subversion client

Google servers maintain the Yabby source code by the program called ’subversion’ (an <nobr>open-source</nobr> version control system). An <nobr>easy-to-use</nobr> interface to subversion for Windows is TortoiseSVN. It is an extension of the shell, so it can be (and must be) used straight from Windows Explorer. It is available for free download from here:

http://tortoisesvn.net/downloads

Run the .msi executable, and it will install. This will also require a reboot.

Downloading Yabby

The following instructions refer speciﬁcally to TortoiseSVN. It is recommended, but not necessary, that a new directory be created anywhere in the ﬁlesystem where the Yabby source code is to be located. For example:

C:\

<span class="ft8">1 </span>create C:\. Then open this directory.

<span class="ft8">2 </span><nobr>Right-click</nobr> the empty space and select SVN Checkout.

<span class="ft8">3 </span>The URL is http://yabby.googlecode.com/svn/trunk/. Click OK.

Yabby installation

Yabby installation requires that the ﬁle ’yabby.pl’ is modiﬁed to set the path to Yabby libraries.

If Yabby code was downloaded in the root directory C:\, to set the path to Yabby libraries the following two lines need to be set (yabby.pl is stored in binary format, not text. So use Wordpad.exe, found in

Start Menu<span class="ft2">−→</span>All Programs<span class="ft2">→</span>Accessories<span class="ft2">):</span>

use lib "C:\\Yabby\\lib"; $LIB_DIR = "C:\\Yabby\\lib";

NOTE: ‘\’ is an escape character in Perl strings, which is also the character Windows uses to separate directories. A double escape character escapes the escape. Hence the need for two.

If you <nobr>double-click</nobr> yabby.pl now, it will start Yabby.

</div>

<div id="id_2">

- YABBY version 0.1 -

</div>

</div>

<div id="page_11">

| 

6

 | 

Chapter 1\. Basics

 |

[ 38 command(s) ready ]

yabby>

<span class="ft16">1.3</span><span class="ft17">Running Yabby</span>

<span class="ft21">1.3.1</span><span class="ft22">An interactive session</span>

Yabby can be run interactively or from the command script. To start an Yabby interactive session one needs to start the Yabby interface from the Unix shell. Here is the simplest Yabby session:

<span class="ft25">$</span><span class="ft31">yabby</span>

<span class="ft25">-</span><span class="ft31">YABBY version 0.1 -</span>

[ 35 command(s) ready ]

yabby> quit

<nobr>bye-bye</nobr>

<span class="ft21">1.3.2</span><span class="ft22">Yabby command scripts</span>

In order to run Yabby from the command script, the command ﬁle needs to be prepared ﬁrst. Such a ﬁle lists Yabby commands one per line, with optional blank lines (lines which start with the % character are ignored). For example, the following input ﬁle, named test.yab,

% test.yab <nobr>--</nobr> test input script

seq_load cad3.seq cad3 seq_info <nobr>-l</nobr> cad3

could be run with the Unix shell with input redirection:

<span class="ft25">$</span><span class="ft31">yabby < test.yab</span>

<span class="ft25">-</span><span class="ft31">YABBY version 0.1 -</span>

[ 35 command(s) ready ]

yabby> % test.yab <nobr>--</nobr> test input script

</div>

<div id="page_12">

| 

1.3\. Running Yabby

 | 

7

 |

yabby> yabby>

Reading the file ’cad3.seq’ .. 3 sequence(s) found.

yabby>

’cad3’ contains 3 sequence(s)

1 <nobr>-></nobr> Q53650_STAAU, 192 residues

2 <nobr>-></nobr> Q97PJ0_STRPN, 193 residues

3 <nobr>-></nobr> P95773_STALU, 192 residues

yabby> yabby> <nobr>bye-bye</nobr>

When run from the command script the actual commands are not echoed back, only the command’s screen output as well as the comments are seen.

<span class="ft21">1.3.3</span><span class="ft22">Executing Unix commands</span>

Any command which is not recognized by Yabby is assumed to be an Unix command, and Yabby will attempt to execute it. Consider the following example:

| 

yabby> ls

 |
| 

1BT0.pdb

 | 

cox1.seq

 | 

LmjFmockup.pep

 | 

needle.out

 |
| 

cad3.seq

 | 

dna.seq

 | 

m2.blocks

 | 

README

 |
| 

cad.seq

 | 

hmmpfam.out

 | 

meme.out

 | 

test.yab

 |
| 

yabby> l

 |

[ UNIX command ’l’ failed ]

Because there is no Yabby command <span class="ft25">ls</span>, it was assumed to be a system command and executed. The output was printed on the screen, listing the ﬁles and directories in the directory where Yabby was started.

Subsequently, the command <span class="ft36">l </span>was given but failed because there is no such Yabby or Unix command. If <span class="ft36">l </span>was an alias to something (say <span class="ft36">ls </span><nobr><span class="ft36">-CF</span>)</nobr> the command would fail regardless, because Yabby does not know about shell aliases.

There are no inherent limitations to which Unix commands can be executed within Yabby. It is possible to run a text editor, such as ”vi” (and then simply resume the Yabby session after exiting the editor), or even start programs with GUI such as ”gnuplot”, or a Unix terminal window.

A subtle but important point is that Unix commands are not executed through the Unix shell. The consequence of this is that the (sometimes important) functions provided by the Unix shell, such as ﬁle globing, are not available. For example:

</div>

<div id="page_13">

<div id="id_1">

| 

8

 | 

Chapter 1\. Basics

 |
| 

yabby> ls *

 |
| 

ls: *: No such file or directory

 |
| 

[ UNIX command ’ls *’ failed ]

 |

A handy trick which allows one to go about Unix business is to temporarily suspend Yabby. This is actually a feature provided by some unix shells (in combination with the system’s terminal driver), and has little to do with Yabby. In short, typing <nobr>Ctrl-Z</nobr> within Yabby will suspend the current Yabby session, and return user to the Unix shell. Issuing the command ”fg” to the same shell will return the suspended Yabby session:

| 

yabby> <nobr>[Cntrl-Z]</nobr>

 |
| 

[1]+ Stopped

 | 

yabby

 |
| 

$ ls <nobr>-CF</nobr>

 |
| 

1BT0.pdb

 | 

cox1.seq

 | 

LmjFmockup.pep

 | 

needle.out

 |
| 

cad3.seq

 | 

dna.seq

 | 

m2.blocks

 | 

README

 |
| 

cad.seq

 | 

hmmpfam.out

 | 

meme.out

 | 

test.yab

 |
| 

$ fg

 |

yabby>

<nobr>Ctrl-Z</nobr> was typed on the ﬁrst line, which was not echoed back. Note that the second command prompt (starting with the <span class="ft24">$ </span>character) is the Unix shell prompt, and typing ”fg” had returned user to the suspended Yabby session.

<span class="ft16">1.4</span><span class="ft17">Understanding how Yabby works</span>

To understand how Yabby works it is important to understand the relationship between three directories: the working directory (where the Yabby session has been started), the Yabby library (this is the lib/ subdirectory in the Yabby installation directory), and the workspace directory.

The workspace directory is created automatically when the Yabby session is initialized. By default, the workspace directory is called .yabby, and it is created in the working directory. The workspace directory contains all the yabby objects created within the session. Upon a graceful exit from Yabby the workspace directory is destroyed together with its content.

<span class="ft21">1.4.1</span><span class="ft22">The exchange of data between command scripts</span>

Consider what happens when the sequences were read from the ﬁle ’tom20.fas’ to create a sequence object in the workspace:

</div>

<div id="id_2">

<span class="ft25">1</span><span class="ft37">$ yabby</span>

</div>

</div>

<div id="page_14">

| 

1.4\. Understanding how Yabby works

 | 

9

 |
| 

2

 |
| 

3

 | 

- YABBY version 0.1 -

 |
| 

4

 |
| 

5

 | 

[ 35 command(s) ready ]

 |
| 

6

 |
| 

7

 | 

yabby> seq_load tom20.fas tom20

 |
| 

8

 |
| 

9

 | 

Reading the file ’tom20.fas’ ..

 |
| 

10

 | 

3 sequence(s) found.

 |
| 

11

 |
| 

12

 | 

yabby> what

 |
| 

13

 |
| 

14

 | 

object(s)

 | 

type

 |
| 

15

 | 

<nobr>------------------------------</nobr>

 |
| 

16

 | 

tom20

 | 

seq

 |
| 

17

 |
| 

18

 | 

yabby> print tom20.seq

 |
| 

19

 |
| 

20

 | 

>A.thaliana2 [ A.thaliana2 ]

 |

<span class="ft25">21</span><span class="ft31">MEFSTADFERFIMFEHARKNSEAQYKNDPLDSENLLKWGGALLELSQFQPIPEAKLMLND</span>

<span class="ft25">22</span><span class="ft31">AISKLEEALTINPGKHQALWCIANAYTAHAFYVHDPEEAKEHFDKATEYFQRAENEDPGN</span>

<span class="ft25">23</span><span class="ft31">DTYRKSLDSSLKAPELHMQFMNQGMGQQILGGGGGGGGGGMASSNVSQSSKKKKRNTEFT</span>

<span class="ft25">24</span><span class="ft31">YDVCGWIILACGIVAWVGMAKSLGPPPPAR</span>

<span class="ft25">25</span><span class="ft31">>O.sativa [ O.sativa ]</span>

<span class="ft25">26</span><span class="ft31">MDMGAMSDPERMFFFDLACQNAKVTYEQNPHDADNLARWGGALLELSQMRNGPESLKCLE</span>

<span class="ft25">27</span><span class="ft31">DAESKLEEALKIDPMKADALWCLGNAQTSHGFFTSDTVKANEFFEKATQCFQKAVDVEPA</span>

<span class="ft25">28</span><span class="ft31">NDLYRKSLDLSSKAPELHMEIHRQMASQASQAASSTSNTRQSRKKKKDSDFWYDVFGWVV</span>

<span class="ft25">29</span><span class="ft31">LGVGMVVWVGLAKSNAPPQAPR</span>

<span class="ft25">30</span><span class="ft31">>L.esculentum [ L.esculentum ]</span>

<span class="ft25">31</span><span class="ft31">MDMQSDFDRLLFFEHARKTAETTYATDPLDAENLTRWAGALLELSQFQSVSESKKMISDA</span>

<span class="ft25">32</span><span class="ft31">ISKLEEALEVNPQKHDAIWCLGNAYTSHGFLNPDEDEAKIFFDKAAQCFQQAVDADPENE</span>

<span class="ft25">33</span><span class="ft31">LYQKSFEVSSKTSELHAQIHKQGPLQQAMGPGPSTTTSSTKGAKKKSSDLKYDVFGWVIL</span>

<span class="ft25">34</span><span class="ft31">AVGLVAWIGFAKSNMPXPAHPLPR</span>

In the line 1 the Yabby was started from the Unix shell command line. During the initialization process the workspace directory .yabby was silently created. The command

seq_load tom20.fas tom20

will read the sequence from the ﬁle ’tom20.fas’, and save the sequences under the name ’tom20’. The command ’what’ shown on the line 12 allows one to inspect the content of the workspace. It shows that the workspace contains one object, named ’tom20’, and this object is of the type ’seq’ (it is a sequence object). The command ’print’ on the line 18 has printed the object ’tom20’ on the terminal screen.

</div>

<div id="page_15">

<div id="dimg1">![](yabby_images/yabby15x1.jpg)</div>

| 

10

 | 

Chapter 1\. Basics

 |

The command ’seq load’ has executed the script ’seq load.pl’ located in the Yabby library. This command reads the FASTA sequence ﬁle and converts it into an Yabby object of the type ’seq’. The command ’print’ has executed the script ’print.pl’ from the Yabby library. The scripts ’seq load.pl’ and ’print.pl’ are completely independent.

How was the script ’print.pl’ aware of the data object ’tom20.seq’, and how was the data transferred between the script ’seq load.pl’ to the script ’print.pl’ for printing?

This was achieved by the use of the workspace directory. When Yabby was started (line 1) the workspace directory .yabby/ was silently created in the current working directory. The newly created object ’tom20’ (the result of the command ’seq load’) was stored in the ﬁle ’tom20.seq’ in the workspace directory. On the line 18, the command ’print’ was requested to print the object ’tom20’ of the type ’seq’. The command ’print’ has attempted to ﬁnd the object ’tom20.seq’ in the workspace. This was successful, and the object was loaded from the workspace directory, and then printed on the terminal screen.

Consider printing a <nobr>non-existent</nobr> sequence object:

yabby> print tom99.seq

_print_seq:: missing requirement: ’tom99.seq’

print:: ERROR: system script ’_print_seq’ failed [ error occurred in the subroutine call() ]

[ command ’print’ failed ]

The message above shows that ’tom99.seq’ (’tom99’ object of the type ’seq’) is not in the workspace. Furthermore, printing of the sequence objects is handled by the system script ’ print seq.pl’, which is normally invoked by the command script ’print.pl’. Hence the error message comes from ’ print seq’.

Consider printing of an object of a <nobr>non-exiting</nobr> type:

yabby> print tom20.ttt

print:: ERROR: printing the property ’ttt’ not yet implemented [ command ’print’ failed ]

In this case the error message originated from the command script ’print.pl’. This command script needs to decide which system script to call for printing. It ﬁrst determines if the printing of the requested object type has been implemented, and bombs out if not.

The relationship between the working directory, workspace, and Yabby library is shown in Figure 1.1.

</div>

<div id="page_16">

<div id="dimg1">![](yabby_images/yabby16x1.jpg)</div>

</div>

<div id="page_17">

<div id="dimg1">![](yabby_images/yabby17x1.jpg)</div>

<div id="id_1">

| 

12

 | 

Chapter 1\. Basics

 |

KHQALWCIANAYTAHAFYVHDPEEAKEHFDKATEYFQRAENEDPGNDTYRKSLDSSLKAP ELHMQFMNQGMGQQILGGGGGGGGGGMASSNVSQSSKKKKRNTEFTYDVCGWIILACGIV AWVGMAKSLGPPPPAR</sequence></seqentry><seqentry><seqid>O.sat iva</seqid><comment>O.sativa</comment><sequence>MDMGAMSDPERM FFFDLACQNAKVTYEQNPHDADNLARWGGALLELSQMRNGPESLKCLEDAESKLEEALKI DPMKADALWCLGNAQTSHGFFTSDTVKANEFFEKATQCFQKAVDVEPANDLYRKSLDLSS KAPELHMEIHRQMASQASQAASSTSNTRQSRKKKKDSDFWYDVFGWVVLGVGMVVWVGLA KSNAPPQAPR</sequence></seqentry><seqentry><seqid>L.esculentu m</seqid><comment>L.esculentum</comment><sequence>MDMQSDFDRL LFFEHARKTAETTYATDPLDAENLTRWAGALLELSQFQSVSESKKMISDAISKLEEALEV NPQKHDAIWCLGNAYTSHGFLNPDEDEAKIFFDKAAQCFQQAVDADPENELYQKSFEVSS KTSELHAQIHKQGPLQQAMGPGPSTTTSSTKGAKKKSSDLKYDVFGWVILAVGLVAWIGF AKSNMPXPAHPLPR</sequence></seqentry></seqroot>

The object ’tom20.seq’ is a plain text XML document which captures the data about sequences.

The ability to access the workspace allows one to inspect the existing objects while they reside in Yabby’s ”memory”, which often comes handy. For example, this may facilitate the understanding of an object’s internal representation, and helps the implementation (and debugging) of data models that need to be developed for new data types.

<span class="ft21">1.4.3</span><span class="ft22">The data formats</span>

Currently Yabby implements two diﬀerent data formats: <nobr>two-dimensional</nobr> list (table) and XML docu- ment. In many bioinformatics applications data can be eﬀectively represented by two dimensional tables. Examples include the list of atoms in a molecule, the list of atom coordinates, the list of sequence IDs and their rankings, etc. For such data, two dimensional tables are the ideal representation. Occassion- ally, the objects which have more complex internal structure need to be handled. For example, a list of protein sequences where each sequence may need to be characterized with several attributes: sequence ID, organism name, the sequence string consisting of amino acid residues and so on.

As an example for a <nobr>two-dimensional</nobr> list data format, consider the property ’mol’ (molecule).

yabby> mol_load 1BT0.pdb rub

661 atoms found in the molecule ’rub’

yabby> what

object(s) type

<nobr>------------------------------</nobr>

rub mol

</div>

<div id="id_2">

The command ’mol load’ has created the object ’rub.mol’. This object is stored in the workspace as the

</div>

</div>

<div id="page_18">

| 

1.4\. Understanding how Yabby works

 | 

13

 |

ﬁle ’rub.mol’:

$ cd .yabby /home/jack/data/.yabby $ ls

rub.mol

$ head rub.mol 1 MET N

1 MET CA

1 MET C

1 MET O

1 MET CB

1 MET CG

1 MET SD

1 MET CE

2 LEU N

2 LEU CA

This is an example where the <nobr>two-dimensional</nobr> list ﬁts perfectly the data type: a molecule is a list of atoms, and each atom is characterized by residue number, residue name, and atom name. This information can be naturally arranged into a <nobr>two-dimensional</nobr> table, with one atom per table row.

On the other hand, the protein or DNA sequence is not naturally amenable to the <nobr>two-dimensional</nobr> list representation. A sequence may be characterized by several attributes (sequence ID, organism name, database speciﬁc IDs, and so on) in addition to the sequence itself, which may contain a few to many thousands of letters. The matter is further complicated if the data model needs to handle transpar- ently one or more sequences. Yabby uses XML to represent such data which requires more capable representations.

Consider the content of the ﬁle ’tom20.seq’ which contains the information about three tom20 sequences given previously. If arranged in a more readable format, this sequence object looks as given below:

<?xml version="1.0"?> <seqroot>

<seqentry>

<seqid>A.thaliana2</seqid>

<comment>A.thaliana2</comment>

<sequence>MEFSTADFERFIMFEHARKNSEAQYKNDPLDSENLLKWGGALLELSQF QPIPEAKLMLNDAISKLEEALTINPGKHQALWCIANAYTAHAFYVHDPEEAKEHFD KATEYFQRAENEDPGNDTYRKSLDSSLKAPELHMQFMNQGMGQQILGGGGGGGGGG MASSNVSQSSKKKKRNTEFTYDVCGWIILACGIVAWVGMAKSLGPPPPAR

</sequence>

</seqentry>

<seqentry>

<seqid>O.sativa</seqid>

</div>

<div id="page_19">

| 

14

 | 

Chapter 1\. Basics

 |

<comment>O.sativa</comment>

<sequence>MDMGAMSDPERMFFFDLACQNAKVTYEQNPHDADNLARWGGALLELSQM RNGPESLKCLEDAESKLEEALKIDPMKADALWCLGNAQTSHGFFTSDTVKANEFFEK ATQCFQKAVDVEPANDLYRKSLDLSSKAPELHMEIHRQMASQASQAASSTSNTRQSR KKKKDSDFWYDVFGWVVLGVGMVVWVGLAKSNAPPQAPR</sequence>

</seqentry>

<seqentry>

<seqid>L.esculentum</seqid>

<comment>L.esculentum</comment>

<sequence>MDMQSDFDRLLFFEHARKTAETTYATDPLDAENLTRWAGALLELSQFQS VSESKKMISDAISKLEEALEVNPQKHDAIWCLGNAYTSHGFLNPDEDEAKIFFDKAAQC FQQAVDADPENELYQKSFEVSSKTSELHAQIHKQGPLQQAMGPGPSTTTSSTKGAKKKS SDLKYDVFGWVILAVGLVAWIGFAKSNMPXPAHPLPR</sequence>

</seqentry>

</seqroot>

Each sequence is enclosed by the XML tags <span class="ft2"><</span>seqentry<span class="ft2">> </span>and <span class="ft2"><</span>/seqentry<span class="ft2">></span>. Furthermore, the individual attributes for each sequence are enclosed in tags such as <span class="ft2"><</span>seqid<span class="ft2">> </span>and <span class="ft2"><</span>/seqid<span class="ft2">></span>, <span class="ft2"><</span>comment<span class="ft2">> </span>and <span class="ft2"><</span>/comment<span class="ft2">> </span>and so on. This allows considerable ﬂexibility in the representation of data with complex internal structure. The price for this ﬂexibility is complexity, as more eﬀort is required to design and then implement an XML based format compared to a <nobr>two-dimensional</nobr> list format.

</div>

<div id="page_20">

<div id="dimg1">![](yabby_images/yabby20x1.jpg)</div>

<div id="id_1">

Tutorial

The data ﬁles used in this tutorial can be found in docs/data/ directory. Starting Yabby in this directory should allow one to execute all examples given in the tutorial.

<span class="ft16">2.1</span><span class="ft17">Working with sequences</span>

In Yabby sequences are represented as sequence objects. A sequence object may contain one or more sequences.

One way to create a sequence object is to load sequences from a ﬁle. Consider the ﬁle ’cad3.fas’ which contains three sequences from the Pfam CAD family in the FASTA format:

>Q53650_STAAU YVATGIDYLVILILLFSQVKKGQVKHIWIGQYIGTAIVIGASLLVAQGVVNLIPQQWVIG LLGLLPLYLGVKIWIKGEEDEDESSILSLFSSGKFNQLFLTMIFIVLASSADDFSIYIPY FTTLSMSEIFIVTIVFLIMVGVLCYVSYRLASFDFISETIEKYERWIVPIVFIGLGIYIL FENGTSNALISF

>Q97PJ0_STRPN YISTSIDYLIILIILFAQLSQNKQKWHIYAGQYLGTGLLVGASLVAAYVVNFVPEEWMVG LLGLIPIYLGIRFAIVGEDAEEEEEEIIERLEQSKANQLFWTVTLLTIASGGDNLGIYIP YFASLDWSQTLVALLVFVIGIIIFCEISRVLSSIPLIFETIEKYERIIVPLVFILLGLYI MYENGTIETFLIV

>P95773_STALU YIAQALDLLVILLMFFARAKTRKEYRDIYIGQYVGSVALIVISLFFAFVLNYVPEKWILG LLGLIPIYLGIKVAIYGDSDGEERAKKELNEKGLSKLVGTIAIVTIASCGADNIGLFVPY FVTLSVTNLLITLFVFLILIFFLVFAAQKLANIPEVGEIVEKFGRWIMAVIYIALGLFII IENDTIQTILGF

To load this ﬁle in the workspace use the command ’seq load’:

yabby> seq_load cad3.fas cad3

</div>

<div id="id_2">

15

</div>

</div>

<div id="page_21">

<div id="dimg1">![](yabby_images/yabby21x1.jpg)</div>

| 

16

 | 

Chapter 2\. Tutorial

 |

Reading the file ’cad3.fas’ .. 3 sequence(s) found.

Most Yabby commands which create a new object in the workspace conform to the same pattern:

COMMAND [ options ] ARGS OBJ_NAME

Where ’[ options ]’ is where ﬂags and options are passed (if any), ARGS are the arguments to the command, and OBJ NAME is the name of the object to be created. In the example given above, there were no options to the ’seq load’ command; there was one argument, the name of the ﬁle; and the object to be created was named ’cad3’.

It is possible to inspect objects currently available in the workspace:

| 

yabby> what

 |
| 

object(s)

 | 

type

 |
| 

<nobr>------------------------------</nobr>

 |
| 

cad3

 | 

seq

 |

This listing shows that one object is currently in the workspace, of the ’seq’ type. It is possible to load the same sequences under a diﬀerent name:

yabby> seq_load cad3.fas cad3_second

Reading the file ’cad3.fas’ .. 3 sequence(s) found.

yabby> what

object(s) type

<nobr>------------------------------</nobr>

cad3 seq cad3_second seq

The two objects ’cad3.seq’ and ’cad3 second.seq’ are identical.

The command ’print’ allows one to output the sequence object:

yabby> print cad3.seq

>Q53650_STAAU [ Q53650_STAAU ] YVATGIDYLVILILLFSQVKKGQVKHIWIGQYIGTAIVIGASLLVAQGVVNLIPQQWVIG

</div>

<div id="page_22">

| 

2.1\. Working with sequences

 | 

17

 |

LLGLLPLYLGVKIWIKGEEDEDESSILSLFSSGKFNQLFLTMIFIVLASSADDFSIYIPY FTTLSMSEIFIVTIVFLIMVGVLCYVSYRLASFDFISETIEKYERWIVPIVFIGLGIYIL FENGTSNALISF

>Q97PJ0_STRPN [ Q97PJ0_STRPN ] YISTSIDYLIILIILFAQLSQNKQKWHIYAGQYLGTGLLVGASLVAAYVVNFVPEEWMVG LLGLIPIYLGIRFAIVGEDAEEEEEEIIERLEQSKANQLFWTVTLLTIASGGDNLGIYIP YFASLDWSQTLVALLVFVIGIIIFCEISRVLSSIPLIFETIEKYERIIVPLVFILLGLYI MYENGTIETFLIV

>P95773_STALU [ P95773_STALU ] YIAQALDLLVILLMFFARAKTRKEYRDIYIGQYVGSVALIVISLFFAFVLNYVPEKWILG LLGLIPIYLGIKVAIYGDSDGEERAKKELNEKGLSKLVGTIAIVTIASCGADNIGLFVPY FVTLSVTNLLITLFVFLILIFFLVFAAQKLANIPEVGEIVEKFGRWIMAVIYIALGLFII IENDTIQTILGF

Upon reading the sequences Yabby has taken the ﬁrst string in the FASTA comment to be the sequence ID, and the full comment is <nobr>re-inserted</nobr> within the square brackets. In this case the only comment was the ID string, and this is merely repeated within the square brackets.

The command ’print’ can send sequences to a ﬁle, instead of printing them in the terminal window:

yabby> print <nobr>-f</nobr> tmp.fasta cad3.seq

’cad3.seq’ written to the file ’tmp.fasta’

Currently there are several useful options of the ’print’ command. The option <nobr>’-l’</nobr> causes protein sequences to be printed in a <nobr>three-letter</nobr> format:

yabby> print <nobr>-l</nobr> cad3.seq

>Q53650_STAAU

TYR VAL ALA THR GLY ILE ASP TYR LEU VAL ILE LEU ILE LEU LEU PHE SER GLN VAL LYS LYS GLY GLN VAL

....further output deleted....

The option <nobr>’-t</nobr> N’ truncates all sequences at N residues:

yabby> print <nobr>-t</nobr> 10 cad3.seq

>Q53650_STAAU [ Q53650_STAAU ] YVATGIDYLV

>Q97PJ0_STRPN [ Q97PJ0_STRPN ] YISTSIDYLI

>P95773_STALU [ P95773_STALU ] YIAQALDLLV

</div>

<div id="page_23">

<div id="dimg1">![](yabby_images/yabby23x1.jpg)</div>

| 

18

 | 

Chapter 2\. Tutorial

 |

The command ’seq info’ prints additional information about sequence objects:

yabby> seq_info cad3

’cad3’ contains 3 sequence(s)

min number of residues: 192 (sequence ’Q53650_STAAU’) max number of residues: 193 (sequence ’Q97PJ0_STRPN’)

The option <nobr>’-l’</nobr> causes the number of residues to be printed for each sequence:

yabby> seq_info <nobr>-l</nobr> cad3

’cad3’ contains 3 sequence(s)

1 <nobr>-></nobr> Q53650_STAAU, 192 residues

2 <nobr>-></nobr> Q97PJ0_STRPN, 193 residues

3 <nobr>-></nobr> P95773_STALU, 192 residues

It is often required to select one or more sequences from the sequence object. The command ’seq pick’ allows one to select sequences from their order number or sequence ID. For example:

yabby> seq_pick <nobr>-n</nobr> 2 cad3 s2

Fetching the sequence 2 (’Q97PJ0_STRPN’)

Saving the extracted sequence as ’s2’

The above command has picked the sequence number 2 from the ’cad3’ object, and saved this sequence under the name ’s2’:

| 

yabby> what

 |
| 

object(s)

 | 

type

 |
| 

<nobr>------------------------------</nobr>

 |
| 

cad3

 | 

seq

 |
| 

s2

 | 

seq

 |

yabby> print s2.seq

>Q97PJ0_STRPN [ Q97PJ0_STRPN ] YISTSIDYLIILIILFAQLSQNKQKWHIYAGQYLGTGLLVGASLVAAYVVNFVPEEWMVG LLGLIPIYLGIRFAIVGEDAEEEEEEIIERLEQSKANQLFWTVTLLTIASGGDNLGIYIP YFASLDWSQTLVALLVFVIGIIIFCEISRVLSSIPLIFETIEKYERIIVPLVFILLGLYI MYENGTIETFLIV

</div>

<div id="page_24">

<div id="dimg1">![](yabby_images/yabby24x1.jpg)</div>

<div id="id_1">

| 

2.1\. Working with sequences

 | 

19

 |

Another useful option is to select a sequence by its ID string:

yabby> seq_pick <nobr>-q</nobr> Q53650_STAAU cad3 s1

Fetching the sequence ’Q53650_STAAU’

Saving the extracted sequence as ’s1’

| 

yabby> what

 |
| 

object(s)

 | 

type

 |
| 

<nobr>------------------------------</nobr>

 |
| 

cad3

 | 

seq

 |
| 

s1

 | 

seq

 |
| 

s2

 | 

seq

 |

Suppose that we wanted to take the sequence Q53650 STAAU, and extract residues <nobr>21-40.</nobr> The above command would take care of the ﬁrst part, while the command ’seq strip’ could be used to select a residue range:

yabby> seq_strip 21:40 s1 s1_portion

’s1’ contains 1 sequence(s) stripping ’Q53650_STAAU’

yabby> print s1_portion.seq

>Q53650_STAAU_21:40 [ Q53650_STAAU ] KGQVKHIWIGQYIGTAIVIG

The command ’seq pattern’ allows one to search for a pattern in a sequence. For example, to search for a pattern ’IDY’ use:

yabby> seq_pattern IDY cad3

’IDY’ matches in ’Q53650_STAAU’ ’IDY’ matches in ’Q97PJ0_STRPN’

3 sequences examined, 2 match(es) found

The option <nobr>’-s</nobr> NAME’ allows one to save the matching sequences under a the new name:

</div>

<div id="id_2">

yabby> seq_pattern <nobr>-s</nobr> IDY_matches IDY cad3

</div>

</div>

<div id="page_25">

<div id="dimg1">![](yabby_images/yabby25x1.jpg)</div>

| 

20

 | 

Chapter 2\. Tutorial

 |
| 

’IDY’ matches in ’Q53650_STAAU’

 |
| 

’IDY’ matches in ’Q97PJ0_STRPN’

 |
| 

3 sequences examined, 2 match(es) found

 |
| 

Saving matches as ’IDY_matches’

 |
| 

[ seq_pattern: ’IDY_matches.seq’ exists, overwritten ]

 |

The option <nobr>’-c’</nobr> allows one to search the sequence comment for a pattern, rather than the sequence residues:

yabby> seq_pattern <nobr>-c</nobr> STAA cad3

’STAA’ matches in ’Q53650_STAAU’

3 sequences examined, 1 match(es) found

The command ’seq op’ allows one to combine two sequence objects based on their IDs. This command has the following form:

seq_op [ options ] SEQ1_OBJ SEQ2_OBJ RES_OBJ

where SEQ1 OBJ SEQ2 OBJ are two sequence objects to be combined and RES OBJ is the name under which the result will be stored. This command can calculate the union, intersection, symmetric diﬀerence.

For example, consider the sets of sequences stored in ﬁles ’cad.fas’ and ’cad3.fas’, where the ﬁrst ﬁle contains six CAD sequences, and cad3.fas contains three out of six sequences present in ’cad.fas’.

yabby> seq_load cad.fas cad

Reading the file ’cad.fas’ .. 6 sequence(s) found.

yabby> seq_load cad3.fas cad3

Reading the file ’cad3.fas’ .. 3 sequence(s) found.

yabby> seq_op <nobr>-i</nobr> cad cad3 cad_i

Found 6 sequence(s) in ’cad’ Found 3 sequence(s) in ’cad3’

INTERSECTION contains 3 sequence(s) DIFFERENCE contains 3 sequence(s) UNION contains 6 sequence(s)

[ Saving INTERSECTION as ’cad_i’ ]

[ seq_op: ’cad_i.seq’ exists, overwritten ]

</div>

<div id="page_26">

<div id="dimg1">![](yabby_images/yabby26x1.jpg)</div>

<div id="id_1">

| 

2.1\. Working with sequences

 | 

21

 |

The last command has saved the intersection of objects ’cad.seq’ and ’cad3.seq’ as a new sequence object, named ’cad i’. Since ’cad3.seq’ is simply the subset of ’cad.seq’ this intersection is identical to ’cad3.seq’. Options <nobr>’-u’</nobr> and <nobr>’-d’</nobr> save the union and diﬀerence. It should be noted that the command ’seq op’ compares only sequence IDs, <span class="ft2">it does not compare the sequences themselves</span>. Furthermore, unpredictable results may occur if the sequence IDs are not unique within each set of sequences.

The command ’seq comment’ modiﬁes the comment of each sequence to append the sequence number to its ID. To modify the IDs of the sequences in ’cad3’:

yabby> seq_comment cad3

Comments modified in 3 sequence(s).

yabby> print cad3.seq

<nobr>>1-Q53650_STAAU</nobr> [ Q53650_STAAU ] YVATGIDYLVILILLFSQVKKGQVKHIWIGQYIGTAIVIGASLLVAQGVVNLIPQQWVIG LLGLLPLYLGVKIWIKGEEDEDESSILSLFSSGKFNQLFLTMIFIVLASSADDFSIYIPY FTTLSMSEIFIVTIVFLIMVGVLCYVSYRLASFDFISETIEKYERWIVPIVFIGLGIYIL FENGTSNALISF

<nobr>>2-Q97PJ0_STRPN</nobr> [ Q97PJ0_STRPN ] YISTSIDYLIILIILFAQLSQNKQKWHIYAGQYLGTGLLVGASLVAAYVVNFVPEEWMVG LLGLIPIYLGIRFAIVGEDAEEEEEEIIERLEQSKANQLFWTVTLLTIASGGDNLGIYIP YFASLDWSQTLVALLVFVIGIIIFCEISRVLSSIPLIFETIEKYERIIVPLVFILLGLYI MYENGTIETFLIV

<nobr>>3-P95773_STALU</nobr> [ P95773_STALU ] YIAQALDLLVILLMFFARAKTRKEYRDIYIGQYVGSVALIVISLFFAFVLNYVPEKWILG LLGLIPIYLGIKVAIYGDSDGEERAKKELNEKGLSKLVGTIAIVTIASCGADNIGLFVPY FVTLSVTNLLITLFVFLILIFFLVFAAQKLANIPEVGEIVEKFGRWIMAVIYIALGLFII IENDTIQTILGF

Since this command will change the sequence IDs, the output of the command ’seq op’ would be diﬀerent. Speciﬁcally, the intersection of the two sets of sequences would contain no sequences:

yabby> seq_op <nobr>-i</nobr> cad cad3 cad_u

Found 6 sequence(s) in ’cad’ Found 3 sequence(s) in ’cad3’

INTERSECTION contains 0 sequence(s) DIFFERENCE contains 9 sequence(s) UNION contains 9 sequence(s)

[ No sequences to save ]

</div>

<div id="id_2">

yabby> seq_op <nobr>-u</nobr> cad cad3 cad_u

</div>

</div>

<div id="page_27">

<div id="dimg1">![](yabby_images/yabby27x1.jpg)</div>

| 

22

 | 

Chapter 2\. Tutorial

 |

Found 6 sequence(s) in ’cad’ Found 3 sequence(s) in ’cad3’

INTERSECTION contains 0 sequence(s) DIFFERENCE contains 9 sequence(s) UNION contains 9 sequence(s)

[ Saving UNION as ’cad_u’ ]

The command ’seq unique’ ﬁnds sequences present in one set not present in the other, by comparing sequence strings.

yabby> seq_unique cad cad3 cadu

3 unique sequences found. Saving sequences as ’cadu’

Note that in this case the order of sequence objects is important. This command ﬁnd the sequences present in the ﬁrst sequence object and not present in the second, i.e.:

yabby> seq_unique cad3 cad tmp

No unique sequences found.

The command ’seq compl’ calculates the reverse complement of a DNA sequence:

yabby> seq_load dna.fas dna

Reading the file ’dna.fas’ .. 1 sequence(s) found.

yabby> print dna.seq

>chr01 [ chr01 ] taaccctaaccctaaccctgaccctaaccctaaccctaaccctaaccctaaccagtacac gcgtacacgtacaagcacccgtacccccagtatacttggacacccgtactcagttatcct ttttattagtgtacccgcctcttgcacgcatgccacagttcttcagcagaagaacacgca caatgctctttgataaacgtgcggacatgaaaaaaagggaaaaacgcagctacgtgtgct gtcgttggtttcacagcgtcaagccgcgtcggtgtaccaaagaggaggtgacccatcgag

yabby> seq_compl dna dna_c

’dna’ contains 1 sequence(s) Working on ’chr01’

</div>

<div id="page_28">

<div id="dimg1">![](yabby_images/yabby28x1.jpg)</div>

| 

2.1\. Working with sequences

 | 

23

 |

yabby> print dna_c.seq

>chr01 [ chr01 ] attgggattgggattgggactgggattgggattgggattgggattgggattggtcatgtg cgcatgtgcatgttcgtgggcatgggggtcatatgaacctgtgggcatgagtcaatagga aaaataatcacatgggcggagaacgtgcgtacggtgtcaagaagtcgtcttcttgtgcgt gttacgagaaactatttgcacgcctgtactttttttccctttttgcgtcgatgcacacga cagcaaccaaagtgtcgcagttcggcgcagccacatggtttctcctccactgggtagctc

The option <nobr>’-r’</nobr> calculates the reverse complement:

yabby> seq_compl <nobr>-r</nobr> dna dna_cr

’dna’ contains 1 sequence(s) Working on ’chr01’

yabby> print dna_cr.seq

>chr01 [ chr01 ] ctcgatgggtcacctcctctttggtacaccgacgcggcttgacgctgtgaaaccaacgac agcacacgtagctgcgtttttccctttttttcatgtccgcacgtttatcaaagagcattg tgcgtgttcttctgctgaagaactgtggcatgcgtgcaagaggcgggtacactaataaaa aggataactgagtacgggtgtccaagtatactgggggtacgggtgcttgtacgtgtacgc gtgtactggttagggttagggttagggttagggttagggtcagggttagggttagggtta

The command ’seq genbank’ fetches a sequence from GenBank by default using the sequence accession number:

yabby> seq_genbank <nobr>-a</nobr> J00522 mig

Saving ’J00522’ as ’mig’

yabby> what

object(s) type

<nobr>------------------------------</nobr>

mig seq

This command requires the module Bio::DB::GenBank and illustrates how BioPerl [1] can be used within Yabby.

The command ’seq os’ inserts additional information into sequence comments, where additional informa- tion is read from an external ﬁle. For example, the ﬁle ’sprot test.dat.os’ contains the list of sequences IDs and associated organism names, one line per sequence:

</div>

<div id="page_29">

<div id="dimg1">![](yabby_images/yabby29x1.jpg)</div>

| 

24

 | 

Chapter 2\. Tutorial

 |

104K_THEAN Theileria annulata.

104K_THEPA Theileria parva.

108_SOLLC Solanum lycopersicum (Tomato) (Lycopersicon esculentum). 10KD_VIGUN Vigna unguiculata (Cowpea).

110KD_PLAKN Plasmodium knowlesi.

11S2_SESIN Sesamum indicum (Oriental sesame) (Gingelly).

11S3_HELAN Helianthus annuus (Common sunflower). 11SB_CUCMA Cucurbita maxima (Pumpkin) (Winter squash). 128UP_DROME Drosophila melanogaster (Fruit fly). 12AH_CLOS4 Clostridium sp. (strain C <nobr>48-50).</nobr> 12KD_FRAAN Fragaria ananassa (Strawberry).

12KD_MYCSM Mycobacterium smegmatis.

12S1_ARATH Arabidopsis thaliana <nobr>(Mouse-ear</nobr> cress). 12S2_ARATH Arabidopsis thaliana <nobr>(Mouse-ear</nobr> cress). 12S_PROFR Propionibacterium freudenreichii subsp. shermanii.

13KDA_SCYCA Scyliorhinus canicula (Spotted dogfish) (Spotted catshark). 13KDA_TRISC Triakis scyllium (Leopard shark) (Triakis scyllia). 13S1_FAGES Fagopyrum esculentum (Common buckwheat).

The command ’seq os’ could be used to insert the organism name in the sequence object comments by using the ﬁle listed above. To illustrate this, we ﬁrst load the test set of sequences:

yabby> seq_load sprot_test.fas test

Reading the file ’sprot_test.fas’ .. 3 sequence(s) found.

yabby> print test.seq

>104K_THEPA [ 104K_THEPA 104 kDa microneme/rhoptry antigen precursor (p104) ] MKFLILLFNILCLFPVLAADNHGVGPQGASGVDPITFDINSNQTGPAFLTAVEMAGVKYL QVQHGSNVNIHRLVEGNVVIWENASTPLYTGAIVTNNDGPYMAYVEVLGDPNLQFFIKSG DAWVTLSEHEYLAKLQEIRQAVHIESVFSLNMAFQLENNKYEVETHAKNGANMVTFIPRN GHICKMVYHKNVRIYKATGNDTVTSVVGFFRGLRLLLINVFSIDDNGMMSNRYFQHVDDK YVPISQKNYETGIVKLKDYKHAYHPVDLDIKDIDYTMFHLADATYHEPCFKIIPNTGFCI TKLFDGDQVLYESFNPLIHCINEVHIYDRNNGSIICLHLNYSPPSYKAYLVLKDTGWEAT THPLLEEKIEELQDQRACELDVNFISDKDLYVAALTNADLNYTMVTPRPHRDVIRVSDGS EVLWYYEGLDNFLVCAWIYVSDGVASLVHLRIKDRIPANNDIYVLKGDLYWTRITKIQFT QEIKRLVKKSKKKLAPITEEDSDKHDEPPEGPGASGLPPKAPGDKEGSEGHKGPSKGSDS SKEGKKPGSGKKPGPAREHKPSKIPTLSKKPSGPKDPKHPRDPKEPRKSKSPRTASPTRR PSPKLPQLSKLPKSTSPRSPPPPTRPSSPERPEGTKIIKTSKPPSPKPPFDPSFKEKFYD DYSKAASRSKETKTTVVLDESFESILKETLPETPGTPFTTPRPVPPKRPRTPESPFEPPK DPDSPSTSPSEFFTPPESKRTRFHETPADTPLPDVTAELFKEPDVTAETKSPDEAMKRPR SPSEYEDTSPGDYPSLPMKRHRLERLRLTTTEMETDPGRMAKDASGKPVKLKRSKSFDDL

</div>

<div id="page_30">

<div id="dimg1">![](yabby_images/yabby30x1.jpg)</div>

| 

2.1\. Working with sequences

 | 

25

 |

TTVELAPEPKASRIVVDDEGTEADDEETHPPEERQKTEVRRRRPPKKPSKSPRPSKPKKP KKPDSAYIPSILAILVVSLIVGIL

>110KD_PLAKN [ 110KD_PLAKN 110 kDa antigen (PK110) (Fragment) ] FNSNMLRGSVCEEDVSLMTSIDNMIEEIDFYEKEIYKGSHSGGVIKGMDYDLEDDENDED EMTEQMVEEVADHITQDMIDEVAHHVLDNITHDMAHMEEIVHGLSGDVTQIKEIVQKVNV AVEKVKHIVETEETQKTVEPEQIEETQNTVEPEQTEETQKTVEPEQTEETQNTVEPEQIE ETQKTVEPEQTEEAQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTE ETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQNTVEPEPTQETQNTVEP >12KD_FRAAN [ 12KD_FRAAN <nobr>Auxin-repressed</nobr> 12.5 kDa protein. ] MVLLDKLWDDIVAGPQPERGLGMLRKVPQPLNLKDEGESSKITMPTTPTTPVTPTTPISA RKDNVWRSVFHPGSNLSSKTMGNQVFDSPQPNSPTVYDWMYSGETRSKHHR

The command ’seq os’ takes two arguments, the ﬁle name with sequence IDs and additional information (see above), and the sequence object name:

yabby> seq_os sprot_test.dat.os test

Reading the file ’sprot_test.dat.os’ ...

3 sequences to process.

All done.

[ seq_os: ’test.seq’ exists, overwritten ]

The original sequence object was overwritten, but the diﬀerence is only in that the comments are changed to contain the information provided in the ﬁle ’sprot test.dat.os’:

yabby> print test.seq

>104K_THEPA [ 104K_THEPA 104 kDa microneme/rhoptry antigen

... precursor (p104) Theileria parva. ] MKFLILLFNILCLFPVLAADNHGVGPQGASGVDPITFDINSNQTGPAFLTAVEMAGVKYL QVQHGSNVNIHRLVEGNVVIWENASTPLYTGAIVTNNDGPYMAYVEVLGDPNLQFFIKSG DAWVTLSEHEYLAKLQEIRQAVHIESVFSLNMAFQLENNKYEVETHAKNGANMVTFIPRN GHICKMVYHKNVRIYKATGNDTVTSVVGFFRGLRLLLINVFSIDDNGMMSNRYFQHVDDK YVPISQKNYETGIVKLKDYKHAYHPVDLDIKDIDYTMFHLADATYHEPCFKIIPNTGFCI TKLFDGDQVLYESFNPLIHCINEVHIYDRNNGSIICLHLNYSPPSYKAYLVLKDTGWEAT THPLLEEKIEELQDQRACELDVNFISDKDLYVAALTNADLNYTMVTPRPHRDVIRVSDGS EVLWYYEGLDNFLVCAWIYVSDGVASLVHLRIKDRIPANNDIYVLKGDLYWTRITKIQFT QEIKRLVKKSKKKLAPITEEDSDKHDEPPEGPGASGLPPKAPGDKEGSEGHKGPSKGSDS SKEGKKPGSGKKPGPAREHKPSKIPTLSKKPSGPKDPKHPRDPKEPRKSKSPRTASPTRR PSPKLPQLSKLPKSTSPRSPPPPTRPSSPERPEGTKIIKTSKPPSPKPPFDPSFKEKFYD DYSKAASRSKETKTTVVLDESFESILKETLPETPGTPFTTPRPVPPKRPRTPESPFEPPK

</div>

<div id="page_31">

<div id="dimg1">![](yabby_images/yabby31x1.jpg)</div>

| 

26

 | 

Chapter 2\. Tutorial

 |

DPDSPSTSPSEFFTPPESKRTRFHETPADTPLPDVTAELFKEPDVTAETKSPDEAMKRPR SPSEYEDTSPGDYPSLPMKRHRLERLRLTTTEMETDPGRMAKDASGKPVKLKRSKSFDDL TTVELAPEPKASRIVVDDEGTEADDEETHPPEERQKTEVRRRRPPKKPSKSPRPSKPKKP KKPDSAYIPSILAILVVSLIVGIL

>110KD_PLAKN [ 110KD_PLAKN 110 kDa antigen (PK110) (Fragment)

... Plasmodium knowlesi. ] FNSNMLRGSVCEEDVSLMTSIDNMIEEIDFYEKEIYKGSHSGGVIKGMDYDLEDDENDED EMTEQMVEEVADHITQDMIDEVAHHVLDNITHDMAHMEEIVHGLSGDVTQIKEIVQKVNV AVEKVKHIVETEETQKTVEPEQIEETQNTVEPEQTEETQKTVEPEQTEETQNTVEPEQIE ETQKTVEPEQTEEAQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTE ETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQNTVEPEPTQETQNTVEP >12KD_FRAAN [ 12KD_FRAAN <nobr>Auxin-repressed</nobr> 12.5 kDa protein.

... Fragaria ananassa (Strawberry). ] MVLLDKLWDDIVAGPQPERGLGMLRKVPQPLNLKDEGESSKITMPTTPTTPVTPTTPISA RKDNVWRSVFHPGSNLSSKTMGNQVFDSPQPNSPTVYDWMYSGETRSKHHRim}

<span class="ft21">2.1.1</span><nobr><span class="ft22">Swiss-Prot</span></nobr> related commands

Several commands exist for the manipulation of <nobr>Swiss-Prot</nobr> data ﬁles.

The command ’sprot fetch’ fetches a single sequence from the <nobr>Swiss-Prot</nobr> data ﬁle based on the sequence unique ID. For example, the <nobr>Swiss-Prot</nobr> ﬁle ’sprot test.dat’ contains 18 sequences, including the sequence with the ID ’110KD PLAKN’. The command ’sprot fetch’ could be used to extract this sequence from the database ﬁle:

yabby> sprot_fetch sprot_test.dat 110KD_PLAKN plakn

Sequence ’110KD_PLAKN’ found. [ Saving as ’plakn.seq’ ]

yabby> print plakn.seq

>110KD_PLAKN [ 110 kDa antigen (PK110) (Fragment). Plasmodium knowlesi. ] FNSNMLRGSVCEEDVSLMTSIDNMIEEIDFYEKEIYKGSHSGGVIKGMDYDLEDDENDED EMTEQMVEEVADHITQDMIDEVAHHVLDNITHDMAHMEEIVHGLSGDVTQIKEIVQKVNV AVEKVKHIVETEETQKTVEPEQIEETQNTVEPEQTEETQKTVEPEQTEETQNTVEPEQIE ETQKTVEPEQTEEAQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTE ETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQNTVEPEPTQETQNTVEP

The command ’seq sprot os’ fetches the organism name from the <nobr>Swiss-Prot</nobr> data ﬁle <nobr>(Swiss-Prot</nobr> ﬁeld ”OS”) for a set of sequences saved in the workspace. This is useful when the organism name is lost in the sequence manipulation pipeline. For example, when the <nobr>Swiss-Prot</nobr> database is convereted into the

</div>

<div id="page_32">

<div id="dimg1">![](yabby_images/yabby32x1.jpg)</div>

| 

2.1\. Working with sequences

 | 

27

 |

FASTA format with the program ”sreformat” from the Sean Eddy’s SQUID toolkit, the organism names are not copied to the FASTA ﬁle.

The command ’seq sprot os’ requires two arguments, the name of the <nobr>Swiss-Prot</nobr> database ﬁle and the name of an existing sequence object. To illustrate this, we ﬁrst load the test set of sequences (’sprot test.fas’) in the workspace, under the name ’test’:

yabby> seq_load sprot_test.fas test

Reading the file ’sprot_test.fas’ .. 3 sequence(s) found.

yabby> print test.seq

>104K_THEPA [ 104K_THEPA 104 kDa microneme/rhoptry antigen precursor (p104) ] MKFLILLFNILCLFPVLAADNHGVGPQGASGVDPITFDINSNQTGPAFLTAVEMAGVKYL QVQHGSNVNIHRLVEGNVVIWENASTPLYTGAIVTNNDGPYMAYVEVLGDPNLQFFIKSG DAWVTLSEHEYLAKLQEIRQAVHIESVFSLNMAFQLENNKYEVETHAKNGANMVTFIPRN GHICKMVYHKNVRIYKATGNDTVTSVVGFFRGLRLLLINVFSIDDNGMMSNRYFQHVDDK YVPISQKNYETGIVKLKDYKHAYHPVDLDIKDIDYTMFHLADATYHEPCFKIIPNTGFCI TKLFDGDQVLYESFNPLIHCINEVHIYDRNNGSIICLHLNYSPPSYKAYLVLKDTGWEAT THPLLEEKIEELQDQRACELDVNFISDKDLYVAALTNADLNYTMVTPRPHRDVIRVSDGS EVLWYYEGLDNFLVCAWIYVSDGVASLVHLRIKDRIPANNDIYVLKGDLYWTRITKIQFT QEIKRLVKKSKKKLAPITEEDSDKHDEPPEGPGASGLPPKAPGDKEGSEGHKGPSKGSDS SKEGKKPGSGKKPGPAREHKPSKIPTLSKKPSGPKDPKHPRDPKEPRKSKSPRTASPTRR PSPKLPQLSKLPKSTSPRSPPPPTRPSSPERPEGTKIIKTSKPPSPKPPFDPSFKEKFYD DYSKAASRSKETKTTVVLDESFESILKETLPETPGTPFTTPRPVPPKRPRTPESPFEPPK DPDSPSTSPSEFFTPPESKRTRFHETPADTPLPDVTAELFKEPDVTAETKSPDEAMKRPR SPSEYEDTSPGDYPSLPMKRHRLERLRLTTTEMETDPGRMAKDASGKPVKLKRSKSFDDL TTVELAPEPKASRIVVDDEGTEADDEETHPPEERQKTEVRRRRPPKKPSKSPRPSKPKKP KKPDSAYIPSILAILVVSLIVGIL

>110KD_PLAKN [ 110KD_PLAKN 110 kDa antigen (PK110) (Fragment) ] FNSNMLRGSVCEEDVSLMTSIDNMIEEIDFYEKEIYKGSHSGGVIKGMDYDLEDDENDED EMTEQMVEEVADHITQDMIDEVAHHVLDNITHDMAHMEEIVHGLSGDVTQIKEIVQKVNV AVEKVKHIVETEETQKTVEPEQIEETQNTVEPEQTEETQKTVEPEQTEETQNTVEPEQIE ETQKTVEPEQTEEAQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTE ETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQNTVEPEPTQETQNTVEP >12KD_FRAAN [ 12KD_FRAAN <nobr>Auxin-repressed</nobr> 12.5 kDa protein. ] MVLLDKLWDDIVAGPQPERGLGMLRKVPQPLNLKDEGESSKITMPTTPTTPVTPTTPISA RKDNVWRSVFHPGSNLSSKTMGNQVFDSPQPNSPTVYDWMYSGETRSKHHR

The <nobr>Swiss-Prot</nobr> example ﬁle ’sprot test.dat’ contains 18 sequences which include the tree from the ﬁle ’sprot test.fas’. The command ’seq sprot os’ could be used to fetch the OS ﬁeld from the <nobr>Swiss-Prot</nobr> ﬁle, and insert this in the sequence comment:

</div>

<div id="page_33">

<div id="id_1">

| 

28

 | 

Chapter 2\. Tutorial

 |

yabby> seq_sprot_os sprot_test.dat test

3 sequences to process.

Printing dot per processed sequence:

...

All done.

[ seq_sprot_os: ’test.seq’ exists, overwritten ]

This manipulation has happened in place, and the original sequence object was overwritten. the diﬀerence is of course only in the comment ﬁeld:

yabby> print test.seq

>104K_THEPA [ 104K_THEPA 104 kDa microneme/rhoptry antigen precursor

... (p104) Theileria parva. ] MKFLILLFNILCLFPVLAADNHGVGPQGASGVDPITFDINSNQTGPAFLTAVEMAGVKYL QVQHGSNVNIHRLVEGNVVIWENASTPLYTGAIVTNNDGPYMAYVEVLGDPNLQFFIKSG DAWVTLSEHEYLAKLQEIRQAVHIESVFSLNMAFQLENNKYEVETHAKNGANMVTFIPRN GHICKMVYHKNVRIYKATGNDTVTSVVGFFRGLRLLLINVFSIDDNGMMSNRYFQHVDDK YVPISQKNYETGIVKLKDYKHAYHPVDLDIKDIDYTMFHLADATYHEPCFKIIPNTGFCI TKLFDGDQVLYESFNPLIHCINEVHIYDRNNGSIICLHLNYSPPSYKAYLVLKDTGWEAT THPLLEEKIEELQDQRACELDVNFISDKDLYVAALTNADLNYTMVTPRPHRDVIRVSDGS EVLWYYEGLDNFLVCAWIYVSDGVASLVHLRIKDRIPANNDIYVLKGDLYWTRITKIQFT QEIKRLVKKSKKKLAPITEEDSDKHDEPPEGPGASGLPPKAPGDKEGSEGHKGPSKGSDS SKEGKKPGSGKKPGPAREHKPSKIPTLSKKPSGPKDPKHPRDPKEPRKSKSPRTASPTRR PSPKLPQLSKLPKSTSPRSPPPPTRPSSPERPEGTKIIKTSKPPSPKPPFDPSFKEKFYD DYSKAASRSKETKTTVVLDESFESILKETLPETPGTPFTTPRPVPPKRPRTPESPFEPPK DPDSPSTSPSEFFTPPESKRTRFHETPADTPLPDVTAELFKEPDVTAETKSPDEAMKRPR SPSEYEDTSPGDYPSLPMKRHRLERLRLTTTEMETDPGRMAKDASGKPVKLKRSKSFDDL TTVELAPEPKASRIVVDDEGTEADDEETHPPEERQKTEVRRRRPPKKPSKSPRPSKPKKP KKPDSAYIPSILAILVVSLIVGIL

>110KD_PLAKN [ 110KD_PLAKN 110 kDa antigen (PK110) (Fragment)

... Plasmodium knowlesi. ] FNSNMLRGSVCEEDVSLMTSIDNMIEEIDFYEKEIYKGSHSGGVIKGMDYDLEDDENDED EMTEQMVEEVADHITQDMIDEVAHHVLDNITHDMAHMEEIVHGLSGDVTQIKEIVQKVNV AVEKVKHIVETEETQKTVEPEQIEETQNTVEPEQTEETQKTVEPEQTEETQNTVEPEQIE ETQKTVEPEQTEEAQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTE ETQKTVEPEQTEETQKTVEPEQTEETQKTVEPEQTEETQNTVEPEPTQETQNTVEP >12KD_FRAAN [ 12KD_FRAAN <nobr>Auxin-repressed</nobr> 12.5 kDa protein.

... Fragaria ananassa (Strawberry). ] MVLLDKLWDDIVAGPQPERGLGMLRKVPQPLNLKDEGESSKITMPTTPTTPVTPTTPISA RKDNVWRSVFHPGSNLSSKTMGNQVFDSPQPNSPTVYDWMYSGETRSKHHR

</div>

<div id="id_2">

Note that all sequences from the sequence object must be present in the <nobr>Swiss-Prot</nobr> data ﬁle, or this

</div>

</div>

<div id="page_34">

<div id="dimg1">![](yabby_images/yabby34x1.jpg)</div>

| 

2.1\. Working with sequences

 | 

29

 |

command will fail (in the example above, all sequences from the ’test.seq’ object must be present in the ﬁle ’sprot test.dat’). On the other hand, the <nobr>Swiss-Prot</nobr> ﬁle can contain additional sequences. The sequences are searched by the sequence ID.

The usability of commands ’sprot fetch’ and ’seq sprot os’ is limited if the <nobr>Swiss-Prot</nobr> ﬁle is large and/or the sequence object is large. For example, the UniProt release 12.4 <nobr>(23-Oct-2007)</nobr> contains 5,275,429 se- quences, and the combined <nobr>Swiss-Prot</nobr> ﬁle is approx 13 Gb in size <nobr>(swiss-prot</nobr> + TrEMBL). The command ’seq sprot os’ cannot cope well with the ﬁle of this size.

Consider for example a sequence object Omp85 with 1,000 sequences, which was derived in some way from the UniProt database (for example, the list of hits from the hidden Markov model search of the combined UniProt data ﬁle). To associate organism names with the Omp85 sequences, one would need to search the entire UniProt for each of the 1,000 sequences in the Omp85\. The command ’seq sprot os’ is not optimized to cope with such a large computational task. However, this task can be accomplished in two steps, by using the commands ’sprot os’ and ’seq os’. First, the command ’sprot os’ can be used to extract the organism names from the UniProt ﬁle:

yabby> sprot_os uniprot.dat uniprot.dat.os

Processing the database file ’uniprot.dat’ ..

Printing a dot per 10000 processed sequences:

............................................................

............................................................

............................................................

............................................................

............................................................

............................................................

............................................................

............................................................

...............................................

All done.

In the above example, ’uniprot.dat’ is the combined UniProt data ﬁle <nobr>(swiss-prot</nobr> + TrEMBL) in the <nobr>Swiss-Prot</nobr> format. The organism names are saved in the ﬁle ’uniprot.dat.os’. This ﬁle lists sequence IDs and the ﬁrst OS ﬁeld as given in the <nobr>Swiss-Prot</nobr> ﬁle, one line per sequence:

A0AQI4_9ARCH uncultured archaeon.

A0AQI5_9ARCH uncultured archaeon.

A0AQI7_9ARCH uncultured archaeon.

A0AQI8_9ARCH uncultured archaeon.

A0B530_METTP Methanosaeta thermophila (strain DSM 6194 / PT)

A0B531_METTP Methanosaeta thermophila (strain DSM 6194 / PT)

A0B532_METTP Methanosaeta thermophila (strain DSM 6194 / PT)

A0B533_METTP Methanosaeta thermophila (strain DSM 6194 / PT)

</div>

<div id="page_35">

<div id="dimg1">![](yabby_images/yabby35x1.jpg)</div>

<div id="id_1">

| 

30

 | 

Chapter 2\. Tutorial

 |

A0B534_METTP Methanosaeta thermophila (strain DSM 6194 / PT) A0B535_METTP Methanosaeta thermophila (strain DSM 6194 / PT)

...

The command ’seq os’ (explained above) can be used to insert the organism names in the sequence object, by using the intermendiate ﬁle created by the command ’sprot os’:

yabby> seq_os uniprot.dat.os Omp85

Reading the file ’uniprot.dat.os’ ...

1000 sequences to process.

All done.

[ seq_os: ’Omp85.seq’ exists, overwritten ]

Similarly as with the command ’sprot test.dat’, the insertion of comments was in place, and the sequence object ’Omp85.seq’ was overwritten.

<span class="ft16">2.2</span><span class="ft17">Housekeeping commands</span>

Several commands are dedicated to the general manipulation of Yabby objects. These include ’what’ and ’print’, and already seen ’help, ’dump’, ’restore’, ’delete’, ’ﬂush’, ’license’, ’exit’ and ’quit’.

The ’help’ command is probably the most useful. By itself it prints the list of currently available com- mands:

yabby> help

39 commands ready.

| 

blast

 | 

blast_info

 | 

blastg

 | 

delete

 |
| 

dump

 | 

emboss_needle

 | 

exit

 | 

flush

 |
| 

help

 | 

hmm_score2seq

 | 

hmm_score_extract license

 |
| 

mol2seq

 | 

mol_crd

 | 

mol_load

 | 

motif_cmp

 |
| 

motif_load

 | 

motif_meme

 | 

pdb_conv

 | 

pdb_model

 |
| 

pfam_fetch

 | 

print

 | 

quit

 | 

restore

 |
| 

seq2id

 | 

seq_comment

 | 

seq_compl

 | 

seq_genbank

 |
| 

seq_info

 | 

seq_letter

 | 

seq_letterc

 | 

seq_load

 |
| 

seq_op

 | 

seq_pattern

 | 

seq_pick

 | 

seq_strip

 |
| 

seq_unique

 | 

sprot_split

 | 

what

 |

</div>

<div id="id_2">

For info about a particular command try: ’help COMMAND’

</div>

</div>

<div id="page_36">

| 

2.2\. Housekeeping commands

 | 

31

 |

If followed by a command name, it prints the information about the command:

yabby> help seq_load

Loads sequence(s) from the database file.

Usage:

seq_load [ options ] DBA_FILE OBJ_NAME

Where DBA_FILE is the name of the database file. OBJ_NAME is the internal Yabby name for the sequence(s).

Options:

<nobr>-a</nobr> <nobr>--</nobr> append sequences to an already existing sequence object OBJ_NAME

<nobr>-f</nobr> <nobr>--</nobr> the file format is FASTA (default) <nobr>-b</nobr> <nobr>--</nobr> the file format is BLOCKS

Notes:

1\. Only BLOCKS format as given by MEME output was tested.

The command ’delete’ deletes an object, and the command ’ﬂush’ deletes all objects from the workspace:

| 

yabby> what

 |
| 

object(s)

 | 

type

 |
| 

<nobr>------------------------------</nobr>

 |
| 

hits

 | 

seq

 |

hmm_score

 |

yabby> delete hits.seq

[ ’hits.seq’ deleted ]

yabby> flush

[ workspace flushed ]

yabby> what

object(s) type

<nobr>------------------------------</nobr>

</div>

<div id="page_37">

| 

32

 | 

Chapter 2\. Tutorial

 |

[ none ]

The command ’dump’ stores the session onto a ﬁle:

yabby> dump mysession

Yabby session archived as ’mysession.tar.gz’

The session can be restored with the command ’restore’:

yabby> restore mysession

Yabby session ’mysession’ restored

Note that the commands ’dump’/’restore’ depend on unix commands ’tar’ and ’gzip’ being available for execution by Perl.

<span class="ft16">2.3</span><span class="ft17">Working with sequence motifs</span>

Sequence motifs are handled as ’motif’ objects. Motifs could be loaded from FASTA ﬁles, or from BLOCKS ﬁles:

yabby> motif_load <nobr>-b</nobr> m2.blocks m2

Reading the file ’m2.blocks’ ..

11 sequence(s) found in the motif ’m2’.

| 

Motifs can be printed:

 |
| 

yabby> what

 |
| 

object(s)

 | 

type

 |
| 

<nobr>------------------------------</nobr>

 |
| 

m2

 | 

motif

 |

yabby> print m2.motif

>Sthermophile [ from BLOCKS file ’m2.blocks’ ] PMAESGVTIRSDSEQYSRHEEQSVSPPSSSS

>Panserina [ from BLOCKS file ’m2.blocks’ ] PMAESGVTIRSDSEQYSSPEELSTSPPSSSS

</div>

<div id="page_38">

<div id="dimg1">![](yabby_images/yabby38x1.jpg)</div>

<div id="id_1">

| 

2.3\. Working with sequence motifs

 | 

33

 |

>Cglobosum [ from BLOCKS file ’m2.blocks’ ] PMAESGITIPSDSEQYSRHGDQSTSPPSSSS

>Ncrassa [ from BLOCKS file ’m2.blocks’ ] PLAESGVTISSDSEQYSAPESASPQSPSSSS

>Oclavigerum [ from BLOCKS file ’m2.blocks’ ] PMAESGVTMHSDSEQYSGAEELSASLESSHS

>Afumigatus [ from BLOCKS file ’m2.blocks’ ] ELYDSGLTVPSDSEIYSANHEVSSPMSASSS

>Gzea [ from BLOCKS file ’m2.blocks’ ] HLAESGVTMHSDIELYSAGDDLSSPPSSNSP

>Aoryzae [ from BLOCKS file ’m2.blocks’ ] ELYESGLTVRSDSENYSANNELSESTSSSPL

>Tlanuginosus [ from BLOCKS file ’m2.blocks’ ] ELSDSALTVPSDSENYSANNEFSSSPSASNS

>Pnodorum [ from BLOCKS file ’m2.blocks’ ] PLTASGLTIPTDSESYSAPADSPSPSPPSSS

>Apullulans [ from BLOCKS file ’m2.blocks’ ] RDIYDSMTMQSDSETYDQPDISSPSSPSSDS

The command ’motif cmp’ compares two motifs. Two motifs are identical if they have the same number of sequences, the sequences have the same ID, and the sequences themselves are identical as strings:

yabby> motif_cmp m2 m2_second

Motifs ’m2’ and ’m2_second’ contain the same sequence IDs.

Comparing the sequences...

Motifs ’m2’ and ’m2_second’ are identical.

The command ’motif meme’ extracts the motifs from the plain text output of the motif detection program MEME [2]. To extract the motif 1 from the ﬁle ’meme.out’ use:

yabby> motif_meme meme.out 1 m1

Reading MEME output ’meme.out’ ..

Motif 1 saved as ’m1’.

yabby> what

object(s) type

<nobr>------------------------------</nobr>

m1 motif

</div>

<div id="id_2">

In the internal representation ’motif’ type object is identical to the ’seq’ type object.

</div>

</div>

<div id="page_39">

<div id="dimg1">![](yabby_images/yabby39x1.jpg)</div>

| 

34

 | 

Chapter 2\. Tutorial

 |

<span class="ft16">2.4</span><span class="ft17">Working with the HMMER output</span>

HMMER is a powerful software for the proﬁle hidden Markov model search of sequence databases [3, 4]. The ’search step’ in HMMER search pipeline is performed by the program HMMPFAM which is a part of the HMMER software suite. Yabby’s commands ’hmm score extract’ and ’hmm score2seq’ can aid in the extraction of the search results from the HMMPFAM output ﬁles.

As an example, consider the HMMPFAM search performed on the genome sequence ’LmjFmockup.pep’. The output of this search was redirected to the ﬁle ’hmmpfam.out’. To extract the hits with the <nobr>E-value</nobr> above 0.01, and store these hits under the name ’hits’:

yabby> hmm_score_extract <nobr>-E</nobr> 0.01 <nobr>-s</nobr> hits hmmpfam.out

Processing HMMPFAM search output file

No Sequence <nobr>E-score</nobr>

<nobr>-----------------------------------------------------</nobr>

| 

(

 | 

1)

 | 

LmjF05.1190@All

 | 

<nobr>2.70e-03</nobr>

 |
| 

(

 | 

2)

 | 

LmjF05.1190@GlycogenStarch

 | 

<nobr>4.20e-03</nobr>

 |
| 

(

 | 

3)

 | 

LmjF05.0920@All

 | 

<nobr>7.50e-03</nobr>

 |
| 

yabby> what

 |

object(s)

 | 

type

 |

<nobr>------------------------------</nobr>

 |

hits

 | 

hmm_score

 |

The command ’hmm score extract’ with the <nobr>’-s</nobr> hits’ ﬂag has created the object of the type ’hmm score’ in the workspace. This is merely a list containing the sequence name, the model the hit was recorded to, and the <nobr>E-value:</nobr>

LmjF05.1190@All 0.0027

LmjF05.1190@GlycogenStarch 0.0042

LmjF05.0920@All 0.0075

To get to the actual sequences, one needs to go to the original sequence database on which the HMMPFAM search was executed, match the sequence IDs, and extract the sequences. This can be achieved with the command ’hmm score2seq’

yabby> hmm_score2seq LmjFmockup.pep hits.fas hits

found 3 sequences to extract

Processing the database ’LmjFmockup.pep’ Sequences written to ’hits.fas’

</div>

<div id="page_40">

<div id="dimg1">![](yabby_images/yabby40x1.jpg)</div>

| 

2.5\. Running NCBI BLAST from Yabby

 | 

35

 |

This command takes the name of the sequence database on which the search was executed (LmjF- mockup.pep), the name of the output ﬁle where sequence are to be saved (hits.fas), and the name of the Yabby ’hmm score’ object where the hits were extracted.

The output ﬁle contains sequence hits in the FASTA format, which can be loaded and manipulated with sequence commands:

yabby> seq_load hits.fas hits

Reading the file ’hits.fas’ .. 3 sequence(s) found.

yabby> print hits.seq

>LmjF05.1190@All [ LmjF05.1190@All [ (score: <nobr>2.70e-03,</nobr> model: All) MSNKKQTWANAHSQLWTSSVARSAGSRTQSEVSSIASTNRDRSLLDDGDGYHQPPSHVCA QELRHQAYQPNDKTLAQVSDILESYGAIACDADIPAVLLEVVKELERTKRDNNFKDLLLR EYSDTVQRRFGLYGEESPPSIAEVSARLRDGAPARPVAAPNPAWLEQPLNELWRTVCDGM QACFEKNADLSAPVLLPEARRTKANVSQLLHTSCDVLSQLAKEYTTAKAAVMKKMERTVA ASQSFRQLTLSTALSELEAQQELKGSAAEDGGASAMDGSHTVGSALQSLIDVIPASLQIH

.... extra output deleted ....

<span class="ft16">2.5</span><span class="ft17">Running NCBI BLAST from Yabby</span>

BLAST (Basic Local Alignment Search Tool) refers to a heuristic algorithm widely used to ﬁnd regions of similarity between protein/DNA sequences. BLAST is often used to denote the computer program, an actual implementation of the BLAST algorithm. Two such implementations are in wide use: NCBI BLAST and <nobr>WU-BLAST</nobr> (from the Washington University). In addition, the term BLAST is often used to denote the Web interface for blast search, such as the one provided by NCBI [5].

It is generally less known that NCBI BLAST executables can be downloaded [6] and run locally, which has some distinct advantages. The Yabby command ’blast’ allows one to run NCBI BLAST search locally, through the Yabby interface.

The command ’blast’ depends on NCBI BLAST being installed locally. The location of the NCBI BLAST installation is set in the Yabby library ’yabby blast.pm’:

$BLASTALL = "/usr/local/bin/blastall";

For NCBI BLAST to work one also needs to set up the ﬁle ’.ncbirc’ in the user’s home directory that will give the location of blast data ﬁles (such as substitution matrices):

[NCBI]

Data=/usr/local/blast/2.2.9/data

</div>

<div id="page_41">

<div id="id_1">

| 

36

 | 

Chapter 2\. Tutorial

 |

The database to be searched need ﬁrst to be indexed for BLAST search with the program ’formatdb’ which is provided in the NCBI BLAST package. For example, to format the database ’LmjFwholegenome.pep’ (L.major genome in FASTA fomat),

$ /usr/local/bin/formatdb <nobr>-i</nobr> LmjFwholegenome.pep <nobr>-p</nobr> T <nobr>-o</nobr> T

This would create several additional ﬁles in the same directory, such as ’LmjFwholegenome.pep.phr’, ’LmjFwholegenome.pep.psq’ etc.

Yabby can execute BLAST search against multiple sequences. For example, to BLAST six sequences from the ﬁle ’cad.fas’:

yabby> seq_load cad.fas cad

Reading the file ’cad.fas’ .. 6 sequence(s) found.

yabby> blast <nobr>-E</nobr> 5.0 tmp/LmjFwholegenome_20050601_V5.2.pep cad

6 sequence(s) found in the object ’cad’

Now running BLAST ..

BLASTing sequence 1 of 6 (Q45153_BACFI)

Query sequence ’Q45153_BACFI’

Database ’tmp/LmjFwholegenome_20050601_V5.2.pep’

Found 2 hits above the threshold (E=5.00)

The best hit: ’LmjF36.2210’

<nobr>E-score</nobr> = 1.93e+00

BLASTing sequence 2 of 6 (Q53650_STAAU)

Query sequence ’Q53650_STAAU’

Database ’tmp/LmjFwholegenome_20050601_V5.2.pep’

Found 1 hits above the threshold (E=5.00)

The best hit: ’LmjF04.0510’

<nobr>E-score</nobr> = 3.57e+00

BLASTing sequence 3 of 6 (Q97PJ0_STRPN)

Query sequence ’Q97PJ0_STRPN’

Database ’tmp/LmjFwholegenome_20050601_V5.2.pep’

Found 1 hits above the threshold (E=5.00)

The best hit: ’LmjF13.1210’

<nobr>E-score</nobr> = 2.11e+00

</div>

<div id="id_2">

BLASTing sequence 4 of 6 (P95773_STALU)

</div>

</div>

<div id="page_42">

<div id="dimg1">![](yabby_images/yabby42x1.jpg)</div>

<div id="id_1">

| 

2.6\. EMBOSS ’needle’ commands

 | 

37

 |

Query sequence ’P95773_STALU’

Database ’tmp/LmjFwholegenome_20050601_V5.2.pep’

No BLAST hits above the threshold (E=5.00) found.

BLASTing sequence 5 of 6 (Q9JXN6_NEIMB)

Query sequence ’Q9JXN6_NEIMB’

Database ’tmp/LmjFwholegenome_20050601_V5.2.pep’

No BLAST hits above the threshold (E=5.00) found.

BLASTing sequence 6 of 6 (Q9CE92_LACLA)

Query sequence ’Q9CE92_LACLA’

Database ’tmp/LmjFwholegenome_20050601_V5.2.pep’

No BLAST hits above the threshold (E=5.00) found.

The BLAST search was executed for each sequences in the ’cad’ set in turn, creating six ’blast’ objects:

| 

yabby> what

 |
| 

object(s)

 | 

type

 |
| 

<nobr>------------------------------</nobr>

 |
| 

cad

 | 

seq

 |
| 

cad_1

 | 

blast

 |
| 

cad_2

 | 

blast

 |
| 

cad_3

 | 

blast

 |
| 

cad_4

 | 

blast

 |
| 

cad_5

 | 

blast

 |
| 

cad_6

 | 

blast

 |

These can be examined later with the command ’blast info’:

yabby> blast_info cad_1

Query sequence ’Q45153_BACFI’

Database ’tmp/LmjFwholegenome_20050601_V5.2.pep’

Found 2 hits above the threshold (E=5.00)

The best hit: ’LmjF36.2210’

<nobr>E-score</nobr> = 1.93e+00

<span class="ft16">2.6</span><span class="ft17">EMBOSS ’needle’ commands</span>

</div>

<div id="id_2">

The command ’emboss needle’ shows the sequences from the output of the program ’needle’ from the EMBOSS suite of programs [7]. The input to the program ’needle’ are two sequences, and the program

</div>

</div>

<div id="page_43">

<div id="dimg1">![](yabby_images/yabby43x1.jpg)</div>

| 

38

 | 

Chapter 2\. Tutorial

 |

calculates the global sequence alignment <nobr>(Needleman-Wunsch</nobr> algorithm). Typically two ﬁles are pro- vided as the input, each containing one sequence in FASTA format. If the second ﬁle contains multiple sequences, the global sequence alignment will be calculate between the ﬁrst sequence and each sequence in turn from the second set. If the second set contains many sequences, the output ﬁle will be large, and it may be diﬃcult to see the best matches. These can be extracted with the command ’emboss needle’:

yabby> emboss_needle needle.out 3

Processing the file ’needle.out’ ..

<span class="ft25">(1)</span><span class="ft31">Q45153_BACFI:LmjF05.1170, Similarity: 26.6</span>

<span class="ft25">(2)</span><span class="ft31">Q45153_BACFI:LmjF05.1120, Similarity: 16.4</span>

<span class="ft25">(3)</span><span class="ft31">Q45153_BACFI:LmjF05.1040, Similarity: 15.0</span>

The second argument is the number of <nobr>top-scoring</nobr> sequences to be printed out.

The purpose of the command ’emboss needl2’ is to ﬁnd out what is the similarity between the two sets of sequences. Consider the following problem: given two sets of sequences, set A and set B, we need to ﬁnd out how similar are the sequences in the set B to the sequences in the set A.

The command emboss needl2 will take one sequence at a time from the query set A, and run the EMBOSS program ’needle’ to ﬁnd the similarity after the best alignment between this sequence and each sequence in the set B. emboss needl2 will then extract the ID of the most similar sequence, as reported by ’needle’, and it will move to the next query sequence from the query set A set until all query sequences are exausted.

Consider the following example: the set A is ’Ecoli057.fas’ and the set B is ’Ecoli lab.fas’, both given as FASTA ﬁles. To ﬁnd out the similarity of sequences in Ecoli057.fas to sequences in Ecoli lab.fas, we ﬁrst load the query set in yabby:

yabby> seq_load Ecoli057.fas Ecoli057

Reading the file ’Ecoli057.fas’ .. 9 sequence(s) found.

The second set ’Ecoli lab.fas’ is required as FASTA ﬁle. Then:

yabby> emboss_needl2 Ecoli057 Ecoli_lab.fas sim_list

’Ecoli057’ contains 9 sequence(s) Working on sp|P36546|OMPX_ECOLI <nobr>Needleman-Wunsch</nobr> global alignment.

Working on tr|Q8X8K6|Q8X8K6 <nobr>Needleman-Wunsch</nobr> global alignment.

</div>

<div id="page_44">

<div id="dimg1">![](yabby_images/yabby44x1.jpg)</div>

<div id="id_1">

| 

2.6\. EMBOSS ’needle’ commands

 | 

39

 |

Working on sp|P39170|UP05_ECOLI <nobr>Needleman-Wunsch</nobr> global alignment.

Working on tr|Q8XDF1|Q8XDF1 <nobr>Needleman-Wunsch</nobr> global alignment.

Working on sp|P58603|OMPT_ECO57 <nobr>Needleman-Wunsch</nobr> global alignment.

Working on tr|Q8XAS0|Q8XAS0 <nobr>Needleman-Wunsch</nobr> global alignment.

Working on tr|Q8X592|Q8X592 <nobr>Needleman-Wunsch</nobr> global alignment.

Working on tr|Q8X7N5|Q8X7N5 <nobr>Needleman-Wunsch</nobr> global alignment.

Working on tr|Q8X8F2|Q8X8F2 <nobr>Needleman-Wunsch</nobr> global alignment. yabby>

The argument to the command ’emboss needl2’ are the query sequence object, the FASTA ﬁle of the database set, and the name of the object to be created which contains the information about similarities This is ’needl2’ object:

yabby> what

object(s) type

<nobr>------------------------------</nobr>

Ecoli057 seq sim_list needl2

One can print the ’needl2’ object:

yabby> print sim_list.needl2

OMPX_ECOLI OMPX_ECOLI 100.0

Q8X8K6 OMPG_ECOLI 100.0

UP05_ECOLI UP05_ECOLI 100.0

Q8XDF1 OMPF_ECOLI 99.4

OMPT_ECO57 OMPT_ECOLI 99.7

Q8XAS0 NMPC_ECOLI 80.3

Q8X592 MIPA_ECOLI 99.6

Q8X7N5 PHOE_ECOLI 99.7

Q8X8F2 YFEN_ECOLI 32.1

</div>

<div id="id_2">

Or sorted by percent similarity:

</div>

</div>

<div id="page_45">

<div id="dimg1">![](yabby_images/yabby45x1.jpg)</div>

| 

40

 | 

Chapter 2\. Tutorial

 |

yabby> print <nobr>-s</nobr> sim_list.needl2

Q8X8F2 YFEN_ECOLI 32.1

Q8XAS0 NMPC_ECOLI 80.3

Q8XDF1 OMPF_ECOLI 99.4

Q8X592 MIPA_ECOLI 99.6

OMPT_ECO57 OMPT_ECOLI 99.7

Q8X7N5 PHOE_ECOLI 99.7

OMPX_ECOLI OMPX_ECOLI 100.0

Q8X8K6 OMPG_ECOLI 100.0

UP05_ECOLI UP05_ECOLI 100.0

The above table lists two sequence IDs (ID query and ID dba) and the percent similarity as reported by the program ’needle’ after the best global alignment. The above table contains nine rows, since the query set (’Ecoli057.fas’) contains nine sequences. Each line refers to one sequence from the ’Ecoli057.fas’, and given are the best matching sequence from the second set (’Ecoli lab.fas’), and percent similarity. We see that the sequence ’Q8X8F2’ from ’Ecoli057.fas’ has the least similarity to any sequence from the ’Ecoli lab.fas’ set.

The table produced by ’emboss needl2’ can be written to a ﬁle:

yabby> print <nobr>-f</nobr> needl2.out <nobr>-s</nobr> sim_list.needl2

’sim_list.needl2’ written to the file ’needl2.out’

<span class="ft16">2.7</span><nobr><span class="ft17">Stand-alone</span></nobr> commands

<nobr>Stand-alone</nobr> commands do not interact with other commands. They are, in eﬀect, independent program scripts. Nevertheless it is often useful to collect such independent scripts under Yabby to simplify their maintenance and ensure <nobr>long-term</nobr> retention. An example of such command is ’pdb model’.

Another example of a <nobr>stand-alone</nobr> command is ’pdb model’, which splits the Protein Data Bank (PDB) ﬁle with multiple models. The output is a series of PDB ﬁles, one per model:

yabby> pdb_model 2C7H.pdb RBP_

| 

working on model

 | 

1

 | 

(creating ’RBP_1.pdb’)

 |
| 

working on model

 | 

2

 | 

(creating ’RBP_2.pdb’)

 |
| 

working on model

 | 

3

 | 

(creating ’RBP_3.pdb’)

 |
| 

working on model

 | 

4

 | 

(creating ’RBP_4.pdb’)

 |
| 

working on model

 | 

5

 | 

(creating ’RBP_5.pdb’)

 |

.... extra output deleted ....

</div>

<div id="page_46">

<div id="dimg1">![](yabby_images/yabby46x1.jpg)</div>

<div id="id_1">

| 

2.8\. Extending Yabby

 | 

41

 |

where ’2C7H.pdb’ is the original PDB ﬁle with multiple models, and ’RBP ’ is the preﬁx used for individual model ﬁles.

<span class="ft16">2.8</span><span class="ft17">Extending Yabby</span>

The <nobr>one-to-one</nobr> correspondence between Yabby commands and Yabby command scripts makes it very clear from where the particular funcionality comes from. This also encapsulates a functionality within a particular script ﬁle, and small size of individual script ﬁles makes it easy to understand, modify, and maintain such scripts. The complete decoupling between command scripts ensures that it is hard to break existing commands when adding new commands.

Any functional Perl script placed in the Yabby library directory will become available for execution as Yabby command. Consider the ﬁle ’hello.pl’ with the following content:

print "Hello World!\n";

If placed in the the Yabby library directory, it becomes immediately available as the command ’hello’:

<span class="ft25">$</span><span class="ft31">yabby</span>

<span class="ft25">-</span><span class="ft31">YABBY version 0.1 -</span>

[ 36 command(s) ready ]

yabby> hello

Hello World!

yabby>

If already running, Yabby will need to be restarted before the command ’hello’ becomes available.

<span class="ft21">2.8.1</span><span class="ft22">Creating a new Yabby command: seq letter</span>

Although a simple perl script would work if just dropped in the Yabby library, to create a Yabby command would require some additional eﬀort. Consider creating a very simple command which operates on the sequence object, and prints the ﬁrst letter of the ﬁrst sequence stored in the sequence object. The command will be named ’seq letter’.

We start by creating the ﬁle ’seq letter.pl’ in the Yabby library:

</div>

<div id="id_2">

# seq_letter.pl

</div>

</div>

<div id="page_47">

<div id="dimg1">![](yabby_images/yabby47x1.jpg)</div>

| 

42

 | 

Chapter 2\. Tutorial

 |

use yabby_sys; use yabby_seq;

use Getopt::Std;

All Yabby commands rely on the module ’yabby sys’. The module ’yabby seq’ contains functions for the manipulation of sequences. The Perl module ’Getopt::Std’ is required to enable processing of single- character command switches.

The next step is to create the usage string:

$USAGE = "

Prints the first letter from the first sequence of a sequence object.

Usage:

seq_letter OBJ_NAME

where OBJ_NAME is the name of an existing sequence object.

Notes:

1\. This command is merely an example to demonstrate how new Yabby commands can be developed.

";

The usage string will be printed when ’help seq letter’ or ’seq letter help’ is issued.

We add the initialization commands:

<span class="ft25">#</span><span class="ft31">options</span>

<span class="ft25">#</span><span class="ft31">initialization</span>

@argl = sys_init( @ARGV ); check_call( @argl, [ 1 ] ); $obj_name = $argl[0];

In the case of this command there are no options. The function ’sys init’ is used to process arguments to all Yabby commands in a standard way. The function ’check call’ is used to check the number of arguments. In this case, exactly one argument must be given, the name of an existing sequence object. Finally, in the last line the name of sequence object is associated to the variable ’obj name’. In the next step the sequence object is loaded in the memory:

requirements( $obj_name, $SEQUENCE );

$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

</div>

<div id="page_48">

<div id="dimg1">![](yabby_images/yabby48x1.jpg)</div>

<div id="id_1">

| 

2.8\. Extending Yabby

 | 

43

 |

The function ’requirements()’ checks whether the sequence object named ’obj name’ exists. If not, it will terminate the script with an appropriate error message. If this step is passed, the function ’load ip xml()’ loads the sequence object from the workspace. Finally, we fetch the ﬁrst sequence and print its ﬁrst letter:

$seq_hash = xml2seq( $xmldoc ); $seq_item = <nobr>$seq_hash->{1};</nobr>

printf " The first letter of the first sequence is: ’%s’\n", substr( <nobr>$seq_item->{$DBA_SEQUENCE},</nobr> 0, 1 );

The complete listing of the modiﬁed command script ’seq letter’ is given below:

# seq_letter.pl

use yabby_sys; use yabby_seq;

use Getopt::Std;

$USAGE = "

Prints the first letter from the first sequence of a sequence object.

Usage:

seq_letter OBJ_NAME

where OBJ_NAME is the name of an existing sequence object.

Notes:

1\. This command is merely an example to demonstrate how new Yabby commands can be developed.

";

<span class="ft25">#</span><span class="ft31">options</span>

<span class="ft25">#</span><span class="ft31">initialization</span>

@argl = sys_init( @ARGV ); check_call( @argl, [ 1 ] ); $obj_name = $argl[0];

# requirements

requirements( $obj_name, $SEQUENCE );

$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

</div>

<div id="id_2">

# body

</div>

</div>

<div id="page_49">

<div id="dimg1">![](yabby_images/yabby49x1.jpg)</div>

| 

44

 | 

Chapter 2\. Tutorial

 |
| 

$seq_hash = xml2seq( $xmldoc );

 |

$seq_item = <nobr>$seq_hash->{1};</nobr>

printf " The first letter of the first sequence is: ’%s’\n", substr( <nobr>$seq_item->{$DBA_SEQUENCE},</nobr> 0, 1 );

When executed, the command gives the following output:

yabby> seq_load tom20.fas tom20

Reading the file ’tom20.fas’ .. 3 sequence(s) found.

yabby> seq_letter tom20

The first letter of the first sequence is: ’M’

Consider what happens when no arguments are given:

yabby> seq_letter

seq_letter:: ERROR: exactly 1 argument(s) required [ 0 supplied ] [ command ’seq_letter’ failed ]

This error was raised by the function ’check call’. If the sequence object does not exist:

yabby> seq_letter ttt

seq_letter:: missing requirement: ’ttt.seq’

[ command ’seq_letter’ failed ]

The last error was raised by the function ’requirements()’.

<span class="ft21">2.8.2</span><span class="ft22">Extending seq letter to work on all sequences</span>

It would be easy to extend the command seq letter to print the ﬁrst letter of all sequences from the sequence object. This would require modifying the body of the command:

# body

$seq_hash = xml2seq( $xmldoc ); $keys = get_seq_keys( $seq_hash );

</div>

<div id="page_50">

<div id="dimg1">![](yabby_images/yabby50x1.jpg)</div>

| 

2.8\. Extending Yabby

 | 

45

 |

printf " ’%s’ contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

for $key ( @$keys ) {

$seq_item = <nobr>$seq_hash->{$key};</nobr>

printf " Sequence ’%s’, the first letter is ’%s’\n", <nobr>$seq_item->{$DBA_SEQID},</nobr> substr( <nobr>$seq_item->{$DBA_SEQUENCE},</nobr> 0, 1 );

}

The output of ’seq letter’ is:

yabby> seq_letter tom20

’tom20’ contains 3 sequence(s)

Sequence ’A.thaliana2’, the first letter: ’M’ Sequence ’O.sativa’, the first letter: ’M’ Sequence ’L.esculentum’, the first letter: ’M’

<span class="ft21">2.8.3</span><span class="ft22">Adding a command switch</span>

Consider how one could add an optional switch to print the last letter of each sequence, instead of the ﬁrst letter.

To add the switch <nobr>’-t’:</nobr>

# options getopts(’t’);

if ( defined( $opt_t ) ) { $opt_t_flag = 1;

} else { $opt_t_flag = 0;

}

To extend the command body to take into account possible <nobr>’-t’</nobr> switch:

$seq_hash = xml2seq( $xmldoc ); $keys = get_seq_keys( $seq_hash );

printf " ’%s’ contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

for $key ( @$keys ) {

$seq_item = <nobr>$seq_hash->{$key};</nobr> $seq_id = <nobr>$seq_item->{$DBA_SEQID};</nobr>

$sequence = <nobr>$seq_item->{$DBA_SEQUENCE};</nobr>

</div>

<div id="page_51">

<div id="dimg1">![](yabby_images/yabby51x1.jpg)</div>

<div id="id_1">

| 

46

 | 

Chapter 2\. Tutorial

 |

if ( $opt_t_flag ) {

$lett = substr( <nobr>$seq_item->{$DBA_SEQUENCE},</nobr> <nobr>-1,</nobr> 1 ); } else {

$lett = substr( <nobr>$seq_item->{$DBA_SEQUENCE},</nobr> 0, 1 );

}

printf " Sequence ’%s’, the letter is ’%s’\n", $seq_id, $lett;

}

The possible use of the modiﬁed ’seq letter’:

yabby> seq_letter tom20

’tom20’ contains 3 sequence(s)

Sequence ’A.thaliana2’, the letter is ’M’ Sequence ’O.sativa’, the letter is ’M’ Sequence ’L.esculentum’, the letter is ’M’

yabby> seq_letter <nobr>-t</nobr> tom20

’tom20’ contains 3 sequence(s)

Sequence ’A.thaliana2’, the letter is ’R’ Sequence ’O.sativa’, the letter is ’R’ Sequence ’L.esculentum’, the letter is ’R’

The full listing of the command ’seq letter’ is:

# seq_letter.pl

use yabby_sys; use yabby_seq;

use Getopt::Std;

$USAGE = "

Prints the first sequence letter from the sequence object.

Usage:

seq_letter [ options ] OBJ_NAME

</div>

<div id="id_2">

where OBJ_NAME is the name of an existing sequence object.

</div>

</div>

<div id="page_52">

| 

2.8\. Extending Yabby

 | 

47

 |

Options:

<nobr>-t</nobr> <nobr>--</nobr> print the last letter instead of the first

Notes:

1\. This command is merely an example to demonstrate how new Yabby commands can be developed.

";

# options getopts(’t’);

if ( defined( $opt_t ) ) { $opt_t_flag = 1;

<span class="ft25">}</span><span class="ft46">else { $opt_t_flag = 0;</span>

}

# initialization

@argl = sys_init( @ARGV ); check_call( @argl, [ 1 ] ); $obj_name = $argl[0];

# requirements

requirements( $obj_name, $SEQUENCE );

$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body

$seq_hash = xml2seq( $xmldoc ); $keys = get_seq_keys( $seq_hash );

printf " ’%s’ contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

for $key ( @$keys ) {

$seq_item = <nobr>$seq_hash->{$key};</nobr> $seq_id = <nobr>$seq_item->{$DBA_SEQID};</nobr>

$sequence = <nobr>$seq_item->{$DBA_SEQUENCE};</nobr>

if ( $opt_t_flag ) {

$lett = substr( <nobr>$seq_item->{$DBA_SEQUENCE},</nobr> <nobr>-1,</nobr> 1 );

<span class="ft25">}</span><span class="ft31">else {</span>

$lett = substr( <nobr>$seq_item->{$DBA_SEQUENCE},</nobr> 0, 1 );

</div>

<div id="page_53">

<div id="dimg1">![](yabby_images/yabby53x1.jpg)</div>

<div id="id_1">

| 

48

 | 

Chapter 2\. Tutorial

 |

}

printf " Sequence ’%s’, the letter is ’%s’\n", $seq_id, $lett;

}

<span class="ft21">2.8.4</span><span class="ft22">A command that creates an object</span>

The command ’seq letter’ is very simple in that it merely prints something on the output screen; it does not modify an existing object nor does it creates any new Yabby objects. Consider a command that actually creates a sequence object. An example for this may be a command that chops the ﬁrst letter from each sequence in the sequence object, and saves the result as a new sequence object. This requires two names to be given on the input, the name of an existing sequence object, and the name of the sequence object that will be created:

seq_letterc OBJ_NAME OBJ_NAME_NEW

The new command is named ’seq letterc’ to distinguish it from the previous ’seq letter’.

To build the command ’seq letterc’ we create the ﬁle ’seq letterc.pl’ in the Yabby library:

# seq_letters.pl

use yabby_sys; use yabby_seq;

use Getopt::Std;

$USAGE = "

Chops the first sequence letter from the sequence object, and saves the result as a new sequence object.

Usage:

seq_letters OBJ_NAME OBJ_NAME_NEW

where OBJ_NAME is the name of an existing sequence object.

Notes:

1\. This command is merely an example to demonstrate how new Yabby commands can be developed.

";

</div>

<div id="id_2">

Two arguments are now required:

</div>

</div>

<div id="page_54">

<div id="dimg1">![](yabby_images/yabby54x1.jpg)</div>

| 

2.8\. Extending Yabby

 | 

49

 |

<span class="ft25">#</span><span class="ft31">options</span>

<span class="ft25">#</span><span class="ft31">initialization</span>

@argl = sys_init( @ARGV ); check_call( @argl, [ 2 ] ); $obj_name = $argl[0]; $obj_name2 = $argl[1];

We can use the same construct to check for requirements and fetch the sequence object:

# requirements

requirements( $obj_name, $SEQUENCE );

$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body

$seq_hash = xml2seq( $xmldoc ); $keys = get_seq_keys( $seq_hash );

printf " ’%s’ contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

The new command requires a new sequence object to be created, and populated with sequences from the existing sequence object (minus the ﬁrst letter). We ﬁrst initialize a new sequence object:

$seq_hash2 = {};

The same construct as in ’seq letter’ could be used to loop through the sequences. Now, we also create a new sequence for each existing sequence, chop the ﬁrst letter, and joing the result to the new sequence object:

for $key ( @$keys ) {

$seq_item = <nobr>$seq_hash->{$key};</nobr>

$seq_item_new = {};

<nobr>$seq_item_new->{$DBA_SEQID}</nobr> = <nobr>$seq_item->{$DBA_SEQID};</nobr> <nobr>$seq_item_new->{$DBA_COMMENT}</nobr> = <nobr>$seq_item->{$DBA_COMMENT};</nobr> <nobr>$seq_item_new->{$DBA_SEQUENCE}</nobr> = <nobr>$seq_item->{$DBA_SEQUENCE};</nobr>

# chop the first letter from the sequence

substr( <nobr>$seq_item_new->{$DBA_SEQUENCE},</nobr> 0, 1 ) = "";

<nobr>$seq_hash2->{$key}</nobr> = $seq_item_new;

}

</div>

<div id="page_55">

<div id="dimg1">![](yabby_images/yabby55x1.jpg)</div>

<div id="id_1">

| 

50

 | 

Chapter 2\. Tutorial

 |

We need to save the newly created sequence hash ’seq hash2’ as the new sequence object. In the ﬁrst step, we convert the sequence hash object into an XML document:

$xmldoc = seq2xml( $seq_hash2 );

This is the reverse of the above command ’xml2seq()’, which converts an XML document representing a sequence object into a sequence hash, the form all commands employ to represent the sequence object in memory. The functions ’xml2seq()’ and ’seq2xml()’ are speciﬁc for sequence objects, and are deﬁned in the package ’yabby seq.pm’. Finally, we store the XML sequence object in the workspace:

printf " Saving chopped sequences as ’%s’\n", $obj_name2; save_ip_xml( $xmldoc, $obj_name2, $SEQUENCE, $WARN_OVERW );

The function ’save ip xml()’ sends the XML representation of an object to the workspace. This function is the reverse analog of the previously used function ’load ip xml()’, which fetches the XML representation of an object from the workspace. These two functions are deﬁned in the package ’yabby sys.pm’.

The arguments to the function ’save ip xml()’ are are follows: the XML representation of an object (’xmldoc’), the name of the object to be created (’obj name2’), the type of the object to be created (’SEQUENCE’ in this case), and the ﬂag which determines whether the warning will be issued is the object with the same name and the same type already exists in the workspace and will be overwritten (’WARN OVERW’).

The command ’seq letterc’ could be used as follows:

yabby> seq_load tom20.fas tom20

Reading the file ’tom20.fas’ .. 3 sequence(s) found.

yabby> what

object(s) type

<nobr>------------------------------</nobr>

tom20 seq

yabby> seq_letterc tom20 tom20_chop

’tom20’ contains 3 sequence(s)

Saving chopped sequences as ’tom20_chop’

yabby> what

</div>

<div id="id_2">

object(s) type

</div>

</div>

<div id="page_56">

<div id="dimg1">![](yabby_images/yabby56x1.jpg)</div>

<div id="id_1">

| 

2.8\. Extending Yabby

 | 

51

 |
| 

<nobr>------------------------------</nobr>

 |
| 

tom20

 | 

seq

 |
| 

tom20_chop

 | 

seq

 |

yabby> print tom20.seq

>A.thaliana2 [ A.thaliana2 ] MEFSTADFERFIMFEHARKNSEAQYKNDPLDSENLLKWGGALLELSQFQPIPEAKLMLND AISKLEEALTINPGKHQALWCIANAYTAHAFYVHDPEEAKEHFDKATEYFQRAENEDPGN DTYRKSLDSSLKAPELHMQFMNQGMGQQILGGGGGGGGGGMASSNVSQSSKKKKRNTEFT YDVCGWIILACGIVAWVGMAKSLGPPPPAR

>O.sativa [ O.sativa ] MDMGAMSDPERMFFFDLACQNAKVTYEQNPHDADNLARWGGALLELSQMRNGPESLKCLE DAESKLEEALKIDPMKADALWCLGNAQTSHGFFTSDTVKANEFFEKATQCFQKAVDVEPA NDLYRKSLDLSSKAPELHMEIHRQMASQASQAASSTSNTRQSRKKKKDSDFWYDVFGWVV LGVGMVVWVGLAKSNAPPQAPR

>L.esculentum [ L.esculentum ] MDMQSDFDRLLFFEHARKTAETTYATDPLDAENLTRWAGALLELSQFQSVSESKKMISDA ISKLEEALEVNPQKHDAIWCLGNAYTSHGFLNPDEDEAKIFFDKAAQCFQQAVDADPENE LYQKSFEVSSKTSELHAQIHKQGPLQQAMGPGPSTTTSSTKGAKKKSSDLKYDVFGWVIL AVGLVAWIGFAKSNMPXPAHPLPR

yabby> print tom20_chop.seq

>A.thaliana2 [ A.thaliana2 ] EFSTADFERFIMFEHARKNSEAQYKNDPLDSENLLKWGGALLELSQFQPIPEAKLMLNDA ISKLEEALTINPGKHQALWCIANAYTAHAFYVHDPEEAKEHFDKATEYFQRAENEDPGND TYRKSLDSSLKAPELHMQFMNQGMGQQILGGGGGGGGGGMASSNVSQSSKKKKRNTEFTY DVCGWIILACGIVAWVGMAKSLGPPPPAR

>O.sativa [ O.sativa ] DMGAMSDPERMFFFDLACQNAKVTYEQNPHDADNLARWGGALLELSQMRNGPESLKCLED AESKLEEALKIDPMKADALWCLGNAQTSHGFFTSDTVKANEFFEKATQCFQKAVDVEPAN DLYRKSLDLSSKAPELHMEIHRQMASQASQAASSTSNTRQSRKKKKDSDFWYDVFGWVVL GVGMVVWVGLAKSNAPPQAPR

>L.esculentum [ L.esculentum ] DMQSDFDRLLFFEHARKTAETTYATDPLDAENLTRWAGALLELSQFQSVSESKKMISDAI SKLEEALEVNPQKHDAIWCLGNAYTSHGFLNPDEDEAKIFFDKAAQCFQQAVDADPENEL YQKSFEVSSKTSELHAQIHKQGPLQQAMGPGPSTTTSSTKGAKKKSSDLKYDVFGWVILA VGLVAWIGFAKSNMPXPAHPLPR

Since no safeguards were put against overwriting an existing sequence object, the command ’seq letterc’ could be used twice to chop sequences from the <nobr>N-terminus</nobr> in place,

</div>

<div id="id_2">

yabby> seq_letterc tom20 tom20

</div>

</div>

<div id="page_57">

<div id="dimg1">![](yabby_images/yabby57x1.jpg)</div>

<div id="id_1">

| 

52

 | 

Chapter 2\. Tutorial

 |

’tom20’ contains 3 sequence(s) Saving chopped sequences as ’tom20’

[ seq_letterc: ’tom20.seq’ exists, overwritten ]

yabby> seq_letterc tom20 tom20

’tom20’ contains 3 sequence(s) Saving chopped sequences as ’tom20’

[ seq_letterc: ’tom20.seq’ exists, overwritten ]

<span class="ft21">2.8.5</span><span class="ft22">Creating a new object type</span>

Yabby supports two internal representations of data in the workspace: simple lists and XML objects. To create a new object type one must ﬁrst decide whether the data in question can be eﬀectively represented with a <nobr>two-dimensional</nobr> table. <nobr>Two-dimensional</nobr> tables can be eﬀectively represented with <nobr>two-dimensional</nobr> lists, where each item in the list corresponds to the table row. Lists are simple and eﬃcient in Perl, and if suitable this is the preferred representation of data. However, XML format is much more powerful and ﬂexible, and is the preferred solution when the data has a complex internal structure.

A sequence object uses XML to store data into the workspace. A Yabby commands store sequence objects in memory in the form of a hash (sequence hash). All sequence commands use the standard function ’load ip xml()’ to fetch the XML representation of a sequence object from the workspace. Subsequently the object is converted into a more eﬃcient structure, a sequence hash, with the function ’xml2seq()’. After the sequences are manipulated, or a new sequence object is created, the result may be stored in the workspace. In this case, the reverse transformation process takes place: the sequence hash is convereted into an XML object with the function ’seq2xml()’, and the resulting XML object is saved in the workspace with the function ’save ip xml()’.

The functions ’load ip xml()’ and ’save ip xml()’ can be used to load/store the XML representation of any object in the workspace. The analogous functions for objects represented as a <nobr>two-dimensional</nobr> lists are ’load ip()’ and ’save ip()’.

As an example we will create a new object type named ”seqid” to represent the list of sequence IDs. To demonstrate the use of this object we will also create the command ’seq2id’ which creates the ”seqid” object from an existing sequence object.

The ﬁrst step is to create the script ’seq2id.pl’ in the Yabby library, and we start as previously:

# seq2id.pl

use yabby_sys; use yabby_seq;

</div>

<div id="id_2">

use Getopt::Std;

</div>

</div>

<div id="page_58">

<div id="dimg1">![](yabby_images/yabby58x1.jpg)</div>

<div id="id_1">

| 

2.8\. Extending Yabby

 | 

53

 |

$USAGE = "

Converts a sequence object into seqid object.

Usage:

seq2id OBJ_NAME

where OBJ_NAME is the name of an existing sequence object.

Notes:

1\. This command is merely an example to demonstrate how a new object type can be implemented.

";

<span class="ft25">#</span><span class="ft31">options</span>

<span class="ft25">#</span><span class="ft31">initialization</span>

@argl = sys_init( @ARGV ); check_call( @argl, [ 1 ] ); $obj_name = $argl[0];

# requirements

requirements( $obj_name, $SEQUENCE );

$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

# body

$seq_hash = xml2seq( $xmldoc ); $keys = get_seq_keys( $seq_hash );

With this we have the sequence hash in memory. In ’yabby seq.pm’ we add the name of the ”seqid” object:

$SEQUENCE = "seq"; $MOTIF = "motif"; $SEQID = "seqid";

The new object will be represented as a <nobr>one-dimensional</nobr> list, where each sequence ID string will be one element of this list. This is equivalent to a <nobr>two-dimensional</nobr> table, where there is only one column in the table. Next we create the variable ’seqid obj’ to hold the ’seqid’ object, ﬁll this object with the values from the sequence hash, and store the object in the workspace by using the standard function:

</div>

<div id="id_2">

$seqid_obj = [];

</div>

</div>

<div id="page_59">

| 

54

 | 

Chapter 2\. Tutorial

 |

for $key ( @$keys ) {

$seq_item = <nobr>$seq_hash->{$key};</nobr> $seq_id = <nobr>$seq_item->{$DBA_SEQID};</nobr>

push @$seqid_obj, [ $seq_id ];

}

print " Saving ’$obj_name.$SEQID’\n";

save_ip( $seqid_obj, $obj_name, $SEQID, $WARN_OVERW );

The complete listing for the command script ’seq2id’:

# seq2id.pl

use yabby_sys; use yabby_seq;

use Getopt::Std;

$USAGE = "

Converts a sequence object into seqid object.

Usage:

seq2id OBJ_NAME

where OBJ_NAME is the name of an existing sequence object.

Notes:

1\. This command is merely an example to demonstrate how a new object type can be implemented.

";

<span class="ft25">#</span><span class="ft31">options</span>

<span class="ft25">#</span><span class="ft31">initialization</span>

@argl = sys_init( @ARGV ); check_call( @argl, [ 1 ] ); $obj_name = $argl[0];

# requirements

requirements( $obj_name, $SEQUENCE );

$xmldoc = load_ip_xml( $obj_name, $SEQUENCE );

</div>

<div id="page_60">

<div id="id_1">

| 

2.8\. Extending Yabby

 | 

55

 |

# body

$seq_hash = xml2seq( $xmldoc ); $keys = get_seq_keys( $seq_hash );

printf " ’%s’ contains %d sequence(s)\n", $obj_name, $#{$keys}+1;

$seqid_obj = [];

for $key ( @$keys ) {

$seq_item = <nobr>$seq_hash->{$key};</nobr> $seq_id = <nobr>$seq_item->{$DBA_SEQID};</nobr>

push @$seqid_obj, [ $seq_id ];

}

print " Saving ’$obj_name.$SEQID’\n";

save_ip( $seqid_obj, $obj_name, $SEQID, $WARN_OVERW );

And below is the output when the command is executed on an example sequence object:

yabby> seq_load tom20.fas tom20

Reading the file ’tom20.fas’ .. 3 sequence(s) found.

yabby> seq2id tom20

’tom20’ contains 3 sequence(s) Saving ’tom20.seqid’

| 

yabby> what

 |
| 

object(s)

 | 

type

 |
| 

<nobr>------------------------------</nobr>

 |
| 

tom20

 | 

seq

 |

seqid

 |

Of course, at this point nothing can be done with the ’seqid’ object. It cannot be even printed on the screen:

</div>

<div id="id_2">

yabby> print tom20.seqid

</div>

</div>

<div id="page_61">

<div id="dimg1">![](yabby_images/yabby61x1.jpg)</div>

| 

56

 | 

Chapter 2\. Tutorial

 |

print:: ERROR: printing the property ’seqid’ not yet implemented [ command ’print’ failed ]

This is because the printing of each particular object type has to be enabled in the ’print’ command. However, one can view the ’seqid’ object directly from the ﬁlesystem, since ’tom20.seqid’ is just a simple text ﬁle, containing sequence IDs listed one per row:

yabby> cat .yabby/tom20.seqid A.thaliana2

O.sativa

L.esculentum

<span class="ft21">2.8.6</span><span class="ft22">Some additional explanations and programming conventions</span>

All objects that are represents with two dimensional tables are initialized as annonymous arrays:

$seqid_obj = [];

When ﬁlled with values, each element of this array is a reference to anonymous array. In this case containing only one element ’seq id’:

push @$seqid_obj, [ $seq_id ];

This format is very ﬂexible. If the data table needs to contain more than one element per row, these would be simply added to the anonymous reference representing a table row:

push @$seqid_obj, [ $seq_id, $colum2_elem, $colum3_elem, ... ];

Consider how the object ’mol’ is built, which is internally represented with a <nobr>two-dimensional</nobr> table:

push @$mol, [ $resi_num, $resi_name, $atom_name, $segmentID ];

The function ’save ip()’ expects the reference to an anonymous array, where each element of this array is a reference to another anonymous array which may contain one or more elements. This holds for any object represented by a list, and functions ’save ip()’ and ’load ip()’ are used to store/fetch the object from the workspace. For objects represented in XML, a special converter function needs to be written akin to ’xml2seq()’ and ’seq2xml()’.

</div>

<div id="page_62">

<div id="dimg1">![](yabby_images/yabby62x1.jpg)</div>

<div id="id_1">

Command reference

<span class="ft16">3.1</span><span class="ft17">General commands</span>

General commands are related to the basic Yabby functions, such as control of the workspace, and are not related to any speciﬁc area of application.

<span class="ft21">3.1.1</span><span class="ft48">delete</span>

Deletes objects from the workspace.

Usage:

delete OBJECT.PROPERTY

Options:

None

Notes:

1\. If PROPERTY equals ’*’ (no quotes) all properties of OBJECT will be deleted.

Examples:

<span class="ft2">1\. </span>yabby> delete sp.seq

[ ’sp.seq’ deleted ]

Requirements: None

Creates objects: None

System scripts: None

</div>

<div id="id_2">

57

</div>

</div>

<div id="page_63">

<div id="dimg1">![](yabby_images/yabby63x1.jpg)</div>

<div id="id_1">

| 

58

 | 

Chapter 3\. Command reference

 |

<span class="ft21">3.1.2</span><span class="ft48">dump</span>

Dumps the current workspace to a ﬁle, which later can be restored with ’restore’.

Usage:

dump SESSION NAME

Options:

None

Notes:

<span class="ft2">1.</span><span class="ft34">This command saves the current Yabby session in the ﬁle SESSION NAME.tar.gz in the current directory.</span>

<span class="ft2">2.</span><span class="ft34">Currently works only on system that have GNU tar command.</span>

Examples:

<span class="ft2">1\. </span>yabby> dump tmpsession

Yabby session archived as ’tmpsession.tar.gz’

Requirements: None

Creates objects: None

System scripts: None

<span class="ft21">3.1.3</span><span class="ft48">flush</span>

Deletes everything from the workspace.

Usage:

flush

Options:

None

Notes:

None

Examples:

<span class="ft2">1\. </span>yabby> flush

</div>

<div id="id_2">

[ workspace flushed ]

</div>

</div>

<div id="page_64">

<div id="dimg1">![](yabby_images/yabby64x1.jpg)</div>

| 

3.1\. General commands

 | 

59

 |

Requirements: None

Creates objects: None

System scripts: None

<span class="ft21">3.1.4</span><span class="ft48">license</span>

Prints the Yabby license.

Usage:

license

Options:

None

Notes:

None

Examples:

<span class="ft2">1\. </span>yabby> license

GNU GENERAL PUBLIC LICENSE

Version 2, June 1991

Copyright (C) 1989, 1991 Free Software Foundation, Inc.

675 Mass Ave, Cambridge, MA 02139, USA Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed.

Preamble

The licenses for most software are designed to take away your freedom to share and change it. By contrast, the GNU General Public

....

Requirements: None

Creates objects: None

System scripts: None

</div>

<div id="page_65">

<div id="dimg1">![](yabby_images/yabby65x1.jpg)</div>

| 

60

 | 

Chapter 3\. Command reference

 |

<span class="ft21">3.1.5</span><span class="ft48">help</span>

Prints help pages.

Usage:

help [ COMMAND ]

Options:

None

Notes:

<span class="ft2">1.</span><span class="ft34">If no argument is given the list of all available commands will be printed. If a command name is given the help about a particular command will be printed.</span>

Examples:

<span class="ft2">1\. </span>yabby> help quit

Exits Yabby

Requirements: None

Creates objects: None

System scripts: None

<span class="ft21">3.1.6</span><span class="ft48">print</span>

Prints an object on the terminal screen or to a ﬁle.

Usage:

print [ options ] OBJ NAME.PROPERTY

Options (general):

<nobr>-f</nobr> FILE NAME – print to a ﬁle instead on the terminal screen.

Options (seq objects only):

<nobr>-l</nobr> – print the sequence as the <nobr>three-letter</nobr> code. <nobr>-c</nobr> – print the sequences as the CSV table.

<nobr>-n</nobr> N – print N residues per line (both when printing one- and <nobr>three-letter</nobr> codes). <nobr>-t</nobr> N – truncate each sequence at N letters when writing

Notes:

</div>

<div id="page_66">

| 

3.1\. General commands

 | 

61

 |

1\. Currently supported objects for printing are ’seq’, ’motif’, and ’blastg’. Examples:

<span class="ft2">1.</span><span class="ft52">Print the sequence object tom20.seq </span><span class="ft53">yabby> print tom20.seq</span>

>A.thaliana [ A.thaliana ] MDTETEFDRILLFEQIRQDAENTYKSNPLDADNLTRWGGVLLELSQFHSISDAKQMIQEA ITKFEEALLIDPKKDEAVWCIGNAYTSFAFLTPDETEAKHNFDLATQFFQQAVDEQPDNT HYLKSLEMTAKAPQLHAEAYKQGLGSQPMGRVEAPAPPSSKAVKNKKSSDAKYDAMGWVI LAIGVVAWISFAKANVPVSPPR

>O.sativa [ O.sativa ] MDMGAMSDPERMFFFDLACQNAKVTYEQNPHDADNLARWGGALLELSQMRNGPESLKCLE DAESKLEEALKIDPMKADALWCLGNAQTSHGFFTSDTVKANEFFEKATQCFQKAVDVEPA NDLYRKSLDLSSKAPELHMEIHRQMASQASQAASSTSNTRQSRKKKKDSDFWYDVFGWVV LGVGMVVWVGLAKSNAPPQAPR

>L.esculentum [ L.esculentum ] MDMQSDFDRLLFFEHARKTAETTYATDPLDAENLTRWAGALLELSQFQSVSESKKMISDA ISKLEEALEVNPQKHDAIWCLGNAYTSHGFLNPDEDEAKIFFDKAAQCFQQAVDADPENE LYQKSFEVSSKTSELHAQIHKQGPLQQAMGPGPSTTTSSTKGAKKKSSDLKYDVFGWVIL AVGLVAWIGFAKSNMPXPAHPLPR

>S.tuberosum [ S.tuberosum ] MEMQSEFDRLLFFEHARKSAETTYAQNPLDADNLTRWGGALLELSQFQPVAESKQMISDA TSKLEEALTVNPEKHDALWCLGNAHTSHVFLTPDMDEAKVYFEKATQCFQQAFDADPSND LYRKSLEVTAKAPELHMEIHRHGPMQQTMAAEPSTSTSTKSSKKTKSSDLKYDIFGWVIL AVGIVAWVGFAKSNMPPPPPPPPQ

>P.taeda [ P.taeda ] MEEMAIPQSDFDRLLFFEGARKAAENTYAVNPEDADNLTRWGGALLELSQFQQGPDCVKM VKDAVSKLEEALKISPNKHDTLWCLGNAHTSHAFLIPEHEVAKIYFKMASKYFQQAVEQD PTNELYRKSLELTEKAPELHLEVHKQILNPQSVAAGSSTVSNLKGSRKKKSSDLKYDIMG WIVLAVGIAAWVGMAKSHVPPPPML

>G.max [ G.max ] MDLQQSEFDRLLFFEHARKAAEAEYEKNPLDADNLTRWGGALLELSQFQSFPESKKMTQE AVSKLEEALAVNPKKHDTLWCLGNAHTSQAFLIPDQEEAKVYFDKAAVYFQQAVDEDPSN ELYRKSLEVAAKAPELHVEIHKQGFGQQQQAAATAGSSTSASTNTQKKKKSSDLKYDIFG WIILAVGIVAWVGFAKSNLPPPPPPPPR

>Z.mays [ Z.mays ] MEMGGMSDAERLFFFEMACKNSEVAYEQNPNDADNLTRWGGALLELSQVRTGPDSLKLLE DAEAKLEEALQIDPNKSDALWCLGNAQTSHGFFTPDNAIANEFFTKATGCFQKAVDVEPA NELYRKSLDLSMKAPELHLEIQRQMVSQAATQASSASNPRQSRKKKDNDFWYDVCGWVIL GAGIVAWVGLARASMPPPTPPAR

<span class="ft2">2.</span><span class="ft52">Print the sequence object tom20.seq to a ﬁle ’tom20.txt’ </span><span class="ft53">yabby> print </span><nobr><span class="ft53">-f</span></nobr><span class="ft53"> tom20.txt tom20.seq</span>

</div>

<div id="page_67">

<div id="dimg1">![](yabby_images/yabby67x1.jpg)</div>

| 

62

 | 

Chapter 3\. Command reference

 |

’tom20.seq’ written to the file ’tom20.txt’

Requirements: The object to be printed must exist in the workspace.

Creates objects: None

System scripts: print seq.pl, print motif.pl, print blastg.pl

<span class="ft21">3.1.7</span><span class="ft48">restore</span>

Restores Yabby session saved with the command ’dump’

Usage:

restore SESSION NAME

Where SESSION NAME is the archive name used when dumping the session. Options:

None

Notes:

<span class="ft2">1.</span><span class="ft34">The session will be restored from a ﬁle named SESSION NAME.tar.gz.</span>

<span class="ft2">2.</span><span class="ft34">Relies on GNU tar and gzip commands. These must be in the executable path.</span>

Examples:

<span class="ft2">1\. </span>yabby> restore tmpsession

Yabby session ’tmpsession’ restored

Requirements: None

Creates objects: None

System scripts: None

<span class="ft21">3.1.8</span><span class="ft48">what</span>

Shows objects currently in the workspace.

Usage:

what

Options:

None

</div>

<div id="page_68">

<div id="dimg1">![](yabby_images/yabby68x1.jpg)</div>

| 

3.2\. Sequence commands

 | 

63

 |

Notes:

None

Examples:

<span class="ft2">1\. </span>yabby> what

objects properties

<nobr>------------------------------</nobr>

tom20 seq

Requirements: None

Creates objects: None

System scripts: None

<span class="ft16">3.2</span><span class="ft17">Sequence commands</span>

<span class="ft21">3.2.1</span><span class="ft48">seq comment</span>

Modiﬁes sequence comments to add a unique number.

Usage:

seq comment OBJ NAME

where OBJ NAME is the name of an existing sequence object.

The sequence object with modiﬁed comments overwrites OBJ NAME. The comment for each se- quence is modiﬁed to prepend N- where N is the order of the sequence. For example, if the sequence comment was Q9JXN6, and was ﬁrst in the sequence object, its comment will be modiﬁed to 1- Q9JXN6.

Options: None

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> seq_comment cad3

Comments modified in 3 sequence(s).

Requirements: seq

Creates objects: None

System scripts: None

</div>

<div id="page_69">

<div id="dimg1">![](yabby_images/yabby69x1.jpg)</div>

| 

64

 | 

Chapter 3\. Command reference

 |

<span class="ft21">3.2.2</span><span class="ft48">seq compl</span>

Calculates sequence complement (for DNA sequences).

Usage:

seq compl [ options ] OBJ NAME OBJ NAME NEW

Where OBJ NAME is the name of an existing sequence object, the complement sequence will be saved under the name OBJ NAME NEW. The sequence OBJ NAME must be a DNA sequence.

Options:

<nobr>-r</nobr> – Calculate the reverse complement.

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> seq_compl dna dna_c

’dna’ contains 1 sequence(s) Working on ’chr01’

Requirements: seq

Creates objects: seq

System scripts: None

<span class="ft21">3.2.3</span><span class="ft48">seq genbank</span>

Fetch a sequence from GenBank.

Usage:

seq genbank [ options ] IDENTIFIER OBJ NAME

Fetch a sequence from GenBank using an identiﬁer such as the sequence accession number (default), version, GI number or unique ID (locus) and save the sequence under the name OBJ NAME.

Options:

<nobr>-a</nobr> ACCESSION NUMBER (default) – fetch sequence by accession number

<nobr>-v</nobr> VERSION – fetch sequence by version number

<nobr>-g</nobr> GI NUMBER – fetch sequence by GI number

<nobr>-i</nobr> UNIQUE ID – fetch sequence by unique ID

Notes:

</div>

<div id="page_70">

<div id="dimg1">![](yabby_images/yabby70x1.jpg)</div>

| 

3.2\. Sequence commands

 | 

65

 |

1\. This command requires Bioperl’s Bio::DB module.

Examples:

<span class="ft2">1\. </span>yabby> seq_fetch <nobr>-a</nobr> J00522 mig

Saving ’J00522’ as ’mig’

Requirements: None

Creates objects: seq

System scripts: None

<span class="ft21">3.2.4</span><span class="ft48">seq info</span>

Prints information about the sequence object.

Usage:

seq info [ options ] OBJ NAME

Where OBJ NAME is the name of an existing sequence object.

Options:

<nobr>-l</nobr> – long output. When multiple sequences are present, print the number of residues for each sequence. By default, only a short summary is printed.

<nobr>-n</nobr> – print only the number of residues in each sequence

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> seq_info cad3

’cad3’ contains 3 sequence(s)

min number of residues: 192 (sequence ’Q53650_STAAU’) max number of residues: 193 (sequence ’Q97PJ0_STRPN’)

<span class="ft2">2\. </span>yabby> seq_info <nobr>-l</nobr> cad3

’cad3’ contains 3 sequence(s)

1 <nobr>-></nobr> Q53650_STAAU, 192 residues

2 <nobr>-></nobr> Q97PJ0_STRPN, 193 residues

3 <nobr>-></nobr> P95773_STALU, 192 residues

</div>

<div id="page_71">

<div id="dimg1">![](yabby_images/yabby71x1.jpg)</div>

| 

66

 | 

Chapter 3\. Command reference

 |

<span class="ft2">3\. </span>yabby> seq_info <nobr>-n</nobr> cad3

’cad3’ contains 3 sequence(s) 192 193 192

Requirements: seq

Creates objects: None

System scripts: None

<span class="ft21">3.2.5</span><span class="ft48">seq load</span>

Loads sequence(s) from the database ﬁle.

Usage:

seq load [ options ] DBA FILE OBJ NAME

Where DBA FILE is the name of the database ﬁle. OBJ NAME is the internal Yabby name for the sequence(s).

Options:

<nobr>-a</nobr> – append sequences to an already existing sequence object OBJ NAME <nobr>-f</nobr> – the ﬁle format is FASTA (default)

<nobr>-b</nobr> – the ﬁle format is BLOCKS

Notes:

1\. Only BLOCKS format written by MEME [2] output was tested.

Examples:

<span class="ft2">1\. </span>yabby> seq_load cad3.fas cad3

Reading the file ’cad3.fas’ .. 3 sequence(s) found.

Requirements: None

Creates objects: seq

System scripts: None

</div>

<div id="page_72">

<div id="dimg1">![](yabby_images/yabby72x1.jpg)</div>

| 

3.2\. Sequence commands

 | 

67

 |

<span class="ft21">3.2.6</span><span class="ft48">seq op</span>

Calculates union/intersection/diﬀerence of two sequence objects by using the sequence IDs.

Usage:

seq op [ options ] SEQ1 OBJ SEQ2 OBJ OBJ NAME

Calculates union/intersection/diﬀerence of two sequence objects SEQ1 OBJ and SEQ2 OBJ, and stores the result as the sequence object OBJ NAME.

Options:

<nobr>-u</nobr> – calculate the union (default)

<nobr>-i</nobr> – calculate the intersection

<nobr>-d</nobr> – calculate the diﬀerence

Notes:

<span class="ft18">1.</span><span class="ft56">The calculation will fail if there are duplicate sequences in one set. For example, if two sets of sequences have no sequence in common, but one set of sequences contains two copies of the sequence ’F36.5845’, the intersection of the two sets will contain this sequence.</span>

Examples:

<span class="ft41">1\. </span>yabby> seq_op <nobr>-i</nobr> cad cad3 cadi

Found 6 sequence(s) in ’cad’ Found 3 sequence(s) in ’cad3’

INTERSECTION contains 3 sequence(s) DIFFERENCE contains 3 sequence(s) UNION contains 6 sequence(s)

[ Saving INTERSECTION as ’cadi’ ]

Requirements: seq

Creates objects: seq

System scripts: <span class="ft2">None</span>

<span class="ft21">3.2.7</span><span class="ft48">seq os</span>

Inserts additional information in sequence comments, where additional information is read from an ex- ternal ﬁle.

</div>

<div id="page_73">

<div id="dimg1">![](yabby_images/yabby73x1.jpg)</div>

| 

68

 | 

Chapter 3\. Command reference

 |

Usage:

seq os FILE NAME OBJ NAME

Where FILE NAME is the ﬁle which contains pairs (sequence ID, additional information), and OBJ NAME is the name of an existing sequence object. FILE NAME must include all sequence IDs present in the OBJ NAME.

Options:

None

Notes:

<span class="ft2">1.</span><span class="ft34">The object OBJ NAME will be overwritten with altered comments to include the additional information for each sequence.</span>

Examples:

<span class="ft2">1.</span><span class="ft52">Insert organism names in 21 sequences stored under the name ’cam.seq’. </span><span class="ft53">yabby> seq_os sprot_test.dat.os cam</span>

Reading the file ’sprot_test.dat.os’ ...

21 sequences to process.

All done.

[ seq_os: ’cam.seq’ exists, overwritten ]

Requirements: seq

Creates objects: seq (overwrites the original seq object)

System scripts: None

<span class="ft21">3.2.8</span><span class="ft48">seq pattern</span>

Searches for letter pattern in a sequence object.

Usage:

seq pattern [ options ] PATTERN OBJ NAME

Searches for pattern PATTERN in sequences OBJ NAME. Where OBJ NAME is the name of an existing sequence object.

Options:

<nobr>-c</nobr> – Match the comment not the sequence.

<nobr>-s</nobr> NAME – extract the matching sequences and save under the name NAME.

<nobr>-n</nobr> – Print the matching sequences and the residue position where the pattern matches.

</div>

<div id="page_74">

<div id="dimg1">![](yabby_images/yabby74x1.jpg)</div>

| 

3.2\. Sequence commands

 | 

69

 |

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> seq_pattern IDY cad3

’IDY’ matches in ’Q53650_STAAU’ ’IDY’ matches in ’Q97PJ0_STRPN’

3 sequences examined, 2 match(es) found

<span class="ft2">2\. </span>yabby> seq_pattern <nobr>-c</nobr> STAA cad3

’STAA’ matches in ’Q53650_STAAU’

3 sequences examined, 1 match(es) found

<span class="ft2">3\. </span>yabby> seq_pattern <nobr>-s</nobr> IDY_matches IDY cad3

’IDY’ matches in ’Q53650_STAAU’ ’IDY’ matches in ’Q97PJ0_STRPN’

3 sequences examined, 2 match(es) found Saving matches as ’IDY_matches’

Requirements: seq

Creates objects: (with option <nobr>-s)</nobr> seq

System scripts: None

<span class="ft21">3.2.9</span><span class="ft48">seq pick</span>

Extracts a subset of sequences from the sequence object.

Usage:

seq pick [ options ] OBJ NAME OBJ NAME NEW

where OBJ NAME is the name of an existing sequence object, and OBJ NAME NEW is the name of the sequence object to be created.

Options:

<nobr>-n</nobr> RANGE – extract the sequence by sequence number. The parameter RANGE can be a single integer, in which the sequence with this sequence number will be extracted. Alternatively, RANGE can contain two integers separated by a colon such as N:M. In this case the sequences which have the sequence number between N and M will be extracted (inclusive).

<nobr>-q</nobr> SEQID – pick a sequence with the sequence ID SEQID

</div>

<div id="page_75">

<div id="dimg1">![](yabby_images/yabby75x1.jpg)</div>

| 

70

 | 

Chapter 3\. Command reference

 |

<nobr>-l</nobr> MIN:MAX – pick sequences whose length is between MIN and MAX

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> seq_pick <nobr>-q</nobr> Q53650_STAAU cad3 s1

Fetching the sequence ’Q53650_STAAU’

Saving the extracted sequence as ’s1’

<span class="ft2">2\. </span>yabby> seq_pick <nobr>-n</nobr> 2 cad3 s2

Fetching the sequence 2 (’Q97PJ0_STRPN’)

Saving the extracted sequence as ’s2’

Requirements: seq

Creates objects: seq

System scripts: None

<span class="ft21">3.2.10</span><span class="ft48">seq sprot os</span>

Inserts the organism name into sequence comments by using the local <nobr>Swiss-Prot</nobr> database ﬁle.

Usage:

seq sprot os DBA FILE OBJ NAME

Where DBA FILE is the local database ﬁle in the <nobr>Swiss-Prot</nobr> format, and OBJ NAME is the name of an existing sequence object. The object OBJ NAME will be overwritten with altered comments to include the organism name for each sequence.

Options: None

Notes:

This command overwrites the original sequence.

Examples:

<span class="ft2">1.</span><span class="ft34">Fetch the organism name (OS) ﬁeld from the </span><nobr>Swiss-Prot</nobr> ﬁle, ’sprot test.dat’, and insert this in the sequence comment of three sequences saved as ’aqr1’:

yabby> seq_sprot_os sprot_test.dat aqr1

3 sequences to process.

Printing dot per processed sequence:

</div>

<div id="page_76">

<div id="dimg1">![](yabby_images/yabby76x1.jpg)</div>

| 

3.2\. Sequence commands

 | 

71

 |

...

All done.

[ seq_sprot_os: ’aqr1.seq’ exists, overwritten ]

Requirements: seq

Creates objects: seq (overwrites the original seq object)

System scripts: None

<span class="ft21">3.2.11</span><span class="ft48">seq strip</span>

Strips a portion of a sequence.

Usage:

seq strip begin:end OBJ NAME OBJ NAME NEW

Where OBJ NAME is the name of an existing sequence object, and begin:end are the ﬁrst and last residue positions to strip (inclusive). The resulting object will be saved under the name OBJ NAME NEW.

If more than one sequence is present in the sequence object, all will be stripped and saved under the new name.

In stripped sequences, IDs are set to ORIGINALID begin:end.

Options: None

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> seq_strip 21:40 cad3 cad3portion

’cad3’ contains 3 sequence(s) stripping ’Q53650_STAAU’ stripping ’Q97PJ0_STRPN’ stripping ’P95773_STALU’

Requirements: seq

Creates objects: seq

System scripts: None

</div>

<div id="page_77">

<div id="dimg1">![](yabby_images/yabby77x1.jpg)</div>

| 

72

 | 

Chapter 3\. Command reference

 |

<span class="ft21">3.2.12</span><span class="ft48">seq uniprot</span>

Fetch a sequence from SwissProt.

Usage:

seq uniprot [ options ] LOCATION IDENTIFIER OBJ NAME

Fetch a sequence from SwissProt using an identiﬁer such as the sequence accession number (default) or unique ID and saves the sequence under the name OBJ NAME.

Options:

<nobr>-l</nobr> LOCATION – possible values (australia,canada,china,korea,switzerland,taiwan,us)

<nobr>-a</nobr> ACCESSION NUMBER – fetch sequence by accession number (default)

<nobr>-i</nobr> UNIQUE ID – fetch sequence by unique ID

Notes:

1\. This command requires Bioperl’s Bio::DB module.

Examples:

<span class="ft2">1\. </span>yabby> seq_uniprot <nobr>-a</nobr> P43780 <nobr>-l</nobr> australia miga

Saving ’P43780’ as ’miga’

Requirements: None

Creates objects: seq

System scripts: None

<span class="ft21">3.2.13</span><span class="ft48">seq unique</span>

Finds unique sequences in one sequence object relative to another by comparing sequence strings.

Usage:

seq unique SEQ1 OBJ SEQ2 OBJ OBJ NAME

This command will ﬁnd the unique sequences in SEQ1 OBJ compared to SEQ2 OBJ, and store these unique sequences as OBJ NAME.

Options: None

Notes:

<span class="ft2">1.</span><span class="ft34">Sequences present in the ﬁrst sequence object and not present in the second second object are calculated. Therefore the order of sequence objects given in the argument matters.</span>

</div>

<div id="page_78">

<div id="dimg1">![](yabby_images/yabby78x1.jpg)</div>

| 

3.3\. <nobr>Swiss-Prot</nobr> related commands

 | 

73

 |

<span class="ft2">2.</span><span class="ft34">This command compares sequence letters as opposed to sequence IDs (compared to seq op). Two sequences are identical if they are an exact </span><nobr>letter-by-letter</nobr> match.

Examples:

<span class="ft2">1\. </span>yabby> seq_unique cad cad3 caduniqincad

3 unique sequences found.

Saving sequences as ’caduniqincad’

Requirements: seq

Creates objects: seq

System scripts: None

<span class="ft16">3.3</span><nobr><span class="ft17">Swiss-Prot</span></nobr> related commands

<span class="ft21">3.3.1</span><span class="ft48">sprot fetch</span>

Fetches a sequence from a <nobr>Swiss-Prot</nobr> local ﬁle database by its ID.

Usage:

sprot fetch DBA FILE SPROT ID OBJ NAME

Where DBA FILE is the database is the <nobr>Swiss-Prot</nobr> format, and SPROT ID is the <nobr>Swiss-Prot</nobr> sequence ID, and OBJ NAME is the name under which the sequence will be saved in the workspace.

Options: None

Notes: None

Examples:

<span class="ft2">1.</span><span class="ft57">Fetch the sequence ’110KD PLAKN’ from the </span><nobr>Swiss-Prot</nobr> ﬁle ’sprot test.dat’: <span class="ft58">yabby> sprot_fetch sprot_test.dat 110KD_PLAKN plakn</span>

Sequence ’110KD_PLAKN’ found. [ Saving as ’plakn.seq’ ]

Requirements: None

Creates objects: seq

System scripts: None

</div>

<div id="page_79">

<div id="dimg1">![](yabby_images/yabby79x1.jpg)</div>

<div id="id_1">

| 

74

 | 

Chapter 3\. Command reference

 |

<span class="ft21">3.3.2</span><span class="ft48">sprot os</span>

Extracts sequence ID and organism name from the <nobr>Swiss-Prot</nobr> sequence database ﬁle.

Usage:

sprot os DBA FILE OUT FILE

Where DBA FILE is the name of the sequence database ﬁle in the <nobr>Swiss-Prot</nobr> format, and OUT FILE is the name of the output ﬁle to be created, containing pairs (sequence ID, organism name).

Options: None

Notes:

1\. This command is designed to work with the command ’seq os’.

Examples:

<span class="ft2">1.</span><span class="ft34">Extract the organism names </span><nobr>(Swiss-Prot</nobr> OS ﬁeld) from the ﬁle ’uniprot.dat’, and save as the ﬁle ’uniprot.dat.os’:

yabby> sprot_os uniprot.dat uniprot.dat.os

Processing the database file ’uniprot.dat’ ..

Printing a dot per 10000 processed sequences:

............................................................

............................................................

............................................................

............................................................

............................................................

............................................................

............................................................

............................................................

...............................................

All done.

Requirements: None

Creates objects: None

System scripts: None

<span class="ft16">3.4</span><span class="ft17">HMMER commands</span>

<span class="ft21">3.4.1</span><span class="ft48">hmm score extract</span>

</div>

<div id="id_2">

Fetches hits from the HMMER (HMMPFAM) search output ﬁle.

</div>

</div>

<div id="page_80">

<div id="dimg1">![](yabby_images/yabby80x1.jpg)</div>

| 

3.4\. HMMER commands

 | 

75

 |

Usage:

hmm score extract [ options ] HMMPFAM OUT

Where HMMPFAM OUT is the HMMPFAM output ﬁle.

Options:

<nobr>-E</nobr> CUTOFF – Deﬁne cutoﬀ for acceptable E values (default: 0.01)

<nobr>-s</nobr> HMM ITEM – Save the scores under the name HMM ITEM

<nobr>-d</nobr> – Turn debuggin on. This will create the ﬁle hmm scores.opt d ﬂag with raw scores.

Notes: <span class="ft2">None</span>

Examples:

<span class="ft41">1\. </span>yabby> hmm_score_extract <nobr>-E</nobr> 0.01 <nobr>-s</nobr> hits hmmpfam.out

Processing HMMPFAM search output file

No Sequence <nobr>E-score</nobr>

<nobr>-----------------------------------------------------</nobr>

| 

(

 | 

1)

 | 

LmjF05.1190@All

 | 

<nobr>2.70e-03</nobr>

 |
| 

(

 | 

2)

 | 

LmjF05.1190@GlycogenStarch

 | 

<nobr>4.20e-03</nobr>

 |
| 

(

 | 

3)

 | 

LmjF05.0920@All

 | 

<nobr>7.50e-03</nobr>

 |

Requirements: <span class="ft2">None</span>

Creates objects: (with option <nobr>-s)</nobr> hmm score

System scripts: <span class="ft2">None</span>

<span class="ft21">3.4.2</span><span class="ft48">hmm score2seq</span>

Fetches and saves sequences whose ID’s are given in the HMM scores objects created by the command ’hmm score extract’.

Usage:

hmm score2seq [ options ] DBA FILE OUT FILE OBJ NAME

Where DBA FILE is the sequence database, OUT FILE is the output ﬁle with sequences (to be created), and OBJ NAME is the name under which the scores were saved with ’hmm score extract’.

Options:

<nobr>-w</nobr> WIDTH – Set the width of the sequence string per line written to the OUT FILE (default: width=60)

</div>

<div id="page_81">

<div id="dimg1">![](yabby_images/yabby81x1.jpg)</div>

| 

76

 | 

Chapter 3\. Command reference

 |

<nobr>-m</nobr> MODEL – Extract only sequences that matched a particular HMM model. If this option is not activated all matches are written to the output ﬁle and sequence IDs are written as SEQIDPFAM MODEL. If this option is activated the sequence IDs are written only as SEQID.

<nobr>-n</nobr> NUMBER – Crop sequences extracted to at most NUMBER of sequences.

<nobr>-c</nobr> – Do NOT embed the matching model and maching score into sequence comment.

Notes:

1\. Sequence database ﬁle DBA FILE must be in FASTA format.

Examples:

<span class="ft2">1\. </span>yabby> hmm_score2seq LmjFmockup.pep hits.fas hits

found 3 sequences to extract

Processing the database ’LmjFmockup.pep’ Sequences written to ’hits.fas’

Requirements: hmm score

Creates objects: None

System scripts: None

<span class="ft16">3.5</span><span class="ft17">Sequence motifs commands</span>

<span class="ft21">3.5.1</span><span class="ft48">motif load</span>

Loads sequence motif.

Usage:

motif load [ options ] DBA FILE OBJ NAME

Where DBA FILE is the name of the database ﬁle. OBJ NAME is the internal YABBY name for this motif.

Options:

<nobr>-f</nobr> – the ﬁle format is FASTA (default)

<nobr>-b</nobr> – the ﬁle format is BLOCKS

Notes:

<span class="ft2">1.</span><span class="ft34">A ’motif’ object is internally identical to the ’sequence’ object.</span>

<span class="ft2">2.</span><span class="ft34">Only BLOCKS format as given by MEME output was tested.</span>

</div>

<div id="page_82">

<div id="dimg1">![](yabby_images/yabby82x1.jpg)</div>

<div id="id_1">

| 

3.5\. Sequence motifs commands

 | 

77

 |

Examples:

<span class="ft2">1\. </span>yabby> motif_load <nobr>-b</nobr> m2.blocks m2

Reading the file ’m2.blocks’ ..

11 sequence(s) found in the motif ’m2’.

Requirements: None

Creates objects: motif

System scripts: None

<span class="ft21">3.5.2</span><span class="ft48">motif cmp</span>

Compares two sequence motifs.

Usage:

motif cmp MOTIF1 OBJ MOTIF2 OBJ

Compares two motifs. Two motifs are identical if they have the same number of sequences, the sequences have the same ID, and the sequences themselves are identical as strings.

Options: None

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> motif_cmp m2 m2_second

Motifs ’m2’ and ’m2_second’ contain the same sequence IDs.

Comparing the sequences...

Motifs ’m2’ and ’m2_second’ are identical.

Requirements: motif

Creates objects: None

System scripts: None

<span class="ft21">3.5.3</span><span class="ft48">motif meme</span>

</div>

<div id="id_2">

Extracts motifs from MEME text output ﬁles.

</div>

</div>

<div id="page_83">

<div id="dimg1">![](yabby_images/yabby83x1.jpg)</div>

| 

78

 | 

Chapter 3\. Command reference

 |

Usage:

motif meme MEME OUTPUT MOTIF NUMBER OBJ NAME

Reads the output ﬁle MEME OUTPUT, extracts motif number MOTIF NUMBER and saves motif as OBJ NAME.

Options: None

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> motif_meme meme.out 1 m1

Reading MEME output ’meme.out’ ..

Motif 1 saved as ’m1’.

Requirements: None

Creates objects: motif

System scripts: None

<span class="ft16">3.6</span><span class="ft17">BLAST commands</span>

<span class="ft21">3.6.1</span><span class="ft48">blast</span>

Runs NCBI BLAST against a database.

Usage:

blast [ options ] DBA FILE OBJ NAME

Where DBA FILE is the sequence database and OBJ NAME is the name of the sequence object which contains the query sequence. If OBJ NAME contains more than one sequence, all will be used in turn as a query sequence.

Options:

<nobr>-E</nobr> E VALUE – Sets the expectation value for BLAST (default=0.01)

Notes:

<span class="ft2">1.</span><span class="ft34">This command runs the NCBI program ‘blastall’</span>

<span class="ft2">2.</span><span class="ft34">The full PATH to ‘blastall’ is deﬁned in yabby blast.pm</span>

Examples:

</div>

<div id="page_84">

<div id="dimg1">![](yabby_images/yabby84x1.jpg)</div>

| 

3.6\. BLAST commands

 | 

79

 |

<span class="ft2">1\. </span>yabby> blast <nobr>-E</nobr> 5.0 LmjFmockup.pep cad3

3 sequence(s) found in the object ’cad3’

Now running BLAST ..

BLASTing sequence 1 of 3 (Q53650_STAAU)

Query sequence ’Q53650_STAAU’

Database ’LmjFmockup.pep’

Found 3 hits above the threshold (E=5.00)

The best hit: ’LmjF05.1170’

<nobr>E-score</nobr> = 2.22e+00

BLASTing sequence 2 of 3 (Q97PJ0_STRPN)

Query sequence ’Q97PJ0_STRPN’

Database ’LmjFmockup.pep’

Found 1 hits above the threshold (E=5.00)

The best hit: ’LmjF05.0950’

<nobr>E-score</nobr> = 2.92e+00

BLASTing sequence 3 of 3 (P95773_STALU)

Query sequence ’P95773_STALU’

Database ’LmjFmockup.pep’

No BLAST hits above the threshold (E=5.00) found.

Requirements: None

Creates objects: None

System scripts: None

<span class="ft21">3.6.2</span><span class="ft48">blast info</span>

Prints the information about the BLAST search previously generated by the ‘blast’ command.

Usage:

blast info OBJ NAME

Where OBJ NAME is the name of an existing blast object.

Options: None

Notes: None

Examples:

</div>

<div id="page_85">

<div id="dimg1">![](yabby_images/yabby85x1.jpg)</div>

| 

80

 | 

Chapter 3\. Command reference

 |

<span class="ft2">1\. </span>yabby> blast_info cad3_1

Query sequence ’Q53650_STAAU’

Database ’LmjFmockup.pep’

Found 3 hits above the threshold (E=5.00)

The best hit: ’LmjF05.1170’

<nobr>E-score</nobr> = 2.22e+00

Requirements: blast

Creates objects: None

System scripts: None

<span class="ft21">3.6.3</span><span class="ft48">blastg</span>

Runs NCBI BLAST against a database and saves the best hit for each sequence.

Usage:

blastg [ options ] DBA FILE OBJ NAME

Where DBA FILE is the sequence database and OBJ NAME is the name of the sequence object which contains sequences to be blasted. Each sequence is in turn blasted against the database, and the top hit is stored as BLASG object. This object contains the list of:

SEQ ID DBA SEQ ID E VALUE

Where SEQ ID is the sequence ID, DBA SEQ ID is the best hits database sequence ID, and E VALUE is the <nobr>E-value</nobr> of the match.

Options:

<nobr>-E</nobr> E VALUE – Sets the expectation value for BLAST (default=0.01)

Notes:

<span class="ft2">1.</span><span class="ft34">This command is experimental. Originally it was used to blast one genome against another, to obtain a quick estimate of the similarity between two genome.</span>

Examples:

<span class="ft2">1\. </span>yabby> blastg <nobr>-E</nobr> 5.0 LmjFmockup.pep cad3

3 sequence(s) found in the object ’cad3’

Now running BLAST ..

BLASTing sequence 1 of 3 (Q53650_STAAU) top hit LmjF05.1170, <nobr>E-score</nobr> = 2.22e+00

</div>

<div id="page_86">

<div id="dimg1">![](yabby_images/yabby86x1.jpg)</div>

| 

3.7\. Protein <nobr>three-dimensional</nobr> structure commands

 | 

81

 |

BLASTing sequence 2 of 3 (Q97PJ0_STRPN) top hit LmjF05.0950, <nobr>E-score</nobr> = 2.92e+00 BLASTing sequence 3 of 3 (P95773_STALU) top hit None, <nobr>E-score</nobr> = <nobr>-1.00e+00</nobr>

Requirements: None

Creates objects: None

System scripts: None

<span class="ft16">3.7</span><span class="ft17">Protein </span><nobr>three-dimensional</nobr> structure commands

<span class="ft21">3.7.1</span><span class="ft48">mol load</span>

Loads a molecule from the PDB ﬁle.

Usage:

mol load [ options ] PDB FILE OBJ NAME

Loads the molecule from the PDB FILE and saves it under the name OBJ NAME.

Options:

<nobr>-u</nobr> – require strict Protein Data Bank format when reading the PDB ﬁle. This amounts to requiring that residue names have maximum of three characters (columns 18,19, and 20) of an ATOM or HETATM record. By default this behavior is disabled, and four letter residue names are expected (columns 18,19,20 and 21). This is safe in most cases as the extra column 21 is actually not deﬁned in the strict Protein Data Bank format.

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> mol_load 1BT0.pdb bto

661 atoms found in the molecule ’bto’

Requirements: None

Creates objects: mol

System scripts: None

</div>

<div id="page_87">

<div id="dimg1">![](yabby_images/yabby87x1.jpg)</div>

| 

82

 | 

Chapter 3\. Command reference

 |

<span class="ft21">3.7.2</span><span class="ft48">mol2seq</span>

Creates the amino acid sequence from a molecule.

Usage:

mol2seq OBJ NAME

where OBJ NAME is the name of an existing ’mol’ object. Options:

<nobr>-f</nobr> – print to a ﬁle. Notes:

1\. If no argument is given all will be printed. Examples:

<span class="ft2">1\. </span>yabby> mol2seq bto

WARNING: a <nobr>non-sequential</nobr> residue: 201 ZN WARNING: residue ’ZN’ does not have one letter code

...snip...

WARNING: residue ’HOH’ does not have one letter code 153 residues found in the molecule ’bto’

Requirements: mol

Creates objects: seq

System scripts: None

<span class="ft21">3.7.3</span><span class="ft48">pdb conv</span>

Converts Protein Data Bank coordinate ﬁles into XPLOR/CHARMM PDB format, with possible ﬁltering

Usage:

pdb conv [ options ] PDB INPUT PDB OUTPUT

This command reads Protein Data Bank ﬁle PDB INPUT and writes XPLOR/CHARMM PDB ﬁle PDB OUTPUT.

Options:

<nobr>-u</nobr> – require strict Protein Data Bank format when reading the PDB ﬁle. This amounts to requiring that residue names have maximum of three characters (columns 18,19, and 20) of an ATOM or HETATM record. By default this behavior is disabled, and four letter residue names are expected (columns 18,19,20 and 21). This is safe in most cases as the extra column 21 is actually not deﬁned in the strict Protein Data Bank format

</div>

<div id="page_88">

<div id="dimg1">![](yabby_images/yabby88x1.jpg)</div>

| 

3.7\. Protein <nobr>three-dimensional</nobr> structure commands

 | 

83

 |

<nobr>-f</nobr> FORMAT – use the format FORMAT when writing the PDB output ﬁle. Allowed formats are ’xplor’ (default) or ’charmm’. The diﬀerence between the two is subtle, and occurs only for residues which have a residue number greater than 999

<nobr>-l</nobr> ALT LOC – write atoms with the alternative location ﬁeld equal to ALT LOC, together with those without ALT LOC label. In some structures only a subset of atoms is found in two alter- native locations, and therefore only a subset of atoms has ALT LOC ﬁelds set to distinguish the two positions

<nobr>-m</nobr> CHAIN ID – write only atoms with the chain ID equal to CHAIN ID

<nobr>-i</nobr> SEGID – replace the segment name with SEGID

<nobr>-h</nobr> – discard hydrogens, i.e. all atoms whose names begin with either the letter ’H’ (case insensitive) or a number

<nobr>-e</nobr> – discard HEATM records (by default HEATM records are included, and rewritten as ATOM records)

<nobr>-r</nobr> RBEGIN:OFFSET – Add oﬀset OFFSET to reside numbers starting with the residue number RBEGIN

Notes: <span class="ft2">None</span>

Examples:

1.

Requirements: <span class="ft2">None</span>

Creates objects: <span class="ft2">None</span>

System scripts: <span class="ft2">None</span>

<span class="ft21">3.7.4</span><span class="ft48">pdb model</span>

Splits Protein Data Bank ﬁle with multiple models into multiple XPLOR PDB ﬁles

Usage:

pdb model [ options ] PDB INPUT MODEL ROOT

PDB INPUT is the Protein Data Bank ﬁle which contains multiple models (separated with MODEL/ENDMDL statements), and MODEL ROOT is the root name for the CHARMM/XPLOR PDB ﬁles to be cre-

ated (one ﬁle per model). The ﬁnal ﬁle names will be MODEL ROOT 1.pdb, MODEL ROOT 2.pdb, etc. until all models are exausted.

Options:

<nobr>-u</nobr> – require strict Protein Data Bank format when reading the PDB ﬁle. This amounts to requiring that residue names have maximum of three characters (columns 18,19, and 20) of an ATOM or HETATM record. By default this behavior is disabled, and four letter residue names are expected (columns 18,19,20 and 21). This is safe in most cases as the extra column 21 is actually not deﬁned in the strict Protein Data Bank format

</div>

<div id="page_89">

<div id="dimg1">![](yabby_images/yabby89x1.jpg)</div>

| 

84

 | 

Chapter 3\. Command reference

 |

<nobr>-f</nobr> FORMAT – use the format FORMAT when writing the PDB output ﬁle. Allowed formats are ’xplor’ (default) or ’charmm’. The diﬀerence between the two is subtle, and occurs only for residues which have a residue number greater than 999

<nobr>-l</nobr> ALT LOC – write atoms with the alternative location ﬁeld equal to ALT LOC, together with those without ALT LOC label. In some structures only a subset of atoms is found in two alter- native locations, and therefore only a subset of atoms has ALT LOC ﬁelds set to distinguish the two positions

<nobr>-m</nobr> CHAIN ID – write only the molecule with the chain ID equal to CHAIN ID

<nobr>-i</nobr> SEGID – replace the segment name with SEGID

<nobr>-h</nobr> – discard hydrogens, i.e. all atoms whose names begin with either the letter ’H’ (case insensitive) or a number

<nobr>-e</nobr> – discard HEATM records (by default HEATM records are included, and rewritten as ATOM records)

<nobr>-r</nobr> RBEGIN:OFFSET – Add oﬀset OFFSET to reside numbers starting with the residue number RBEGIN

Notes: <span class="ft2">None</span>

Examples:

<span class="ft18">1.</span><span class="ft56">The ﬁle 1C3T.pdb contain 20 structures of ubiquitin, available from the RCSB Protein Data Bank.</span>

yabby> pdb_model 1C3T.pdb ubq_

working on model 1 (creating ’ubq_1.pdb’) working on model 2 (creating ’ubq_2.pdb’) working on model 3 (creating ’ubq_3.pdb’) working on model 4 (creating ’ubq_4.pdb’) working on model 5 (creating ’ubq_5.pdb’) working on model 6 (creating ’ubq_6.pdb’) working on model 7 (creating ’ubq_7.pdb’) working on model 8 (creating ’ubq_8.pdb’) working on model 9 (creating ’ubq_9.pdb’) working on model 10 (creating ’ubq_10.pdb’) working on model 11 (creating ’ubq_11.pdb’) working on model 12 (creating ’ubq_12.pdb’) working on model 13 (creating ’ubq_13.pdb’) working on model 14 (creating ’ubq_14.pdb’) working on model 15 (creating ’ubq_15.pdb’) working on model 16 (creating ’ubq_16.pdb’) working on model 17 (creating ’ubq_17.pdb’) working on model 18 (creating ’ubq_18.pdb’) working on model 19 (creating ’ubq_19.pdb’) working on model 20 (creating ’ubq_20.pdb’)

</div>

<div id="page_90">

<div id="dimg1">![](yabby_images/yabby90x1.jpg)</div>

| 

3.8\. EMBOSS commands

 | 

85

 |

20 models found

yabby>

Requirements: None

Creates objects: None

System scripts: None

<span class="ft16">3.8</span><span class="ft17">EMBOSS commands</span>

<span class="ft21">3.8.1</span><span class="ft48">emboss needle</span>

Extracts sequences which have the highest similarity from he output of the EMBOSS program ’needle’.

Usage:

emboss needle NEEDLE OUTPUT NN

Where NEEDLE OUTPUT is the output ﬁle of the program ’needle’, and NN is the number of highest alignments to report (as given by the ’Similarity’ line in the needle output).

Options: None

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> emboss_needle needle.out 3

Processing the file ’needle.out’ ..

<span class="ft25">(1)</span><span class="ft31">Q45153_BACFI:LmjF05.1170, Similarity: 26.6</span>

<span class="ft25">(2)</span><span class="ft31">Q45153_BACFI:LmjF05.1120, Similarity: 16.4</span>

<span class="ft25">(3)</span><span class="ft31">Q45153_BACFI:LmjF05.1040, Similarity: 15.0</span>

Requirements: None

Creates objects: None

System scripts: None

</div>

<div id="page_91">

<div id="dimg1">![](yabby_images/yabby91x1.jpg)</div>

<div id="id_1">

| 

86

 | 

Chapter 3\. Command reference

 |

<span class="ft21">3.8.2</span><span class="ft48">emboss needl2</span>

For each sequence in a set ﬁnds the best matching sequence from the database by running the EMBOSS program needle. Uses the information on sequence similarity reported by needle.

Usage:

emboss needl2 SEQ QUERY SEQ DBA OBJ NAME

Where SEQ QUERY is an existing yabby sequence object, SEQ DBA is the FASTA database ﬁle with sequences to be compared, and OBJ NAME is the name of the ’needl2’ object to be created.

Options:

None - Uncomment this and delete line below if no notes

Notes:

1\. This command requires the EMBOSS program ’needle’

Examples:

<span class="ft2">1\. </span>yabby> emboss_needl2 ec057 Ecoli_lab.fas ec

’ec057’ contains 9 sequence(s) Working on sp|P36546|OMPX_ECOLI <nobr>Needleman-Wunsch</nobr> global alignment.

Working on tr|Q8X8K6|Q8X8K6 <nobr>Needleman-Wunsch</nobr> global alignment.

Working on sp|P39170|UP05_ECOLI <nobr>Needleman-Wunsch</nobr> global alignment.

Working on tr|Q8XDF1|Q8XDF1 <nobr>Needleman-Wunsch</nobr> global alignment.

Working on sp|P58603|OMPT_ECO57 [... further output deleted ...]

Requirements: seq (for SEQ QUERY)

Creates objects: needl2

System scripts: None

<span class="ft16">3.9</span><span class="ft17">Miscellaneous commands</span>

<span class="ft21">3.9.1</span><span class="ft48">pfam fetch</span>

</div>

<div id="id_2">

Fetches an entry from the PFAM database ﬁle.

</div>

</div>

<div id="page_92">

<div id="dimg1">![](yabby_images/yabby92x1.jpg)</div>

| 

3.9\. Miscellaneous commands

 | 

87

 |

Usage:

pfam fetch PFAM CODE PFAM DBA FILE NAME

Where PFAM CODE is the PFAM accession code, PFAM DBA is the PFAM database, and FILE NAME is the ﬁle to save the entry. For example, to fetch the entry PF00293 from the PFAM database <nobr>Pfam-A.seed,</nobr> and save it as PF00293.seed:

pfam fetch PF00293 <nobr>Pfam-A.seed</nobr> PF00293.full

Options: None

Notes: None

Examples:

1.

Requirements: None

Creates objects: None

System scripts: None

<span class="ft21">3.9.2</span><span class="ft48">sprot split</span>

Splits large sequence database written in <nobr>SWISS-PROT</nobr> format into smaller ﬁles. This command is useful when a large <nobr>SWISS-PROT</nobr> ﬁle needs to be reformatted with an external programs (such as ’sreformat’), which have a limitation on the ﬁle size.

Usage:

sprot split [ options ] DBA FILE

Where DBA FILE is the name of the sequence database ﬁle in the <nobr>SWISS-PROT</nobr> format. The output ﬁles are named DBA FILE.1, DBA FILE.2, etc.

Options:

<nobr>-n</nobr> NLINES – split the database into ﬁles approx NLINES each (default: NLINES = 20000000).

Notes: None

Examples:

<span class="ft2">1\. </span>yabby> sprot_split uniprot_trembl.dat

Reading the database file ’uniprot_trembl.dat’ .. The number of lines in the database: 204071661 <nobr>-></nobr> Creating ’uniprot_trembl.dat.1’

<nobr>-></nobr> Creating ’uniprot_trembl.dat.2’ <nobr>-></nobr> Creating ’uniprot_trembl.dat.3’ <nobr>-></nobr> Creating ’uniprot_trembl.dat.4’

</div>

<div id="page_93">

| 

88

 | 

Chapter 3\. Command reference

 |

<nobr>-></nobr> Creating ’uniprot_trembl.dat.5’ <nobr>-></nobr> Creating ’uniprot_trembl.dat.6’ <nobr>-></nobr> Creating ’uniprot_trembl.dat.7’ <nobr>-></nobr> Creating ’uniprot_trembl.dat.8’ <nobr>-></nobr> Creating ’uniprot_trembl.dat.9’ <nobr>-></nobr> Creating ’uniprot_trembl.dat.10’ <nobr>-></nobr> Creating ’uniprot_trembl.dat.11’

Requirements: None

Creates objects: A number of smaller sequence database ﬁle.

System scripts: None

</div>

<div id="page_94">

<div id="id_1">

Bibliography

<span class="ft6">[1]</span><span class="ft60">Stajich JE, Block D, Boulez K, Brenner SE, Chervitz SA, Dagdigian C, Fuellen G, Gilbert JG, Korf I, Lapp H, Lehvaslaiho H, Matsalla C, Mungall CJ, Osborne BI, Pocock MR, Schattner P, Senger M, Stein LD, Stupka E, Wilkinson MD, and Birney E. The Bioperl toolkit: Perl modules for the life sciences. Genome Res, </span><nobr>12(10):1611–8,</nobr> 2002.

<span class="ft6">[2]</span><span class="ft61">Bailey TL, Williams N, Misleh C, and Li WW. MEME: discovering and analyzing DNA and protein sequence motifs. Nucleic Acids Res, </span><nobr>34:W369–73,</nobr> 2006.

<span class="ft6">[3]</span><span class="ft61">Eddy SR. Proﬁle hidden Markov models. Bioinformatics, </span><nobr>14(9):755–63,</nobr> 1998.

<span class="ft6">[4]</span><span class="ft61">HMMER. http://hmmer.janelia.org/.</span>

<span class="ft6">[5]</span><span class="ft61">NCBI BLAST Web interface. http://www.ncbi.nlm.nih.gov/BLAST/.</span>

<span class="ft6">[6]</span><span class="ft61">NCBI BLAST programs download. ftp://ftp.ncbi.nih.gov/blast/.</span>

<span class="ft6">[7]</span><span class="ft61">Rice P, Longden I, and Bleasby A. EMBOSS: the European Molecular Biology Open Software Suite. Trends Genet, </span><nobr>16(6):276–7,</nobr> 2000.

</div>

<div id="id_2">

89

</div>

</div>

<div id="page_95">

| 

90

 | 

BIBLIOGRAPHY

 |

</div>

<div id="page_96">

<div id="dimg1">![](yabby_images/yabby96x1.jpg)</div>

<div id="id_1">

<div id="id_1_1">

Index

blast, 78 blast info, 79 blastg, 80

delete, 31, 57 dump, 32, 58

emboss, 37

emboss needl2, 38, 86 emboss needle, 37, 85

ﬂush, 31, 58

help, 30, 60

hmm score2seq, 34, 75 hmm score extract, 34, 74 HMMER, 34 HMMPFAM, 34

installation, 2

license, 59

MEME, 33 mol2seq, 82 mol load, 81

motif cmp, 33, 77 motif load, 32, 76 motif meme, 33, 77

pdb conv, 82 pdb model, 83 pdb model.pl, 40 Perl, 2

pfam fetch, 86 print, 16, 60

restore, 32, 62

seq comment, 21, 63

</div>

<div id="id_1_2">

seq compl, 22, 64 seq genbank, 23, 64 seq info, 18, 65

seq load, 15, 66 seq op, 20, 67 seq os, 23, 67

seq pattern, 19, 68 seq pick, 18, 69 seq sprot os, 26, 70 seq strip, 19, 71 seq uniprot, 72

seq unique, 22, 72 sequence motifs, 32 sequences, 15 sprot fetch, 26, 73 sprot os, 29, 74 sprot split, 87

system requirements, 2

unix commands, 7

what, 16, 62

</div>

</div>

<div id="id_2">

91

</div>

</div>
