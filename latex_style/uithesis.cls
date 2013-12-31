% -*- mode: LaTeX; -*-
%
% ------------------------ identification -----------------------------
% Created by Paul Henning <paul-henning@uiowa.edu>
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\ProvidesClass{uithesis}[1999/04/16 Univ. of Iowa Thesis Class]
% ChangeLog
% December 19, 2013 Andrew Reynolds AJR (andrew.j.reynolds@gmail.com)
%    * Fixed appendix line in table of contents.  
%      Made phd abstract optional, since it is no longer required.
%
% December 31, 2012 Duckki Oe (duckki-oe@uiowa.edu)
%    * Updated this sytle conforming the July 2012 standard.
%      I made some formatting changes in TOC, figure, and
%      bibliography, so you can code as natural as you can and
%      the output can meet the standard.
%      Other big change is simplifying the directory structure
%      by not relying on separate files with specific names.
%      Users can choose how to organize their tex files.
%
% Friday April 9 2010 Ray Hylock <ray-hylock@uiowa.edu>
%    * Commented out \setlength{\headrulewidth}{0pt} because it
%      prints out in next to the titles as 0.4pt0pt.  Changed
%      declarations of notables and nofigures to tables and
%      figures.  Now, instead of having them by default, you must
%      specify using them; it seems more logical this way. Also,
%      I've added algorithm, examples, lemmas, and theorem
%      declarations in the same manner as table and figures
%      specified above.  I then rewrote the inclusion of these
%      in the frontmatter command. Added two more subsections
%      defintions: paragarph and subparagrph to the headers.  The
%      thesis manual allows for six layers, this gets us to six
%      (chapter, section, subsection, subsubsection, paragraph,
%      and subparagraph). Also, added funcationality in prelude
%      and cls file to allow for multiple supervisors (currently
%      only supports 1 or 2 supervisors). The acknowledgement page
%      is optional again so I added the appropriate code in the
%      frontmatter section. Finally, I've added functionality to
%      control the depth of the TOC just about the \tableofcontents
%      command in the frontmatter section.
%
% Mon Jun 24 2002 Mike McLendon <michael-mclendon@uiowa.edu>
%    * Changed the text below the signature lines on the thesis
%      signature page.  The old style was not to include the
%      actual names of the committee members, the five signature
%      lines were labeled "Thesis Supervisor", "Member", "Member",
%      "Member", and "Member".  Now these lines pull their labels
%      from the variables "memberOne" through "memberFive" as
%      defined in "prelude.tex" with the committee members' names.
%
% Thu Jun 13 2002 Mike McLendon <michael-mclendon@uiowa.edu>
%    * adjusted margins to reflect the new margin requirements
%      in the 2002 update of the Grad College's Thesis Manual
%      changes include reducing the top margin, reducing the
%      distance from top/bottom to the page number, and
%      reducing the distance from the top of the page to the
%      chapter title.  i commented out the old margins below
%      in case they change them again
% Sat Apr 20 2002 Mike McLendon <michael-mclendon@uiowa.edu>
%    * changed the line breaking of the single spaced text
%      on the abstract title page to match the line breaking of
%      the similar text on the thesis title page
% Wed Apr 28 10:52:18 CDT 1999  Paul Henning <phenning@cs.uiowa.edu>
%    * Lots of spacing fixes.  The new value for \li was determined by
%      printing out \baselineskip in the middle of a paragraph and
%      dividing by two.
% Wed Apr 21 17:43:58 CDT 1999  Paul Henning <phenning@cs.uiowa.edu>
%    * Corrected  the text of the abstract signature page.
% Fri Apr 16 23:16:28 MDT 1999  Paul Henning <phenning@lanl.gov>
%    * Changed the spacing between entries on the list of
%      figures/tables. It should be double space between the title
%	    and the column headings, and a double space between each entry.
%      If I still don't have it correct, tweek the \vspace{1.2\li}
%	    found in the \renewcommand{\l@figure} and \renewcommand{\l@table}
%	    commands.  Why 1.2?  Because thats how it matched up by hand.
%	    I know that latex is slipping some vertical glue in there, but
%      it should only expand by a little bit.
%
% Tue Mar 30 16:22:51 CST 1999  Pete Willemsen <willemsn@cs.uiowa.edu>
%    * Fixed a numbering style problem - phd abstract page uses arabic
%    * Had to move \singlespace into the minipage on the phd abstract
%      pages in order to achieve both the required doublespaceing of the
%      abstract and the necessary 4 single space lines below
%      heading - don't really know why.
%
% Tue Mar 30 13:45:47 CST 1999  Pete Willemsen <willemsn@cs.uiowa.edu>
%    * Added support for the PhD abstract pages.  \abstractfile{ FILE }
%      specifies the abstract to be used.  If the thesis is a PhD
%      thesis, the PhD Abstract Title Page is included.  Also, by
%      specifying abstractpage in the documentclass line, a copy
%      of the abstract is included for binding with the complete
%      dissertation
%
% Wed Feb 24 14:28:40 CST 1999  Pete Willemsen <willemsn@cs.uiowa.edu>
%    * Added support for copyright page.  To enable, define copyrightpage
%      in the documentclass line.  Also, define \copyrightyear{}.
%    * Added support for a dedication page.  To enable, define
%      dedicationpage in the documentclass line.  To specify the dedication,
%      define \dedication{} in the preamble.
%
% Wed Jun 24 11:15:25 CDT 1998  Kenny Hunt <hunt@cs.uiowa.edu>
%    * added an \intextsep for spacing around [m] figures
%
% Tue Jun 23 15:55:21 CDT 1998  Paul Henning <paul-henning@uiowa.edu>
%    * Fixed a doublespacing problem after the acknowledgements page
%    * Renewed the \appendix command to have it add a ``header'' in
%      in the table of contents
%    * Made \caption do the appropriate thing so I can eliminate
%      the \Caption command
%    * Changed the \belowcaptionskip modification to \textfloatsep
%      in the vain hopes that this will put separation above bottom
%      floats
%
% Mon Jun 22 16:06:26 CDT 1998  Paul Henning <paul-henning@uiowa.edu>
%    * Added support for an acknowledgements page through the
%      \ackfile preamble command
%
% ------------------------- initial code ------------------------------
\RequirePackage{ifthen} \newboolean{phd} % This is a Ph.D. thesis
\newboolean{phdabstract} % AJR : Include an abstract with Ph.D. thesis
\newboolean{nofrontmatter} % Skip everything before the index
\newboolean{figures} % There are figures (list of figures)
\newboolean{tables} % There are tables (list of tables)
\newboolean{algorithms} % There are algorithms (list of algorithms)
\newboolean{examples} % There are examples (list of examples)
\newboolean{lemmas} % There are lemmas (list of lemmas)
\newboolean{theorems} % There are theorems (list of theorems)
\newboolean{exampleslemmas} % There are examples and lemmas in one list (list of examples and lemmas)
\newboolean{examplestheorems} % There are examples and theorems in one list (list of examples and theorems)
\newboolean{exampleslemmastheorems} % There are examples, lemmas, and theorems in one list (list of examples, lemmas, and theorems)
\newboolean{lemmastheorems} % There are lemmas and theorems in one list (list of lemmas and theorems)
\newboolean{appendix} % There is an appendix
\newboolean{ackpage} % There is an acknowledgement page
\newboolean{abtitlepage} % There is an abstract title pg (required for Ph.D.) Not an option anymore!
\newboolean{abstractpage} % There is an abstract page
\newboolean{copyrightpage} % There is a copyright page
\newboolean{dedicationpage} % There is a dedication page
\newboolean{epigraphpage} % There is a epigraph/frontspiece page
% --------------------- declaration of options ------------------------
% if passed in the thesis.tex document class declaration, then true
\DeclareOption{phd}{\setboolean{phd}{true}}
\DeclareOption{phdabstract}{\setboolean{phdabstract}{true}}
\DeclareOption{nofrontmatter}{\setboolean{nofrontmatter}{true}}
\DeclareOption{figures}{\setboolean{figures}{true}}
\DeclareOption{tables}{\setboolean{tables}{true}}
\DeclareOption{algorithms}{\setboolean{algorithms}{true}}
\DeclareOption{examples}{\setboolean{examples}{true}}
\DeclareOption{lemmas}{\setboolean{lemmas}{true}}
\DeclareOption{theorems}{\setboolean{theorems}{true}}
\DeclareOption{exampleslemmas}{\setboolean{exampleslemmas}{true}}
\DeclareOption{examplestheorems}{\setboolean{examplestheorems}{true}}
\DeclareOption{exampleslemmastheorems}{\setboolean{exampleslemmastheorems}{true}}
\DeclareOption{lemmastheorems}{\setboolean{lemmastheorems}{true}}
\DeclareOption{appendix}{\setboolean{appendix}{true}}
\DeclareOption{abstractpage}{\setboolean{abstractpage}{true}}
\DeclareOption{copyrightpage}{\setboolean{copyrightpage}{true}}
\DeclareOption{dedicationpage}{\setboolean{dedicationpage}{true}}
\DeclareOption{epigraphpage}{\setboolean{epigraphpage}{true}}
\DeclareOption{11pt}{}% Eat up attempts to change to 11pt
\DeclareOption{12pt}{}% Grab this so we don't pass it twice
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
% ------------------------ option parsing -----------------------------
\ProcessOptions
% --------------------- package loading -------------------------------
\LoadClass[12pt]{report}[1995/06/26]
\RequirePackage{fancyheadings,indentfirst}
\usepackage{algorithmic}
\usepackage[ruled,chapter]{algorithm}
\usepackage[toc,page,titletoc]{appendix}
% Vertical spacing in itemset and enumerate
\usepackage{enumitem}
% added by Duckki
\usepackage{chngcntr}
\usepackage[labelsep=period]{caption}
% --------------------------  main code -------------------------------
\normalsize
%
% margin settings before june 2002
%
% Top margin
%\newlength{\uittmarg}\setlength{\uittmarg}{1.25in}
% Left margin
%\newlength{\uitlmarg}\setlength{\uitlmarg}{1.5in}
% Right margin
%\newlength{\uitrmarg}\setlength{\uitrmarg}{1.0in}
% Bottom margin
%\newlength{\uitbmarg}\setlength{\uitbmarg}{1in}
% Distance from bottom of page to preliminary page nums
%\newlength{\uitppage}\setlength{\uitppage}{0.75in}
% Distance of normal page number from the top
%\newlength{\uittpage}\setlength{\uittpage}{0.75in}
% Distance of normalpage number from the right
%\newlength{\uitrpage}\setlength{\uitrpage}{1in}
% Distance from top of page to chapter title
%\newlength{\uitchap}\setlength{\uitchap}{2in}

