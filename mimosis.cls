\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mimosis}[2017/08/01 Minimal modern thesis class]

\PassOptionsToPackage{
  DIV=12,
  BCOR=2mm,
  footinclude=false,
  headinclude=false
}{typearea}

\LoadClass[a4paper, % KOMA options rewrites this as letter in thesis.tex
           oneside, % switch between oneside (screen) and twoside (binding)
           12pt,
           %cleardoublepage=empty,
           %cleardoublepage=current,
           numbers=noenddot,
           titlepage,
           toc=bibliography,
           toc=index]{scrbook}

\makeatletter
\if@twoside % commands below work only for twoside option of \documentclass
    \newlength{\textblockoffset}
    \setlength{\textblockoffset}{12mm}
    \addtolength{\hoffset}{\textblockoffset}
    \addtolength{\evensidemargin}{-2.0\textblockoffset}
\fi
\makeatother

\RequirePackage{ifpdf}
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}

\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\ifxetexorluatex
  \RequirePackage{fontspec}
\else
  \RequirePackage[utf8]{inputenc}
\fi

\RequirePackage{csquotes} % Context-sensitive quotation marks
\RequirePackage{makeidx}  % For creating indices
\RequirePackage{xspace}   % For automatically "eating" spaces

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multi-line comments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\comment}[1]{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts & colours
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[usenames,dvipsnames]{xcolor}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graphics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\graphicspath{%
  {Figures/}
  {./}
}

% Suppress warnings about page groups in PDFs. This is not justified
% in most of the cases. I am pretty sure I am including my images in
% the right manner.
\begingroup\expandafter\expandafter\expandafter\endgroup
\expandafter\ifx\csname pdfsuppresswarningpagegroup\endcsname\relax
\else
  \pdfsuppresswarningpagegroup=1\relax
\fi

\RequirePackage{subcaption}

% Make sub-references using \subref being typeset with parentheses.
% Otherwise, only the counter will be printed.
\captionsetup{subrefformat=parens}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Glossaries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[%
  acronym,
  automake,
  nogroupskip,
  nopostdot,
  nonumberlist,
  toc,
  ]{glossaries}

% New style that prevents line-breaks between the full description and
% the acronym. Furthermore, it ensures that the acronym is always
% printed in an upright font.
\newacronymstyle{long-short-mimosis}
{%
  \GlsUseAcrEntryDispStyle{long-short}%
}%
{%
  \GlsUseAcrStyleDefs{long-short}%
  \renewcommand*{\genacrfullformat}[2]{%
    \glsentrylong{##1}##2~\textup{(\firstacronymfont{\glsentryshort{##1}})}%
  }%
  \renewcommand*{\Genacrfullformat}[2]{%
    \Glsentrylong{##1}##2~\textup{(\firstacronymfont{\glsentryshort{##1}})}%
  }%
  \renewcommand*{\genplacrfullformat}[2]{%
    \glsentrylongpl{##1}##2~\textup{(\firstacronymfont{\glsentryshortpl{##1}})}%
  }%
  \renewcommand*{\Genplacrfullformat}[2]{%
    \Glsentrylongpl{##1}##2~\textup{(\firstacronymfont{\Glsentryshortpl{##1}})}%
  }%
}

% A new glossary style that based on the long style of the glossaries
% package. It ensures that descriptions and entries are aligned.
\newglossarystyle{long-mimosis}{%
  \setglossarystyle{long}

  \renewcommand{\glossentry}[2]{%
    \glsentryitem{##1}\glstarget{##1}{\glossentryname{##1}} &
    \glossentrydesc{##1}\glspostdescription\space ##2\tabularnewline
  }%
}

% Constrain the description width to enforce breaks.
\setlength{\glsdescwidth}{10cm}

\setacronymstyle{long-short-mimosis}
\setglossarystyle{long-mimosis}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paragraph lists & compact enumerations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[%
    olditem,  % Do not modify itemize environments by default
    oldenum   % Do not modify enumerate environments by default
  ]{paralist}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spacing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{setspace}
\doublespacing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{booktabs}
\RequirePackage{multirow}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Proper typesetting of units
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[binary-units=true]{siunitx}

\sisetup{%
  detect-all           = true,
  detect-family        = true,
  detect-mode          = true,
  detect-shape         = true,
  detect-weight        = true,
  detect-inline-weight = math,
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mathematics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{dsfont}

% Fix the spacing of \left and \right. Use these with the proper bracket
% in order to ensure that they scale automatically.
\let\originalleft\left
\let\originalright\right
\renewcommand{\left}{\mathopen{}\mathclose\bgroup\originalleft}
\renewcommand{\right}{\aftergroup\egroup\originalright}

\DeclareMathOperator*{\argmin}          {arg\,min}
\DeclareMathOperator {\dist}            {dist}
\DeclareMathOperator {\im}              {im}

\newcommand{\domain}{\ensuremath{\mathds{D}}}
\newcommand{\real}  {\ensuremath{\mathds{R}}}

% Proper differential operators
\newcommand{\diff}[1]{\ensuremath{\operatorname{d}\!{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ordinals
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand  {\st}{\textsuperscript{\textup{st}}\xspace}
\newcommand  {\rd}{\textsuperscript{\textup{rd}}\xspace}
\newcommand  {\nd}{\textsuperscript{\textup{nd}}\xspace}
\renewcommand{\th}{\textsuperscript{\textup{th}}\xspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Penalties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\clubpenalty         = 10000
\widowpenalty        = 10000
\displaywidowpenalty = 10000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Headers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{scrlayer-scrpage}
\pagestyle{scrheadings}
\clearscrheadfoot
\cfoot[\pagemark]{\pagemark}
\renewcommand*{\pnumfont}{\small \normalfont}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Typefaces for parts, chapters, and sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\partformat}{\huge\partname~\thepart\autodot}
\renewcommand{\raggedpart}{\flushleft}

\setkomafont{part}{\normalfont\huge\scshape}

\setkomafont{sectioning}{\normalfont\scshape}
\setkomafont{descriptionlabel}{\normalfont\bfseries}

\setkomafont{caption}{\small}
\setkomafont{captionlabel}{\usekomafont{caption}}

% Large number for chapter
\renewcommand*{\chapterformat}{%
  \fontsize{50}{55}\selectfont\thechapter\autodot\enskip
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some of my favourite personal adjustments -- carryover from original Thesis.tex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% These are the adjustments that I consider necessary for typesetting
% a nice thesis. However, they are *not* included in the template, as
% I do not want to force you to use them.

% This ensures that you can typeset LaTeX, LuaLaTeX, etc
\usepackage{metalogo}

% This ensures that I am able to typeset bold font in table while still aligning the numbers
% correctly.
\usepackage{etoolbox}

\usepackage[binary-units=true]{siunitx}
\DeclareSIUnit\px{px}

\sisetup{%
  detect-all           = true,
  detect-family        = true,
  detect-mode          = true,
  detect-shape         = true,
  detect-weight        = true,
  detect-inline-weight = math,
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hyperlinks & bookmarks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage[%
  colorlinks = true,
  citecolor  = RoyalBlue,
  linkcolor  = RoyalBlue,
  urlcolor   = RoyalBlue,
  unicode,
  pdftex,
  pdfauthor={YOUR NAME},
  pdftitle={YOUR TITLE},
  pdfkeywords={YOUR KEYWORDS},
  pdfsubject={PhD Dissertation at the Massachusetts Institute of Technology and the Woods Hole Oceanographic Institution Joint Program in Oceanography/Applied Ocean Science & Engineering}
  ]{hyperref}

\usepackage{bookmark}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Author-title in footnote, list in references. The first names,
% if present, will be initialized. DOIs and URLs will be preserved.

\usepackage[%
  autocite     = footnote,
  backend      = biber,
  doi          = true,
  url          = false,
  isbn         = false,
  eprint       = false,
  giveninits   = true,
  uniquename   = false,
  hyperref     = true,
  maxbibnames  = 99,
  maxcitenames = 1,
  sortcites    = true,
  %citestyle    = authortitle-icomp,
   citestyle    = authoryear-icomp,
  bibstyle     = ieee,
  uniquelist   = false,
  ]{biblatex}

\AtEveryBibitem{\clearfield{month}}
\AtEveryCitekey{\clearfield{month}}
\AtEveryBibitem{\clearlist{language}}
\AtEveryBibitem{\clearlist{extra}}
\AtEveryBibitem{\clearfield{pages}}
\AtEveryBibitem{\clearfield{publisher}}

\input{bibliography-mimosis}
\addbibresource{Thesis.bib}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifxetexorluatex
\usepackage{sansmath}
\usepackage[cochineal]{newtxmath}
\setmainfont{Crimson-Roman}[Ligatures=TeX,
          ItalicFont = {Crimson-Italic},
          BoldFont = {Crimson-Semibold},
          BoldItalicFont = {Crimson-SemiboldItalic}]
\setsansfont{Tex Gyre Heros}
\DeclareSymbolFont{operators}{\encodingdefault}{\familydefault}{m}{n}
\else
  \usepackage[light]{CrimsonPro}
  \usepackage[default]{lato}
  \usepackage[T1]{fontenc}
  %% The font package uses mweights.sty which has som issues with the
  %% \normalfont command. The following two lines fixes this issue.
  \let\oldnormalfont\normalfont
  \def\normalfont{\oldnormalfont\mdseries}
\fi

\renewcommand{\th}{\textsuperscript{\textup{th}}\xspace}