\pdfoutput=1
\ProvidesClass{exam}
\LoadClass[UKenglish,a4paper,12pt]{article}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}

%%%%%%%%%%%%% Option flags
\newif\if@resitpaper
\@resitpaperfalse
\DeclareOption{resit}
{\@resitpapertrue}

\newif\if@samplepaper
\@samplepaperfalse
\DeclareOption{sample}
{\@samplepapertrue}

           
\newif\if@mockpaper
\@mockpaperfalse
\DeclareOption{mock}
{\@mockpapertrue}   

\newif\if@calculatorallowed
\@calculatorallowedfalse
\DeclareOption{calculator}
{\@calculatorallowedtrue}

\newif\if@handbookallowed
\@handbookallowedfalse
\DeclareOption{handbook}
{\@handbookallowedtrue}

\newif\if@steamtablesallowed
\@steamtablesallowedfalse
\DeclareOption{steamtables}
{\@steamtablesallowedtrue}

\newif\if@datasheetattached
\@datasheetattachedfalse
\DeclareOption{datasheet}
{\@datasheetattachedtrue}

\newif\if@wsolutions
\@wsolutionsfalse
\DeclareOption{solutions}
{\@wsolutionstrue}

%%%%%%%%%%%%%% Parse the options
%Default options go here
\ExecuteOptions{}
\ProcessOptions