%
% new margin settings, june 2002, mike mclendon
% i made these changes because of changes made
% to the graduate college's thesis handbook
%
% Top margin
\newlength{\uittmarg}\setlength{\uittmarg}{1.0in}
% Left margin
\newlength{\uitlmarg}\setlength{\uitlmarg}{1.5in}
% Right margin
\newlength{\uitrmarg}\setlength{\uitrmarg}{1.0in}
% Bottom margin
\newlength{\uitbmarg}\setlength{\uitbmarg}{1in}
% Distance from bottom of page to preliminary page nums
\newlength{\uitppage}\setlength{\uitppage}{0.5in}
% Distance of normal page number from the top
\newlength{\uittpage}\setlength{\uittpage}{0.5in}
% Distance of normalpage number from the right
\newlength{\uitrpage}\setlength{\uitrpage}{1in}
% Distance from top of page to chapter title
\newlength{\uitchap}\setlength{\uitchap}{1in}


% Don't play with these lengths!
\newlength{\li}\setlength{\li}{14.48pt}
\setlength{\hoffset}{-1in}
\setlength{\voffset}{-1in}

\setlength{\topmargin}{\uittpage}
\setlength{\headheight}{12pt}
\setlength{\headsep}{\uittmarg}
\addtolength{\headsep}{-\topmargin}
\addtolength{\headsep}{-\headheight}

