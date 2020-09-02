\NeedsTeXFormat{LaTeX2e}

% PLEASE UPDATE THE FOLLOWING LINE WHEN MODIFYING
\ProvidesClass{custard}[2020/08/28 the Completely Unofficial Swansea Theses And Related Documents class] 

%% Welcome to the...
%% Completely Unofficial Swansea Theses And Related Documents (CUSTARD) class.
%%
%% The Swansea University guidelines for thesis/dissertation presentation are currently
%% (as of August 2020) available at:
%% 
%% https://myuni.swansea.ac.uk/academic-life/academic-regulations/research-guidance/guide-to-submission-and-presentation-of-the-thesis/ and
%% https://myuni.swansea.ac.uk/academic-life/academic-regulations/assessment-and-progress/preparation-and-submission-of-dil/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Global Variable Declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% These variables control certain code executions in this class
%% file. They are enabled/disabled via class options that the user
%% specifices when loading this class.

\newif\if@oneortwosidespecified %% Makes sure user has chosen one or two sided. True iff user specified oneside or twoside
\newif\if@twoside %% True if two side, false if one side
\newif\if@decl %% Whether to show declaration (default: not in draft mode)
\newif\if@afourspecified

%% Default values
\@oneortwosidespecifiedfalse
\@decltrue
\@afourspecifiedfalse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Declaration of Class Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% These are the class options that this class supports. It also
%% allows us to pass options on to the underlying class.