%%%%%%%%%%%%%% Class controls
\makeatletter%
\newcommand{\coursecode}[1]{\def \@coursecode {#1}}
\newcommand{\coursetitle}[1]{\def \@coursetitle {#1}}
\newcommand{\examtime}[1]{\def \@examtime {#1}}
\newcommand{\examdate}[3]{%
  \newdate{ExamDateSaved}{#1}{#2}{#3}%
  \ifnum\getdatemonth{ExamDateSaved}<9%
  \newcommand{\SessionStart}{\pgfmathparse{int(\getdateyear{ExamDateSaved}-1)}\pgfmathresult}
  \newcommand{\SessionEnd}{\getdateyear{ExamDateSaved}}
  \newcommand{\SessionStartShort}{\pgfmathparse{int(mod(\getdateyear{ExamDateSaved}-1, 100))}\pgfmathresult}
  \newcommand{\SessionEndShort}{\pgfmathparse{int(mod(\getdateyear{ExamDateSaved}, 100))}\pgfmathresult}
  \else
  \newcommand{\SessionStart}{\getdateyear{ExamDateSaved}}
  \newcommand{\SessionEnd}{\pgfmathparse{int(\getdateyear{ExamDateSaved}+1)}\pgfmathresult}
  \newcommand{\SessionStartShort}{\pgfmathparse{int(mod(\getdateyear{ExamDateSaved}, 100))}\pgfmathresult}
  \newcommand{\SessionEndShort}{\pgfmathparse{int(mod(\getdateyear{ExamDateSaved}+1, 100))}\pgfmathresult}
  \fi
}
\newcommand{\examformat}[1]{\def \@examformat {#1}}
%%% Clear the variables at global scope
\global\let\@coursecode\@empty
\global\let\@coursetitle\@empty
\global\let\@examtime\@empty
\global\let\@examformat\@empty
\makeatother

%%%%%%%%%%% Packages
%%%% Load the math packages we always use
\RequirePackage{amsmath}
\RequirePackage{bm}
\RequirePackage[makeroom]{cancel}
\RequirePackage{url}

%%%%%%%%%%% Notes function
\RequirePackage{mdframed}
\newcommand{\note}[1]{\begin{mdframed}[linewidth=1pt]{\bf Note:} {#1}\end{mdframed}}

%%%% Formatting of dates for the exam
\RequirePackage{datetime}
\newdateformat{longexamdateformat}{\ordinal{DAY} \monthname[\THEMONTH] \THEYEAR}

%%%%%%%%%%%% Useful packages
\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{lastpage}
\RequirePackage{placeins}
\RequirePackage{ccaption}
\RequirePackage{fmtcount}
\RequirePackage{enumerate}
\RequirePackage{marginnote}
\usepackage{ragged2e}
\reversemarginpar
\RequirePackage{background}
% Must be before fancyhdr as the \pagestyle command affects it.
\RequirePackage{fullpage}

%%%%%%%%%%%%%% Header and footer
\RequirePackage{fancyhdr}
\setlength{\headheight}{15pt}

%%% The standard header footer style
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}
\makeatletter
\if@wsolutions
\chead{SOLUTIONS}
\lhead{\marginnote{\small Marks}}
\fi
\rhead{\if@samplepaper{SAMPLE-}\fi%
  \if@resitpaper{R-}\fi%
  \if@mockpaper{M-}\fi%
  \@coursecode/\SessionStart--\SessionEndShort}
\makeatother
\cfoot{\thepage/\pageref{LastPage}} \rfoot{}

\setlength{\headsep}{7mm}
\captionnamefont{\bfseries}
\captiontitlefont{\itshape}
\flushbottom
\parindent=0.0cm%
\parskip=0.4cm%

\RequirePackage{pgf}

\renewcommand{\marks}[1]{\addtocounter{questiontotalmarks}{#1}\addtocounter{papertotalmarks}{#1}\unskip\linebreak[0]\mbox{}~\hfill\mbox{[#1 marks]}}

%% frontmatter page
\makeatletter
\def \@frontmatter{%
  \RaggedRight
  \if@samplepaper\lhead{SAMPLE PAPER}\lfoot{SAMPLE PAPER}\rfoot{SAMPLE PAPER}\fi
  \if@mockpaper\lhead{MOCK-EXAM PAPER}\lfoot{MOCK-EXAM PAPER}\rfoot{MOCK-EXAM PAPER}\fi
  \newcounter{sessionyear}
  \setcounter{sessionyear}{\getdateyear{ExamDateSaved}}
  {\textbf{UNIVERSITY OF ABERDEEN\hspace{0.25in}SESSION \SessionStart--\SessionEndShort}

    \begin{center}{\bf\Huge \@coursecode}\end{center}
    
    \textbf{Degree Examination in \@coursecode~\@coursetitle}

    \textbf{\longexamdateformat\displaydate{ExamDateSaved}\hspace{2cm} \@examtime}}
  
  \if@samplepaper\begin{center}\textbf{\LARGE{SAMPLE PAPER}}\end{center}\fi
  \if@mockpaper\begin{center}\textbf{\LARGE{MOCK-EXAM PAPER}}\end{center}\fi

  \begin{center}{\bf PLEASE NOTE THE FOLLOWING}\end{center}
  \begin{enumerate}[(i)]
  \item You \textbf{must not} have in your possession any material other than
    that expressly permitted in the rules appropriate to this
    examination. Where this is permitted, such material {\bf must not} be
    amended, annotated or modified in any way.
  \item You {\bf must not} have in your possession any material that could be
    determined as giving you an advantage in the examination.
  \item You {\bf must not} attempt to communicate with any candidate during
    the exam, either orally or by passing written material, or by
    showing material to another candidate, nor must you attempt to view
    another candidate's work.
  \item You {\bf must not} take to your examination desk any
    electronic devices such as mobile phones or other “smart” devices.
    The only exception to this rule is an approved calculator.
  \end{enumerate}

  {\bf Failure to comply with the above will be regarded as cheating
    and may lead to disciplinary action as indicated in the Academic
    Quality
    Handbook Section 7 and particularly Appendix 7.1}\\
  \vspace{5mm}

  \vspace{2\baselineskip}
  \begin{minipage}[t]{0.1\linewidth}
      {\bf\em Notes:}
  \end{minipage}
  \begin{minipage}[t]{0.9\linewidth}\bf
    {\em
      \begin{enumerate}[(i)]
      \item Candidates %
        \if@calculatorallowed{ARE}\else{ARE NOT}\fi\ 
        %
        permitted to use an approved calculator.
      \item Candidates %
        \if@handbookallowed{ARE}\else{ARE NOT}\fi\ 
        %
        permitted to use the Engineering Mathematics Handbook.
        \if@steamtablesallowed
      \item Candidates %
        {ARE} permitted to use thermodynamic tables with saturated fluid properties, which will be provided.
        \fi 
        \if@datasheetattached%
      \item Data sheets are attached to the paper.%
        \fi
      \end{enumerate}
    }
  \end{minipage}
  
  
  
  \begin{center}
    \textbf{\@examformat}
  \end{center}
  \vfill
  \FloatBarrier
  \pagebreak
}
% Hook the title page into the start of the document
\if@wsolutions\else
\AtBeginDocument{\@frontmatter}
\fi

% A command which formats an END OF PAPER line at the end of the paper
\newcommand{\paperendtext}{%
  \FloatBarrier\begin{center}%
    {\large\textbf{END OF PAPER}}%
  \end{center}%
  \ifelsesolutions{\begin{center}{\bf Total Paper
        Marks:\thepapertotalmarks} \end{center}}{} }

% This command ensures that the END OF PAPER text is only printed at
% the first occurrence, this is because it is either printed at the
% end of the paper, or at the start of the data sheet!
\newcommand{\paperend}{
  \ifx \paperenddone \undefined%
  \paperendtext%
  \fi%
  \global\def\paperenddone={done}%
}

\newcommand{\ifelsesolutions}[2]{\if@wsolutions{#1}\else{#2}\fi}


%%% Solutions
% A blank solution command if solutions are disabled
\if@wsolutions
\newcommand{\solution}[1]{
  \mbox{}\newline{\bf{}Solution:}\begin{itshape}\nopagebreak\\*\nopagebreak{#1}\end{itshape}}
\newcommand{\solmarks}[1]{\marginpar{\rm\bf [#1]}}
\newcommand{\qsidemark}{\marginpar{\bf Q.\thequestioncounter}}
\SetBgScale{1}
\SetBgColor{black}
\SetBgAngle{0}
\SetBgHshift{-0.52\textwidth}
\SetBgVshift{-1mm}
\SetBgContents{\rule{1pt}{\textheight}}
\else
\newcommand{\solution}[1]{}
\newcommand{\solmarks}[1]{}
\newcommand{\qsidemark}{}
\SetBgContents{}
\fi
\makeatother


%%%%%%% The Class Environments

% The question environment makes sure that all figures are grouped
% with the corresponding question.
\newcounter{questioncounter}
\newcounter{questiontotalmarks}
\newcounter{papertotalmarks}
\setcounter{questioncounter}{0}
\setcounter{papertotalmarks}{0}
\renewcommand{\thequestioncounter}{\arabic{questioncounter}}

\newenvironment{question}{%
  \setcounter{questiontotalmarks}{0}\pagebreak[2]\refstepcounter{questioncounter}{\bf{Question}~\thequestioncounter}\qsidemark\newline%
}{%
  \FloatBarrier%
  \ifelsesolutions{\begin{center}{\bf Total Question Marks:\thequestiontotalmarks}\end{center}}{}
}

\newenvironment{datasheet}{%
  \paperend%
  \FloatBarrier
  \begin{center}%
    \newpage\large \textbf{DATASHEET}%
  \end{center}%
}{}


\newcounter{partcounter}
\renewcommand{\part}[1]{%
  \addtocounter{partcounter}{1}%
  \FloatBarrier\pagebreak[3]{\centering\large\textbf{{P}{A}{R}{T} \Alph{partcounter}: #1}%
  \nopagebreak\FloatBarrier\nopagebreak}}
\raggedbottom