\setlength{\oddsidemargin}{\uitlmarg}
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-\uitlmarg}
\addtolength{\textwidth}{-\uitrmarg}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-\uittmarg}
\addtolength{\textheight}{-\uitbmarg}
\addtolength{\textheight}{-\li}

\setlength{\footskip}{\uitbmarg}
\addtolength{\footskip}{-\uitppage}
\addtolength{\footskip}{\li}


\newlength{\uitchapadd}\setlength{\uitchapadd}{\uitchap}
\addtolength{\uitchapadd}{-\uittmarg}
\addtolength{\uitchapadd}{-\li}

\setlength{\parindent}{0.5in}

\newlength{\uitrule}

\pagestyle{fancyplain}
\addtolength{\headwidth}{\uitrmarg}
\addtolength{\headwidth}{-\uitrpage}

% fix footnote style to reflect the thesis manual (Willemsen)
%
% hopefully, this will make footnote a 10pt font when the normal text
% size is 12pt. So far, it appears to be ok.  Also, it makes the
% footnote contain single spacing within the footnote.
\renewcommand{\footnotesize}{\singlespace\small}
% now, need to make area between footnotes double space ???
\setlength{\footnotesep}{20pt}
%\setlength{\footskip}{24pt}



% This sets up the page numbering for the prefix material
\newcommand{\uitprefixpg}{
\pagenumbering{roman}
\lhead{}\chead{}\rhead{}
\lfoot{}\cfoot{\fancyplain{\thepage}{\thepage}}\rfoot{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this resutls in a printout in the document of 0.4pt0pt
%\setlength{\headrulewidth}{0pt}
\renewcommand{\headrule}{}
\renewcommand{\footrule}{}
}


%
% DOCABPREFIXPG - This sets up the page numbering for the
%                 doctoral abstract pages - Arabic numbering
%                 in the upper right corner.
%
\newcommand{\docabprefixpg}{
\pagenumbering{arabic}
\lhead{}\chead{}\rhead{\fancyplain{\thepage}{\thepage}}
\lfoot{}\cfoot{}\rfoot{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this resutls in a printout in the document of 0.4pt0pt
%\setlength{\headrulewidth}{0pt}
\renewcommand{\headrule}{}
\renewcommand{\footrule}{}
}


% This sets up the page numbering for text and references
\newcommand{\uitnormalpg}{
\clearpage
\pagenumbering{arabic}
\rhead{\fancyplain{\thepage}{\thepage}}
\chead{}\lhead{}\lfoot{}\cfoot{}\rfoot{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this resutls in a printout in the document of 0.4pt0pt
%\setlength{\headrulewidth}{0pt}
\renewcommand{\headrule}{}
\renewcommand{\footrule}{}
}

% Interline spacing commands.  You have to issue a font change
% command, like \normalsize, before this change will take place
% by Duckki
%\newcommand{\singlespace}{\renewcommand{\baselinestretch}{1.0}}
%\newcommand{\doublespace}{
%   \ifthenelse{\@ptsize = 0}%    10pt typeface as basesize
%      {\renewcommand{\baselinestretch}{1.67}\normalsize}{}
%   \ifthenelse{\@ptsize = 1}%    11pt typeface as basesize
%      {\renewcommand{\baselinestretch}{1.62}\normalsize}{}
%   \ifthenelse{\@ptsize = 2}%    12pt typeface as basesize
%      {\renewcommand{\baselinestretch}{2.0}\normalsize}{} %Should be 1.66
%}
\newcommand{\singlespace}{\baselineskip 1.1\li}
\newcommand{\doublespace}{\baselineskip 2.0\li}

%\setcounter{secnumdepth}{6}
\setcounter{secnumdepth}{3}	% by Duckki
\renewcommand{\chaptername}{CHAPTER}
\renewcommand{\bibname}{REFERENCES}
\renewcommand{\listfigurename}{LIST OF FIGURES}
\renewcommand{\listtablename}{LIST OF TABLES}
\renewcommand{\listalgorithmname}{LIST OF ALGORITHMS}
\renewcommand{\contentsname}{TABLE OF CONTENTS}
\renewcommand{\appendixname}{APPENDIX}

\renewcommand{\section}
  {\@startsection%
    {section}%
    {1}%
    {\z@}%                     % No indent, 'cause we are going to center
    {1.2\li}%                     % Skip one extra line from the text above
    {1pt}%                     % This is a kludge to force display heading
    {\reset@font\centering\normalsize\bfseries}}

\renewcommand{\subsection}
   {\@startsection
      {subsection}
       {2}%
       {\z@}%
       {1.2\li}%
       {1pt}%
       {\reset@font\centering\normalsize}}

\renewcommand{\subsubsection}
   {\@startsection
      {subsubsection}
       {3}%
       {\z@}%
       {1.2\li}%
       {1pt}%
       {\reset@font\normalsize\bfseries}}

%\renewcommand{\paragraph}
%   {\@startsection
%      {paragraph}
%       {4}%
%       {\z@}%
%       {\li}%
%       {1pt}%
%       {\reset@font\normalsize}}
%
%\renewcommand{\subparagraph}
%   {\@startsection
%      {subparagraph}
%       {5}%
%       {\z@}%
%       {\li}%
%       {1pt}%
%       {\reset@font\normalsize\itshape}}


% This redefinition of the thebibliography environment ensures that
% that there is at least 4 blank lines between the title and the
% first entry, and that there is a full blank line between each entry
\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname
        \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}%
      \addtocontents{toc}{\protect\vspace{\li}}%
      \addcontentsline{toc}{head}{\bibname}
      \singlespace\normalsize
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \parsep 0.65\li%    This forces more interline space
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m%
      \vspace{2\li}%  Throw in some more space after the title
   }


%
% Fix indention issues with algorithm list
%
\newcommand*\l@algorithm{\noindent\@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand\listofalgorithms{\if@twocolumn\@restonecoltrue\onecolumn
    \else\@restonecolfalse\fi
    \chapter*{\uppercase{\listalgorithmname}
    \@mkboth{\uppercase{\listalgorithmname}}{\uppercase{\listalgorithmname}}}
    \singlespace
    \@starttoc{loa}\if@restonecol\twocolumn\fi
}

% This redefinition of the chapter command is needed to get rid of
% some unwanted space being added to the lof and lot and ensures that
% chapter titles are uppercase everywhere
% \chapter[optional]{non-optional}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
      \refstepcounter{chapter}%
      \typeout{\@chapapp\space\thechapter.}%
      \addcontentsline{toc}{chapter}%
         {\protect\numberline{\thechapter}\uppercase{#1}}%
      \addtocontents{toc}{\protect\vspace{\li}}%
  \else
      \addcontentsline{toc}{chapter}{\uppercase{#1}}%
      \addtocontents{toc}{\protect\vspace{\li}}%
  \fi
  \chaptermark{#1}%
  \if@twocolumn
      \@topnewpage[\@makechapterhead{#2}]%
  \else
      \@makechapterhead{#2}%
      \@afterheading
 \fi}

 \newcommand{\chapterx}[2][]{\ifnum \c@secnumdepth >\m@ne
      \refstepcounter{chapter}%
      \typeout{\@chapapp\space\thechapter.}%
      \addcontentsline{toc}{chapter}%
         {\protect\numberline{\thechapter}\uppercase{#1}}%
  \else
      \addcontentsline{toc}{chapter}{\uppercase{#1}}%
  \fi
  \chaptermark{#1}%
  \if@twocolumn
      \@topnewpage[\@makechapterhead{#2}]%
  \else
      \@makechapterhead{#2}%
      \@afterheading
 \fi}

% This makes the chapter headings appear \uitchap below the top of
% the page and makes the text appear on the 4th single-spaced line
% after the heading
\renewcommand{\@makechapterhead}[1]{%
  \vspace*{\uitchapadd}%
  {\singlespace \parindent \z@ \centering \normalsize
    \ifnum \c@secnumdepth >\m@ne
          \bfseries \@chapapp{} \thechapter \par
       \fi
    \interlinepenalty\@M
    \vskip \li
    \bfseries\uppercase{#1}\par\nobreak
    \vskip 2\li
  }}

% This makes the front matter headings appear \uitchap below the top of
% the page and makes the column headings appear on the 2nd single-spaced line
% after the heading
\renewcommand{\@makeschapterhead}[1]{\vspace*{\uitchapadd}%
  {\singlespace\parindent \z@ \reset@font \normalsize \bfseries
  \centering \uppercase{#1}\par \nobreak \vskip \li }}

\newcommand{\mydottedtocline}[5]{\renewcommand{\@dotsep}{1000}
   \@dottedtocline{#1}{#2}{#3}{#4}{}\renewcommand{\@dotsep}{4.5}}

%\newcommand{\l@firsthead}      {\@dottedtocline{0}{\z@}{1.5em}}
\newcommand{\l@listhead}        {\protect\vspace{\li}\@dottedtocline{0}{\z@}{1.5em}}
%\newcommand{\l@head}            {\protect\vspace{\li}\@dottedtocline{0}{\z@}{1.5em}}
\newcommand{\l@head}            {\@dottedtocline{0}{\z@}{1.5em}}
\newcommand{\l@blankhead}       {\protect\vspace{\li}\mydottedtocline{0}{\z@}{1.5em}}
%\newcommand{\l@blankhead}       {\mydottedtocline{0}{\z@}{1.5em}}
\renewcommand{\l@chapter}       {\protect\vspace{\li}\@dottedtocline{0}{2.0em}{1.5em}}
\newcommand{\l@chapterx}       {\protect\vspace{\li}\@dottedtocline{0}{2.0em}{1.5em}}
%\renewcommand{\l@chapter}       {\@dottedtocline{0}{2.0em}{1.5em}}
\renewcommand{\l@section}       {\@dottedtocline{1}{3.5em}{2.3em}}
\renewcommand{\l@subsection}    {\@dottedtocline{2}{5.8em}{3.2em}}
\renewcommand{\l@subsubsection} {\@dottedtocline{3}{9.0em}{4.1em}}
%\renewcommand{\l@paragraph}     {\@dottedtocline{4}{11em}{5em}}
%\renewcommand{\l@subparagraph}  {\@dottedtocline{5}{13em}{6em}}
\renewcommand{\l@figure}        {\protect\vspace{\li}\@dottedtocline{1}{\z@}{2.3em}}
\renewcommand{\l@table}         {\protect\vspace{\li}\@dottedtocline{1}{\z@}{2.3em}}
\renewcommand{\l@algorithm}     {\protect\vspace{\li}\@dottedtocline{1}{\z@}{2.3em}}

% These parameters control the number of blank lines above/below
% a float (e.g. a table or figure)
\setlength{\floatsep}{3\li}
\setlength{\textfloatsep}{3\li}
\setlength{\intextsep}{3\li}

% single spacing for algorithms
% disabled (at the moment) by Duckki
%\setlist{noitemsep,topsep=1pt, partopsep=4pt, parsep=2pt}
%\setitemize{noitemsep,topsep=0pt, partopsep=0pt, parsep=0pt}
%\setenumerate{noitemsep,topsep=1pt, partopsep=4pt, parsep=2pt}

% Redefine the \appendix command to added a APPENDIX heading to the TOC
\let\savedAppendix=\appendix
\renewcommand{\appendix}{\savedAppendix
\addtocontents{toc}{\protect\vspace{\li}}	% by Duckki
%\addcontentsline{toc}{head}{APPENDIX}
\addcontentsline{toc}{blankhead}{APPENDIX}	% AJR fix
}

\newcommand{\frontmatter}{
  \ifthenelse{\boolean{nofrontmatter}}{}%
  {
     %\ifthenelse{\boolean{phd}}{\doctoralabstract}{}   % AJR : no longer require abstract with phd thesis
     \ifthenelse{\boolean{phdabstract}}{\doctoralabstract}{} 
     \uitprefixpg
     \singlespace
     \titlepg
     \copyrightpg
     \setcounter{page}{1}	% pages count from now on
     \signaturepg			% certificate page
     \dedicationpg		% dedication (optional)
     \epigraphpg      % epigraph/frontspiece (optional)
     \ifthenelse{\boolean{ackpage}}{
        \ackpg
     }{}
     \abstractpg			% (internal) abstract (optional)
     %\setcounter{tocdepth}{6}
     \setcounter{tocdepth}{3}	% changed by Duckki
     \tableofcontents
     % The vbox is a harmless way of preventing a space being added
     % to the end of the Page label
     \addtocontents{toc}{\vbox{\noindent \protect\hfill}}

     \ifthenelse{\boolean{tables}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF TABLES}%
        \addtocontents{lot}{\vspace{11mm}\vbox{\noindent Table \protect\hfill}}
        \listoftables
     }{}
     \ifthenelse{\boolean{figures}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF FIGURES}%
        \addtocontents{lof}{\vspace{11mm}\vbox{\noindent Figure \protect\hfill}}
        \listoffigures
     }{}

     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % Reorder these in anyway you see fit for output. You may have to change %
     % the listtheorems{<type>) to fit your declarations (currently, theorem  %
     % is set to thm, lemma to lem, and example to example).                  %
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     \ifthenelse{\boolean{algorithms}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF ALGORITHMS}%
        \addtocontents{loa}{\vspace{11mm}\vbox{\noindent Algorithm \protect\hfill}}
        \listofalgorithms
     }{}
     \ifthenelse{\boolean{examples}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF EXAMPLES}%
        %set the output to chapter-like; pad top to fix ntheorem issues
        \@makeschapterhead{\vspace{0.9mm}LIST OF EXAMPLES}%
        \vspace{11mm}
        \addtheoremline{loe}{\vbox{\noindent Example \protect\hfill}}
        \vspace{5mm}
        \listtheorems{example}
     }{}
     \ifthenelse{\boolean{lemmas}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF LEMMAS}%
        %set the output to chapter-like; pad top to fix ntheorem issues
        \@makeschapterhead{\vspace{0.9mm}LIST OF LEMMAS}%
        \vspace{11mm}
        \addtheoremline{lol}{\vbox{\noindent Lemma \protect\hfill}}
        \vspace{5mm}
        \listtheorems{lem}
     }{}
     \ifthenelse{\boolean{theorems}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF THEOREMS}%
        %set the output to chapter-like; pad top to fix ntheorem issues
        \@makeschapterhead{\vspace{0.0mm}LIST OF THEOREMS}%
        \vspace{11mm}
        \addtheoremline{lot}{\vbox{\noindent Theorem \protect\hfill}}
        \vspace{5mm}
        \listtheorems{thm}
     }{}
     \ifthenelse{\boolean{exampleslemmas}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF EXAMPLES AND LEMMAS}%
        %set the output to chapter-like; pad top to fix ntheorem issues
        \@makeschapterhead{\vspace{0.0mm}LIST OF EXAMPLES AND LEMMAS}%
        \vspace{11mm}
        \addtheoremline{lot}{\vbox{\noindent Examples\textbackslach Lemmas \protect\hfill}}
        \theoremlisttype{allname}   % required to print out the type before the number
        \vspace{5mm}
        \listtheorems{example,lem}
     }{}
     \ifthenelse{\boolean{examplestheorems}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF EXAMPLES AND THEOREMS}%
        %set the output to chapter-like; pad top to fix ntheorem issues
        \@makeschapterhead{\vspace{0.0mm}LIST OF EXAMPLES AND THEOREMS}%
        \vspace{11mm}
        \addtheoremline{lot}{\vbox{\noindent Example\textbackslash Theorem \protect\hfill}}
        \theoremlisttype{allname}   % required to print out the type before the number
        \vspace{5mm}
        \listtheorems{example,thm}
     }{}
     \ifthenelse{\boolean{lemmastheorems}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF LEMMAS AND THEOREMS}%
        %set the output to chapter-like; pad top to fix ntheorem issues
        \@makeschapterhead{\vspace{0.0mm}LIST OF LEMMAS AND THEOREMS}%
        \vspace{11mm}
        \addtheoremline{lot}{\vbox{\noindent Lemma\textbackslash Theorem \protect\hfill}}
        \theoremlisttype{allname}   % required to print out the type before the number
        \vspace{5mm}
        \listtheorems{lem,thm}
     }{}
     \ifthenelse{\boolean{exampleslemmastheorems}}{
        \newpage
        \phantomsection	% by Duckki
        \addcontentsline{toc}{listhead}{LIST OF EXAMPLES, LEMMAS, AND THEOREMS}%
        %set the output to chapter-like; pad top to fix ntheorem issues
        \@makeschapterhead{\vspace{0.0mm}LIST OF EXAMPLES, LEMMAS, AND THEOREMS}%
        \vspace{11mm}
        \addtheoremline{lot}{\vbox{\noindent Example\textbackslash Lemma\textbackslash Theorem \protect\hfill}}
        \theoremlisttype{allname}   % required to print out the type before the number
        \vspace{5mm}
        \listtheorems{example,lem,thm}
     }{}
    \addcontentsline{toc}{blankhead}{CHAPTER}

  } % ifthenelse nofrontmatter

  \raggedbottom
  \doublespace
  \uitnormalpg
} % newcommand frontmatter


%%% PREAMBLE COMMANDS
\def\dept#1{\gdef\@dept{#1}}
\def\advisor{\gdef\@advisor}
% ADDITION by RH
\newboolean{multipleSupervisors}

% ADDITION by SLF
\def\memberOne{\gdef\@memberOne}
\def\memberTwo{\gdef\@memberTwo}
\def\memberThree{\gdef\@memberThree}
\def\memberFour{\gdef\@memberFour}
\def\memberFive{\gdef\@memberFive}
% END of addition
\def\memberSix{\gdef\@memberSix}	% by Duckki

\def\submitdate#1{\gdef\@submitdate{#1}}
\def\copyrightyear#1{\gdef\@copyrightyear{#1}}
%\def\abstractfile#1{\setboolean{abtitlepage}{true}\gdef\@abstractfile{#1}}
\def\Abstract#1{\setboolean{abtitlepage}{true}\gdef\@abstracttext{#1}}
\def\dedication#1{\gdef\@dedication{#1}}
\def\epigraph#1{\gdef\@epigraph{#1}}
\def\acknowledgements#1{\setboolean{ackpage}{true}\gdef\@acknowledgements{#1}}

\def\@title{}
\def\@author{}
\def\@dept{}
\def\@submitdate{\ifcase\the\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space \number\the\year}
\ifnum\month=12
    \@tempcnta=\year \advance\@tempcnta by 1
    \edef\@copyrightyear{\number\the\@tempcnta}
\else
    \def\@copyrightyear{\number\the\year}
\fi

\newcommand{\titlepg}{%
   \thispagestyle{empty}
   \vspace*{\stretch{1}}
   \doublespace\normalsize
   \begin{center}
      \uppercase\expandafter{\@title}
   \end{center}
   \vspace*{\stretch{2}}
   \begin{center}
      by\\
      \vskip \li
      \@author
   \end{center}
   \vspace*{\stretch{2}}
   \singlespace\normalsize
   \begin{center}
      A thesis submitted in partial fulfillment of the\\
      requirements for the \ifthenelse{\boolean{phd}}{Doctor of
   Philosophy}{Master of Science}\\
       degree in {\@dept} \\
       in the Graduate College of \\
       The University of Iowa
   \end{center}
   \vskip 2\li
   \begin{center}
      \@submitdate
   \end{center}
   \vskip 2\li
   \begin{center}
      \ifthenelse{\boolean{multipleSupervisors}}{
         Thesis Supervisors: \@advisor
      }{
         Thesis Supervisor: \@advisor
      }
   \end{center}
   \vfill
   \newpage
}

%
% COPYRIGHTPG - command to add the copyright page to the thesis
%
% Horizontally and vertically centers the copyright info as described
% by the thesis manual on the page.  Currently uses the year defined by
% \copyrightyear{}.
%
\newcommand{\copyrightpg}{%
  \ifthenelse{\boolean{copyrightpage}}%
  {%
	\thispagestyle{empty}%
	\vspace*{\fill}
	\begin{center}
	   Copyright by\\
	   \uppercase\expandafter{\@author}\\
	   \@copyrightyear\\
	   All Rights Reserved
	\end{center}
	\vspace*{\fill}
	\newpage
  }%
  {}%
}


%
% DEDICATIONPG - command to add the dedication page to the thesis
%
% Horizontally and vertically centers the dedication info info as
% described by the thesis manual.
%
\newcommand{\dedicationpg}{%
  \ifthenelse{\boolean{dedicationpage}}%
  {%
	\vspace*{\fill}
	\begin{center}
		\@dedication
	\end{center}
	\vspace*{\fill}
	\newpage
  }%
  {}%
}

%
% EPIGRAPHPG - command to add the epigraph/frontspiece page to the thesis
%
% Horizontally and vertically centers the epigraph or frontspiece as
% described by the thesis manual.
%
\newcommand{\epigraphpg}{%
  \ifthenelse{\boolean{epigraphpage}}%
  {%
	\vspace*{\fill}
	\begin{center}
	   \@epigraph
	\end{center}
	\vspace*{\fill}
	\newpage
  }%
  {}%
}

%
% ACKPG - command for setting up the acknowledgement page
%
% From the thesis manual, as of 2/24/1999: ``This section
% begins with the title ACKNOWLEDGMENTS centered in all capital
% letters 2 inches from the top of the page.  The text begins
% on the fourth line below the heading and is double-spaced. The
% text is limited to thanks for or recognition of special assistance,
% but also may include recognitions of permissions granted to the
% author to use published and/or copyrighted material.''
%
\newcommand{\ackpg}{%
   \ifthenelse{\boolean{ackpage}}%
   {%
	\vspace*{\uitchapadd}%
% Pain in the ass formatting: the text of the acknowledgement has to
% appear 4 singlespace lines below the heading, rather than 2 like in
% the rest of the front matter.
	{\singlespace\parindent \z@ \reset@font \normalsize \bfseries
	 \centering ACKNOWLEDGEMENTS\par \nobreak \vskip 2\li }
	\doublespace
	  \@acknowledgements
	\vfill
	\singlespace\normalsize
	\newpage
   }%
   {}%
}



%
% ABSTRACTPG - command to add the abstract page
%
% ABSTRACT BOUND WITH THESIS (optional)
%
% Thesis Manual (2/24/1999): ``This item, required by some
% departments but not by the Graduate College, is a brief
% resume of the contents of the thesis. The title ABSTRACT in
% all capital letters is centered 2 inches from the top of the
% page. The text begins on the fourth line below the heading
% and is double-spaced. It is unsigned; no approval form accompanies
% this abstract.  DMA thesis and Ph.D. students must prepare a
% separate abstract, as described on page 9, which is not bound with the
% thesis.''
%
\newcommand{\abstractpg}{%
   \ifthenelse{\boolean{abstractpage}}%
   {%
      \vspace*{\uitchapadd}%
% Pain in the ass formatting: the text of the acknowledgement has to
% appear 4 singlespace lines below the heading, rather than 2 like in
% the rest of the front matter.
	{\singlespace\parindent \z@ \reset@font \normalsize \bfseries
	 \centering ABSTRACT\par \nobreak \vskip 2\li }
	\doublespace
	\@abstracttext
	\vfill
	\singlespace\normalsize
	\newpage
   }%
   {}%
}


%
% DOCTORALABSTRACT - command to add the doctoral abstract (required
%                    for doctoral students)
%
%
\newcommand{\doctoralabstract}{%
	% doctoral abstract title page
	\docabtitlepg
	% doctoral abstract with signatures, etc...
	\docabstract
}


%
% DOCABTITLEPG - command to add the doctoral abstract title
%   page (required for doctoral students)
%
% Author Note (PW) - wanted to figure out a TeX way to count the words
% in the abstract since the thesis manual states that the abstract may
% be no more than ABOUT 350 words.
%
%
\newcommand{\docabtitlepg}{%
% title page
   \thispagestyle{empty}
   \vspace*{\stretch{1}}
   \doublespace\normalsize
   \begin{center}
      \uppercase\expandafter{\@title}
   \end{center}
   \vspace*{\stretch{2}}
   \begin{center}
      by\\
      \vskip \li
      \@author
   \end{center}
   \vspace*{\stretch{1}}
   \begin{center}
      \underline{An Abstract}
   \end{center}
   \singlespace\normalsize
   \begin{center}
      Of a thesis submitted in partial fulfillment of the\\
      requirements for the Doctor of Philosophy \\
      degree in {\@dept} \\
      in the Graduate College of \\
      The University of Iowa
   \end{center}
   \vskip 2\li
   \begin{center}
      \@submitdate
   \end{center}
   \vskip 2\li
   \begin{center}
       \ifthenelse{\boolean{multipleSupervisors}}{
         Thesis Supervisors: \@advisor
      }{
         Thesis Supervisor: \@advisor
      }
   \end{center}
   \vfill
   \newpage
}


%
% DOCABSTRACT - command to add the doctoral abstract
%   page(s).  This includes the signature section.
%   (required for doctoral students)
%
\newcommand{\docabstract}{%
	\docabprefixpg
	\setcounter{page}{1}
	\vspace*{\uitchapadd}%
% Pain in the ass formatting: the text of the abstract has to
% appear 4 singlespace lines below the heading, rather than 2 like in
% the rest of the front matter.
	{\singlespace\parindent \z@ \reset@font \normalsize \bfseries
	 \centering ABSTRACT\par \nobreak \vskip 2\li }
	\doublespace
	\@abstracttext
	\vskip 4\li
	\begin{center}\begin{minipage}{4.5in}
	\singlespace\normalsize
	\settowidth{\uitrule}{Abstract Approved: }
	\raisebox{2pt}{Abstract Approved: }\hrulefill\\
        \ifthenelse{\boolean{multipleSupervisors}}{
            \hspace*{\uitrule}{Thesis Supervisor}\\[2\li]
            \hspace*{\uitrule}\hrulefill\\
            \hspace*{\uitrule}{Title and Department}\\[2\li]
            \hspace*{\uitrule}\hrulefill\\
            \hspace*{\uitrule}{Date}\\\\\\
            \hspace*{\uitrule}\hrulefill\\
            \hspace*{\uitrule}{Thesis Supervisor}\\[2\li]
            \hspace*{\uitrule}\hrulefill\\
            \hspace*{\uitrule}{Title and Department}\\[2\li]
            \hspace*{\uitrule}\hrulefill\\
            \hspace*{\uitrule}{Date}
        }{
            \hspace*{\uitrule}{Thesis Supervisor}\\[2\li]
            \hspace*{\uitrule}\hrulefill\\
            \hspace*{\uitrule}{Title and Department}\\[2\li]
            \hspace*{\uitrule}\hrulefill\\
            \hspace*{\uitrule}{Date}
        }
	\end{minipage}\end{center}
	\newpage
}

%
% SIGNATURE PAGE -
%
\newcommand{\signaturepg}{%
   \thispagestyle{empty}%
   \begin{center}
      Graduate College\\
      The University of Iowa\\
      Iowa City, Iowa
   \end{center}
   \vspace*{\stretch{2}}
   \begin{center}
      CERTIFICATE OF APPROVAL\\[\li]
      \settowidth{\uitrule}{CERTIFICATE OF APPROVAL}
      \rule{\uitrule}{0.4pt}\\[2\li]
      \ifthenelse{\boolean{phd}}%
         {PH.D. THESIS\settowidth{\uitrule}{PH.D. THESIS}}%
         {MASTER'S THESIS\settowidth{\uitrule}{MASTER'S THESIS}}\\[\li]
      \rule{\uitrule}{0.4pt}
   \end{center}
   \vspace*{\stretch{1}}
   \begin{center}\begin{minipage}{4.5in}
      \noindent This is to certify that the
      \ifthenelse{\boolean{phd}}{Ph.D.}{Master's} thesis of
      \vspace*{\li}
      \begin{center} \@author\end{center}
      \vspace*{\li}
      has been approved by the Examining Committee for the thesis
      requirement for the \ifthenelse{\boolean{phd}}{Doctor of
      Philosophy}{Master of Science} degree in {\@dept} at the
      {\@submitdate} graduation.
   \end{minipage}\end{center}
   \vspace*{\stretch{1}}
   \begin{center}\begin{minipage}{4.5in}
   \settowidth{\uitrule}{Thesis Committee: }
   \raisebox{2pt}{Thesis Committee: }\hrulefill\\
% SOME CHANGES by SLF and RH
        \hspace*{\uitrule}{\@memberOne, Thesis Supervisor}\\[2\li]
        \hspace*{\uitrule}\hrulefill\\
        \ifthenelse{\boolean{multipleSupervisors}}{
            \hspace*{\uitrule}{\@memberTwo, Thesis Supervisor}\\[2\li]
        }{
            \hspace*{\uitrule}{\@memberTwo}\\[2\li]
        }
        \hspace*{\uitrule}\hrulefill\\
        \hspace*{\uitrule}{\@memberThree}
   \ifthenelse{\boolean{phd}}{\\[2\li]
        \hspace*{\uitrule}\hrulefill\\
        \hspace*{\uitrule}{\@memberFour}\\[2\li]
% If you need more signature lines, uncomment and duplicate these
% following two lines:
        %\hspace*{\uitrule}\hrulefill\\
        %\hspace*{\uitrule}{\@memberFive}\\[2\li]
        \hspace*{\uitrule}\hrulefill\\
        \hspace*{\uitrule}{\@memberFive}}{}
   \end{minipage}\end{center}
   \vfill
   \newpage
}