%% Paper options. The only paper size we support is A4.
\DeclareOption{letterpaper}{\ClassError{custard}{Custard does not work with letter paper}}
\DeclareOption{executivepaper}{\ClassError{custard}{Custard does not work with executive paper}}
\DeclareOption{legalpaper}{\ClassError{custard}{Custard does not work with legal paper}}
\DeclareOption{a5paper}{\ClassError{custard}{Custard does not work with A5 paper}}
\DeclareOption{b5paper}{\ClassError{custard}{Custard does not work with B5 paper}}
\DeclareOption{a4paper}{\@afourspecifiedtrue}
%% Other options
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{memoir} \@declfalse}
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{memoir} \@twosidefalse \@oneortwosidespecifiedtrue}
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{memoir} \@twosidetrue \@oneortwosidespecifiedtrue}
\DeclareOption{forcedecl}{\@decltrue}
\DeclareOption{nodecl}{\@declfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions* \relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Display Warnings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Display a warning if not using explicitly A4 paper.
\if@afourspecified
%% Do nothing
\else
%% Warn that we use A4, not US Letter
\ClassWarning{custard}{You have not set a paper type explicitly. Please note that custard uses A4 paper, *not* US Letter.}
\fi

%% Display a warning if the user did not specify one to two sided paper.
\if@oneortwosidespecified
%% Do nothing
\else
%% Warn User
\ClassWarning{custard}{You have not specified one or two sided paper.}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load Underlying Class (overriding one/two-sided if in draft mode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\if@decl
	\LoadClass[a4paper]{memoir}
\else
	\LoadClass[a4paper, oneside]{memoir}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Required Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{newpxtext}
%\RequirePackage{newpxmath} % Incompatible with amsthm; TODO: fix this
\RequirePackage{graphicx}
\graphicspath{{./graphics/}} % Location of the graphics files (so you can just use the file name, rather than specifing the full path each time)
\setkeys{Gin}{draft=false} % Show figures even if we are in draft mode
\RequirePackage{xcolor} % Colour support
\RequirePackage{xspace} % For macros (add space unless followed by punctuation)

\RequirePackage[T1]{fontenc} %fonts with proper accented characters
\RequirePackage[utf8]{inputenc} %document is utf8 (must be 2nd: tex.stackexchange.com/a/34046)
\RequirePackage{microtype} % better-looking fonts and layout
\RequirePackage[driverfallback=dvips,unicode=true,bookmarks=true,bookmarksopen=false,pdfpagelabels=false, pdfstartview={FitH},pdfborder={0 0 0},pdfdisplaydoctitle=true,bookmarksnumbered=true, backref=false,breaklinks=true,colorlinks=true,citecolor=black,filecolor=black, linkcolor=black,urlcolor=black,hypertexnames=false]{hyperref}
\RequirePackage[all]{hypcap} %show the actual figure when clicking a figure link, rather than just the caption
\RequirePackage[capitalise,nameinlink]{cleveref} % Avoid manually writing Chapter, Figure, etc - use \Cref at the start of sentences; \cref otherwise
\creflabelformat{equation}{#2\textup{#1}#3}
\crefname{lstlisting}{Listing}{Listings}
\Crefname{lstlisting}{Listing}{Listings}
\RequirePackage[all]{nowidow} %try to completely prevent widows and orphans (paragraphs only, not titles)
\RequirePackage[hyphenation,lastparline]{impnattypo} %better hyphenation and last lines of paragraphs
\urlstyle{same} %typeset urls in the same font/style as their context

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure Page Margins
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set University-recommended page margins (see guidelines: 4cm left and 2.5cm right for theses; 2cm right for dissertation) TODO: automate this
\setlrmarginsandblock{4cm}{2cm}{*}
\checkandfixthelayout

%% Fix marginpars
\setlength{\marginparwidth}{0.9 \spinemargin}

% Todo notes in margins
\RequirePackage{todonotes}
\RequirePackage{totcount}
\newtotcounter{todocounter}
\newcommand{\td}[1]{\texorpdfstring{\stepcounter{todocounter}\todo{\thetodocounter: #1\xspace}}{}\xspace} %normal usage
\newcommand{\tdi}[1]{\texorpdfstring{\stepcounter{todocounter}\todo[inline]{\textnormal{\thetodocounter: #1\xspace}}}{}\xspace} %use in fig. captions
\reversemarginpar % use the larger margin side for todo notes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure Headers and Footers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Make a new style so that we can easily customise it if we want to
% We base this off 'ruled'. Other options: empty, plain, headings, ruled, Ruled, companion.
\copypagestyle{thesis}{ruled}

%% Set up the headers
\makeevenhead{thesis}{\itshape \leftmark}{}{}
\makeoddhead{thesis}{}{}{\itshape \rightmark}

\if@twoside
  %% Do nothing - it's already setup for two sided
\else
  %% Change the headers for one sided pages
  \makeoddhead{thesis}{\itshape \leftmark}{}{}
  \makeoddfoot{thesis}{}{\thepage}{}
\fi

%% If in draft mode, add footers containing the date of processing.
\ifdraftdoc
\makeevenfoot{thesis}{\thepage}{}{\textcolor{red}{\textit{Draft: \today}}}
\makeoddfoot{thesis}{\textcolor{red}{\textit{Draft: \today}}}{}{\thepage}
\makeevenfoot{plain}{}{\thepage}{\textcolor{red}{\textit{Draft: \today}}}
\makeoddfoot{plain}{\textcolor{red}{\textit{Draft: \today}}}{\thepage}{}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure Title Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% This set of macros redefines the \maketitle macro to produce a full-page title.
%% Feature: the title page looks noticeably different if draft mode is set.

%% Student number (e.g., "1234567")
\newcommand{\studentnumber}[1]{%
\gdef\@studentnumber{#1\xspace}}
\newcommand{\@studentnumber}{}

%% Awarding institution (e.g., "Swansea University")
\newcommand{\awardinginst}[1]{%
\gdef\@awardinginst{#1\xspace}}
\newcommand{\@awardinginst}{}

%% Degree type (e.g., Doctor of Philosophy, Master of Research)
\newcommand{\degree}[1]{%
\gdef\@degree{#1\xspace}}
\newcommand{\@degree}{}

%% Department name (e.g., Department of Computer Science)
\newcommand{\department}[1]{%
\gdef\@department{#1\xspace}}
\newcommand{\@department}{~}

%% University name (e.g., Swansea University)
\newcommand{\university}[1]{%
\gdef\@university{#1\xspace}}
\newcommand{\@university}{~}

%% Default value for date
\gdef\thedate{DATE MISSING -- Typeset \today}

%% Set file path to University logo
\newcommand{\unilogo}[1]{%
\gdef\@unilogo{\includegraphics[width=0.45\linewidth]{#1}\xspace}}
\newcommand{\@unilogo}{~}

\renewcommand{\maketitle}{%
  \pagestyle{empty}
  \begin{center}

    \vspace*{12mm}

    {\huge \bfseries \@title}

    \vspace{12mm}

    {\Large \@author}\\
    \@studentnumber

    \ifdraftdoc
      \vspace{10mm}      
       {\Huge\bfseries \textcolor{red}{Thesis Draft: \today}\\}
       \vspace{10mm}
    \else
      \vspace{10mm}
      {\large Submitted to \@awardinginst in partial fulfilment\\
      of the requirements for the Degree of \@degree}

      \vspace{25mm}
     
      \@unilogo

      \vspace{25mm}
      \@department\\
      \@university

      \vspace{5mm}
      \thedate
    \fi
  \end{center}

  \hypersetup{pdftitle={\@title},pdfauthor={\@author},pdfsubject={\@degree},			pdfcreator={},pdfproducer={},pdfkeywords={}}
  \cleardoublepage
} %% end maketitle


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure Declaration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Usage: \declaration
\newcommand{\rowdots}{\hspace{3.35mm}\dots \dots \dots \dots \dots \dots \dots \dots \dots \dots \dots \dots \dots \dots \dots}

\newcommand{\declaration}{
  \if@decl
    \thispagestyle{empty}
    \ \\[5mm]
    {\huge \bfseries Declaration}

    \vspace{5mm}
    \noindent This work has not been previously accepted in substance for any
    degree and is not being concurrently submitted in candidature for any degree.

    \vspace{7mm}
    \begin{tabular}{ll}
      Signed & \rowdots \hspace{5mm} (candidate)\\[5mm]
      Date & \rowdots
    \end{tabular}

    \vspace{15mm}
    \noindent{\huge \bfseries Statement 1}

    \vspace{5mm}
    \noindent This work is the result of my own independent study/investigations, except 
    where otherwise stated. Other sources are clearly acknowledged by giving explicit 
    references. I understand that failure to do this amounts to plagiarism and will be 
    considered grounds for failure of this work and the degree examination as a whole.

    \vspace{7mm}
    \begin{tabular}{ll}
      Signed & \rowdots \hspace{5mm} (candidate)\\[5mm]
      Date & \rowdots
    \end{tabular}

    \vspace{15mm}
    \noindent{\huge \bfseries Statement 2}

    \vspace{5mm}
    \noindent I hereby give my consent for my work, if accepted, to be archived and 
    available for reference use, and for the title and summary to be made available 
    to outside organisations.

    \vspace{7mm}
    \begin{tabular}{ll}
      Signed & \rowdots \hspace{5mm} (candidate)\\[5mm]
      Date & \rowdots
    \end{tabular}

    \cleardoublepage
  \fi
} %% end declaration

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure Abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Usage:
%% \begin{abstract}
%% Text of abstract
%% \end{abstract}

\renewenvironment{abstract}
{\chapter*{Abstract\markboth{Abstract}{Abstract}}}
{\cleardoublepage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure Acknowledgements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Usage:
%% \begin{Acknowledgements}
%% Acknowledgement text
%% \end{Acknowledgements}

\newenvironment{Acknowledgements}
{\chapter*{Acknowledgements\markboth{Acknowledgements}{Acknowledgements}}}
{\cleardoublepage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure Table of Contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Original name = Contents
\renewcommand{\contentsname}{Table of Contents}
\setcounter{tocdepth}{1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure mainmatter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Redefine \mainmatter without losing the original definition
\let\@OLDmainmatter\mainmatter
\renewcommand{\mainmatter}{\@OLDmainmatter \pagestyle{thesis}}

%% Memoir stops numbering at the level of section. reset this to
%% number up until subsubsection.
\setsecnumdepth{subsubsection}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure maths support
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Theorems, definitions, examples, etc.
\newtheoremstyle{thesis} %name
 {9pt}% space above
 {9pt}% space below
 {}% body font
 {}% indent amount (empty or \parindent (or...?))
 {\bfseries}% theorem head font
 {}% punctuation after theorem head
 {0.5em}% space after theorem head
 {}% theorem head spec (empty means normal)  
\theoremstyle{thesis}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{remark}[theorem]{Remark}
\newtheorem{remarks}[theorem]{Remarks}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
