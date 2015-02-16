\ProvidesClass{exam}
\LoadClass[UKenglish,a4paper,12pt]{article}

%%%%%%%%%%%%% Option flags
\newif\if@resitpaper
\@resitpaperfalse
\DeclareOption{resit}
{\@resitpapertrue}

\newif\if@samplepaper
\@samplepaperfalse
\DeclareOption{sample}
{\@samplepapertrue}

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

\newif\if@refrigeranttablesallowed
\@refrigeranttablesallowedfalse
\DeclareOption{refrigeranttables}
{\@refrigeranttablesallowedtrue}

\newif\if@psychrometricchartallowed
\@psychrometricchartallowedfalse
\DeclareOption{psychrometricchart}
{\@psychrometricchartallowedtrue}

\newif\if@airtablesallowed
\@airtablesallowedfalse
\DeclareOption{airtables}
{\@airtablesallowedtrue}

\newif\if@fluidstablesallowed
\@fluidstablesallowedfalse
\DeclareOption{fluidstables}
{\@fluidstablesallowedtrue}

\newif\if@datasheetattached
\@datasheetattachedfalse
\DeclareOption{datasheet}
{\@datasheetattachedtrue}

\newif\if@allquestions
\@allquestionsfalse
\DeclareOption{allquestions}
{\@allquestionstrue}


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
\RequirePackage[margin=1in]{geometry}
\RequirePackage{amsmath}
\RequirePackage{bm}
\RequirePackage[makeroom]{cancel}
\RequirePackage{url}

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
\reversemarginpar
%\RequirePackage{background}
%% Must be before fancyhdr as the \pagestyle command affects it.
%\RequirePackage{fullpage}

%%%%%%%%%%%%%% Header and footer
\RequirePackage{fancyhdr}
\setlength{\headheight}{15pt}

%%% The standard header footer style
\pagestyle{fancy}
\fancyhf{}
\makeatletter
\if@wsolutions
\chead{SOLUTIONS}
\lhead{\marginnote{MARKS}}
\fi
\rhead{\if@samplepaper{SAMPLE-}\fi%
  \if@resitpaper{R-}\fi%
  \@dtctr=\getdateyear{ExamDateSaved}%
  \@modulo{\@dtctr}{100}%
  \@coursecode/\twodigit{\@dtctr}}
\makeatother
\cfoot{\thepage/\pageref{LastPage}} \rfoot{}

\setlength{\headsep}{7mm}
\captionnamefont{\bfseries}
\captiontitlefont{\itshape}
\flushbottom
\parindent=0.0cm%
\parskip=0.4cm%

\renewcommand{\marks}[1]{\unskip\linebreak[0]\mbox{}~\hfill\mbox{[#1 marks]}}

%% frontmatter page
\makeatletter
\def \@frontmatter{%
  \if@samplepaper\lhead{SAMPLE PAPER}\lfoot{SAMPLE PAPER}\rfoot{SAMPLE PAPER}\fi
  \newcounter{lastyear}
  \setcounter{lastyear}{\getdateyear{ExamDateSaved}}

%%
%% Change here for Exam or Resit
%%
%  \addtocounter{lastyear}{+1}
%  {\large \textbf{UNIVERSITY OF ABERDEEN\hspace{0.25in}SESSION \getdateyear{ExamDateSaved}--\arabic{lastyear}}
  \addtocounter{lastyear}{-1}
  {\large \textbf{UNIVERSITY OF ABERDEEN\hspace{0.25in}SESSION \arabic{lastyear}--\getdateyear{ExamDateSaved}}

    \textbf{Degree Examination in \@coursecode~\@coursetitle}

    \textbf{\longexamdateformat\displaydate{ExamDateSaved}\hspace{2cm} \@examtime}}
  
  \if@samplepaper\begin{center}\textbf{\LARGE{SAMPLE PAPER}}\end{center}\fi

  \vspace{2\baselineskip}
  \begin{minipage}[t]{0.1\linewidth}
      {\em Notes:}
  \end{minipage}
  \begin{minipage}[t]{0.9\linewidth}
    {\em
      \begin{enumerate}[(i)]
      \item Candidates %
        \if@calculatorallowed{ARE}\else{ARE NOT}\fi\ 
        %
        permitted to use the approved calculator.
        \if@handbookallowed
      \item Candidates %
        {ARE} permitted to use the Engineering Mathematics Handbook.
        \fi
        \if@steamtablesallowed
      \item Candidates %
        {ARE} permitted to use steam tables, which will be provided.
        \fi 
        \if@airtablesallowed
      \item Candidates %
        {ARE} permitted to use ideal-gas properties of air tables, which will be provided.
        \fi 
        \if@fluidstablesallowed
      \item Candidates %
        {ARE} permitted to use tables of thermodynamic properties of saturated and superheated propane, which will be provided.
        \fi 
        \if@refrigeranttablesallowed
      \item Candidates %
        {ARE} permitted to use refrigerant tables, which will be provided.
        \fi 
        \if@psychrometricchartallowed
      \item Candidates %
        {ARE} permitted to use psychrometric chart, which will be provided.
        \fi 
        \if@datasheetattached%
      \item Data sheets are attached to the paper.%
        \fi 
        \if@allquestions%
      \item Answer all five questions (20 marks each). 100 marks in total for the paper.%
        \fi

      \end{enumerate}
    }
  \end{minipage}
  
  \vspace{2\baselineskip}
  {\bf PLEASE NOTE THE FOLLOWING}
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
  \end{enumerate}
  
  {\bf Failure to comply with the above will be regarded as cheating
    and may lead to disciplinary action as indicated in the Academic
    Quality
    Handbook \newline(\url{www.abdn.ac.uk/registry/quality/appendix7x1.pdf}) Section 4.14 and 5.}\\
  \vspace{5mm}
  
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
}

% This command ensures that the END OF PAPER text is only printed at
% the first occurrence, this is because it is either printed at the
% end of the paper, or at the start of the data sheet!
\newcommand{\paperend}{
  \ifx \paperenddone \undefined%
  \paperendtext%
  \fi%
  \global\def\paperenddone={done}%
}

%%% Solutions
% A blank solution command if solutions are disabled
\if@wsolutions
\newcommand{\solution}[1]{
  \newline{\bf{}Solution:}\begin{itshape}\nopagebreak\\*\nopagebreak{#1}\end{itshape}}
\newcommand{\solmarks}[1]{\marginpar{\rm\bf [#1]}}
\newcommand{\qsidemark}{\marginpar{\bf Q.\arabic{questioncounter}}}
\else
\newcommand{\solution}[1]{}
\newcommand{\solmarks}[1]{}
\newcommand{\qsidemark}{}
\fi
\makeatother


%%%%%%% The Class Environments

% The question environment makes sure that all figures are grouped
% with the corresponding question.
\newcounter{questioncounter}
\setcounter{questioncounter}{1}
\newenvironment{question}{
\pagebreak[2]{\bf {Question}~\arabic{questioncounter}}\qsidemark\nopagebreak\\*%
}{\FloatBarrier\refstepcounter{questioncounter}}

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
