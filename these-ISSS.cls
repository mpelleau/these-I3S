%%-----------------------------------------------------------------------------
%% these.cls --
%% Style de thèse pour l'I3S
%%   [Laboratoire d'Informatique, de Signaux et Systèmes de Sophia-Antipolis]
%% Auteur : Marie Pelleau <Marie.Pelleau@univ-cotedazur.fr>
%%          I3S, France
%% Maintenance : 
%%         https://github.com/mpelleau/these-I3S
%% Style basé sur 'memoir.cls'
%% CVS Id: $Id: these.cls,v 1.0 2026/06/12 20:11:56 mpelleau $
%%-----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\IfFileExists{rcs.sty}{%
  \RequirePackage{rcs}%
}{%
  \AtEndOfClass{%
    \ClassWarningNoLine{these}{%
      Impossible de charger le package rcs[-latex].%
    }%
  }%
  \def\RCS $##1: ##2 ${\expandafter\def\csname RCS##1\endcsname{##2}}%
}
\RCS $Revision: 1.0 $
\RCS $Date: 2026/06/12 20:11:56 $
\RCS $Id: these.cls,v 1.0 2026/06/12 20:11:56 mpelleau $
\def\versionnumber@these{v. \RCSRevision}
\def\version@packageThese{\RCSDate\space\versionnumber@these}
\ProvidesClass{these}[\version@packageThese]

\typeout{Style de thèse I3S, Nice (version non officielle)}
\typeout{© Association ADSTIC, Université Côte d'Azur}
\typeout{par Marie Pelleau.}
\typeout{\RCSId}

\LoadClass{memoir}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Option du document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@titlepage
\@titlepagetrue
% Informations de révisions (version, date d'impression...)
\newif\if@revision
\@revisionfalse

\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{memoir}%
}

\DeclareOption{revision}{\@revisiontrue}

% % we add this to the first page of each chapter

\ExecuteOptions{a4paper,11pt,twoside,onecolumn,final,openright,corps,symbol,openbib}
\ProcessOptions\relax

\headheight 13.6pt
\hoffset=-1cm
\voffset=-.3cm
\textwidth=15cm
\textheight=22cm
\oddsidemargin=2cm
\evensidemargin=1cm

\RequirePackage{graphicx}
\RequirePackage{tikz}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macros pour les informations de l'auteur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@titre{\ClassError{these}{Il manque le titre en français}{Utilisez la macro \noexpand\titre}}
\def\titre#1{\gdef\@titre{#1}}

\def\@title{\ClassError{these}{Il manque le titre en anglais}{Utilisez la macro \noexpand\title}}

\def\@soustitre{.}
\def\soustitre#1{\gdef\@soustitre{#1}}
\def\if@soustitre#1{\if\@soustitre.\else{#1\@soustitre}\fi}

\def\@subtitle{.}
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\if@subtitle#1{\if\@subtitle.\else{#1\@subtitle}\fi}

\def\@firstname{\ClassError{these}{Il manque le prénom de l'auteur}{Utilisez la macro \string\firstname}}
\def\firstname#1{\gdef\@firstname{#1}}

\def\@middlename{.}
\def\IFmiddlename{\if\@middlename.\else\@middlename\ \fi}
\def\middlename#1{\gdef\@middlename{#1}}

\def\@lastname{\ClassError{these}{Il manque le nom de l'auteur}{Utilisez la macro \string\lastname}}
\def\lastname#1{\gdef\@lastname{\Nom{#1}}}

\def\@laboratoire{Laboratoire d'Informatique, de Signaux et Systèmes de Sophia Antipolis (I3S)\\[.2cm]UMR 7271 UniCA CNRS}
\def\laboratoire#1{\gdef\@laboratoire{#1}}

\def\@discipline{\textsc{Informatique}}
\def\discipline#1{\gdef\@discipline{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Macros pour les informations du jury
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newbox{\@juryBox}
\newsavebox{\@juryBoxA}
\newcounter{nbRapporteurs}
\newcounter{nbExaminateurs}
\newcounter{nbInvites}

\newif\if@juryPresent
\@juryPresentfalse

\newif\if@hdr
\@hdrfalse
\def\hdr{\global\@hdrtrue}

\newif\if@master
\@masterfalse
\def\master{\global\@mastertrue}

\newcommand{\rapporteursname}{Rapporteurs}
\newcommand{\presidentname}{Président}
\newcommand{\examinateursname}{Examinateurs}
\newcommand{\invitesname}{Membres invités}
\newcommand{\directeurname}{Directeur de thèse}
\newcommand{\codirecteurname}{Co-directeur de thèse}
\newcommand{\coencadrantname}{Co-encadrant de thèse}

\def\@inconnu{\hbox to 2cm{\hrulefill}}

\def\@directeurThese{\@empty}
\def\directeur#1#2#3{\gdef\@directeurThese{#1, #2, #3}}

\def\@codirecteurThese{\@empty}
\def\codirecteur#1#2#3{\gdef\@codirecteurThese{#1, #2, #3}}

\def\@coencadrantThese{\@empty}
\def\coencadrant#1#2#3{\gdef\@coencadrantThese{#1, #2, #3}}

\def\@coTutelle{\@empty}
\def\cotutelle#1{\gdef\@coTutelle{#1}}

\def\@coTutelleLogo{\@empty}
\def\cotutellelogo#1{\gdef\@coTutelleLogo{#1}}

\def\@coFinanceursLogo{\@empty}
\def\cofinanceurslogo#1{\gdef\@coFinanceursLogo{#1}}

\def\@president{\@empty}
\def\president#1{\gdef\@president{#1}}
\gdef\@presidentAdr{\@empty}
\def\creerPresident #1/#2+{\gdef\@president{#1}\gdef\@presidentAdr{#2}}

\gdef\@rapporteurs{}
\gdef\@examinateurs{}
\gdef\@invites{}

\newenvironment{jury}[1][+]{%
  \if#1+\else \creerPresident #1+\fi%
  \global\@juryPresenttrue%
  \def\rapporteur##1##2##3{\stepcounter{nbRapporteurs}
    ##1, ##2, ##3 \\
    \g@addto@macro\@rapporteurs{##1, ##2, ##3 \\}
  }
  \def\examinateur##1##2##3{\stepcounter{nbExaminateurs}
    ##1, ##2, ##3 \\
    \g@addto@macro\@examinateurs{##1, ##2, ##3 \\}
  }
  \def\invite##1##2##3{\stepcounter{nbInvites}
    ##1, ##2, ##3 \\
    \g@addto@macro\@invites{##1, ##2, ##3 \\}
  }
  \begin{lrbox}{\@juryBoxA}
    \begin{tabular}{p{0.45\linewidth}}
      \if\@president\@empty\else\@president, \@presidentAdr \\\fi
      }{\end{tabular}\end{lrbox}%
  \global\setbox\@juryBox=\vbox{\copy\@juryBoxA}}

\newcommand{\juryDefaut}{%
  \def\rapporteur##1##2##3{\ifnum\value{nbRapporteurs}>0 \else%
      \hbox to 2.8cm{\rapporteursname\hss:}\fi \stepcounter{nbRapporteurs}
    & ##1, ##2\\& ##3 \\}
  \def\examinateur##1##2##3{\ifnum\value{nbExaminateurs}>0 \else%
      \hbox to 2.8cm{\examinateursname\hss:}\fi \stepcounter{nbExaminateurs}
    & ##1, ##2\\& ##3 \\}
  \def\invite##1##2##3{\ifnum\value{nbInvites}>0 \else%
      \hbox to 2.8cm{\invitesname\hss:}\fi \stepcounter{nbInvites}
    & ##1, ##2\\& ##3 \\}
  \begin{lrbox}{\@juryBoxA}
    \begin{tabular}{ll}
      \hbox to 2.8cm{\presidentname\hss:} & \if\@president\@empty \@inconnu\else\@president\fi       \\
                                          & \if\@presidentAdr\@empty \@inconnu\else\@presidentAdr\fi \\
      \rapporteur{\@inconnu}{\@inconnu}{\@inconnu}
      \rapporteur{\@inconnu}{\@inconnu}{\@inconnu}
      \examinateur{\@inconnu}{\@inconnu}{\@inconnu}
      \examinateur{\@inconnu}{\@inconnu}{\@inconnu}
      \examinateur{\@inconnu}{\@inconnu}{\@inconnu}
      \invite{\@inconnu}{\@inconnu}{\@inconnu}
    \end{tabular}\end{lrbox}%
  \global\setbox\@juryBox=\vbox{\copy\@juryBoxA}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abstract et résumé du manuscrit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@keywords{\@empty}
\def\keywords#1{\gdef\@keywords{#1}}

\def\@motscles{\@empty}
\def\motscles#1{\gdef\@motscles{#1}}

\newsavebox{\fourth@coverA} % Sauvegarde du résumé pour la 4e de couverture.
\newsavebox{\fourth@coverB}
\newbox{\fourth@coverGlobA}
\newbox{\fourth@coverGlobB}
\newlength{\abstractwidth}
\setlength{\abstractwidth}{\textwidth}
\newlength{\abs@width}

\renewenvironment{abstract}{
  \setlength{\abs@width}{\abstractwidth}
  \addtolength{\abs@width}{-15\p@}
  \begin{lrbox}{\fourth@coverA}
    \begin{minipage}{\abstractwidth}
      \begin{center}\begin{otherlanguage}{english}
          {\large\bfseries\abstractname}\par\vspace{.4cm}
          \begin{minipage}{\abs@width}}%
            {\end{minipage}\end{otherlanguage}
      \end{center}
    \end{minipage}
  \end{lrbox}%
  \global\setbox\fourth@coverGlobA=\vbox{\copy\fourth@coverA}}

\newenvironment{resume}{
  \setlength{\abs@width}{\abstractwidth}
  \addtolength{\abs@width}{-15\p@}
  \begin{lrbox}{\fourth@coverB}
    \begin{minipage}{\abstractwidth}
      \begin{center}
        {\large\bfseries\resumename}\par\vspace{.4cm}
        \begin{minipage}{\abs@width}}%
          {\end{minipage}
      \end{center}
    \end{minipage}
  \end{lrbox}%
  \global\setbox\fourth@coverGlobB=\vbox{\copy\fourth@coverB}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Résumé et toc des chapitres
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\chapres}[2]{
  \bigskip{\par\begingroup\hsize=0.94\textwidth\leftskip=0.04\textwidth\itshape\smallskip\noindent
    #1
    \par

    \noindent\hrulefill

    \smallskip\noindent
    #2
    \par\endgroup\smallskip}
  \leftskip=0cm

  \bigskip
  \begin{minipage}{0.9\textwidth}\minitoc\end{minipage}\clearforchapter}

\newcommand{\chapintro}[1]{
  \bigskip{\par\begingroup\hsize=0.94\textwidth\leftskip=0.04\textwidth\itshape\smallskip\noindent
    #1
    \par\endgroup\smallskip}
  \leftskip=0cm

  \bigskip
  \begin{minipage}{0.9\textwidth}\minitoc\end{minipage}\clearforchapter}

\newcommand{\chaptoc}{
  \bigskip\begin{center}
    \begin{minipage}{0.9\textwidth}\minitoc\end{minipage}\clearforchapter\end{center}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Environnements personnalisés
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@epigraphWithAuthor
\newif\if@epigraphWithTitle
\newsavebox{\epigraph@boxauthor}
\newsavebox{\epigraph@boxtitle}
\setlength{\epigraphwidth}{10cm}
\newenvironment{epigraphe}[3][french]{%
  \vspace*{-12pt}
  \ifx#2*
    \global\@epigraphWithAuthorfalse
  \else
    \savebox{\epigraph@boxauthor}{#2}
    \global\@epigraphWithAuthortrue
  \fi
  \ifx#3*
    \global\@epigraphWithTitlefalse
  \else
    \savebox{\epigraph@boxtitle}{#3}
    \global\@epigraphWithTitletrue
  \fi
  \medskip
  \begin{otherlanguage}{#1}
    \begin{flushright}
      \begin{minipage}{\epigraphwidth}
        \begin{itshape}}%
          {\end{itshape}
      \end{minipage}
      \if@epigraphWithAuthor
        \par\medskip ---~\usebox{\epigraph@boxauthor}%
        \if@epigraphWithTitle%
          , \usebox{\epigraph@boxtitle}%
        \fi
        .
      \else
        \if@epigraphWithTitle
          \par\medskip ---~\usebox{\epigraph@boxtitle}.
        \fi
      \fi
      \bigskip
    \end{flushright}
  \end{otherlanguage}}

\newenvironment{dedicace}{\if@openright\cleardoublepage\else\clearpage\fi%
  \thispagestyle{empty}\vspace*{1cm}\begin{flushright}\itshape}{\end{flushright}
  \vfill}

\newcommand{\acknowledgementname}{Remerciements}
\newenvironment{remerciements}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \chapter*{\acknowledgementname}}{\vfill\thispagestyle{empty}}


% Page de résumé et de mots-clés
\newenvironment{ResumeMotsCles}{
  \cleardoublepage
  \thispagestyle{empty}
  \enlargethispage{2cm}
  \vspace*{-2.5cm}
}{
  \begin{center}\Large\bfseries\@titre\end{center}

  \noindent\unvcopy\fourth@coverGlobB
  \ifx\@motscles\@empty\else
    \smallskip
    \noindent\textbf{Mots-clés :} \@motscles
  \fi
  \vspace{1cm}
  \begin{center}\Large\bfseries\@title\end{center}
  \smallskip
  \noindent\unvcopy\fourth@coverGlobA
  \ifx\@keywords\@empty\else
    \smallskip
    \noindent\textbf{Keywords:} \foreignlanguage{english}{\@keywords}
  \fi
  \vspace{1cm}
  \newpage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Définition du style pour les titres des chapitres
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makechapterstyle{chapterhead}{%
  \chapterstyle{default}
  \renewcommand*{\chapnamefont}{\normalfont\fontsize{28pt}{37pt}\selectfont}
  \renewcommand*{\chapnumfont}{\normalfont\fontsize{60pt}{37pt}\selectfont}
  \renewcommand*{\printchaptername}{\raggedleft\chapnamefont \textsc{\@chapapp}}
  \renewcommand*{\printchapternum}{\chapnumfont\thechapter \vskip\onelineskip\hrule}
  \renewcommand*{\chaptitlefont}{\usefont{T1}{ptm}{b}{n}\fontsize{35pt}{37pt}\selectfont}
  \renewcommand*{\printchaptertitle}[1]{
    \raggedleft \chaptitlefont\textbf{##1}\par}
  \renewcommand*{\afterchaptertitle}{\vskip\afterchapskip}
  \renewcommand*{\printchapternonum}{}
  \if@revision
    \makeoddfoot{plain}{\textbf{\jobname.tex}~--~{%
    \@titre}~--~\number\day/\number\month/  \number\year~--~\timenow}{}{\thepage}
  \fi
}


\newcommand{\Chapter}[1]{
  \chapter*{#1}%
  \addcontentsline{toc}{chapter}{#1}\adjustmtc}

\cftpagenumbersoff{part}

\newcommand{\Part}[1]{
  \part*{#1}%
  \addcontentsline{toc}{part}{\hfill #1\hfill\ignorespaces}}


\let\persistentAppendix\appendix
\renewcommand{\appendix}{
  \Part{\appendixname}
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}
  \setsecnumdepth{subsection}
}


\newif\ifchapternonum
\chapternonumfalse
\makechapterstyle{cleanthesis}{%
  \chapterstyle{default}
  \renewcommand*{\chapterheadstart}{\vspace*{-5cm}}
  \renewcommand*{\chapnamefont}{}
  \renewcommand*{\chapnumfont}{\fontsize{60}{60}\selectfont}
  \renewcommand*{\chaptitlefont}{\normalfont\huge \fontfamily{phv}\selectfont}
  \renewcommand*{\printchaptername}{}
  \renewcommand*{\chapternamenum}{}
  \renewcommand*\printchapternonum{\chapternonumtrue}
  \renewcommand*{\printchapternum}{}
  \renewcommand*{\printchaptertitle}[1]{
    \raggedleft \chaptitlefont{##1} \hfill
    \ifchapternonum
      \phantom{{\color{paon}\rule[-5pt]{2pt}{5cm}}\quad\chapnumfont\thechapter}
    \else
      {\color{paon}\rule[-5pt]{2pt}{5cm}}\quad{\color{paon}\chapnumfont \thechapter}
    \fi
    \quad}
  \makeoddfoot{plain}{}{}{{\color{paon}\rule[-90pt]{1.25pt}{100pt}}\quad\thepage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Définition du style pour les titres des chapitres
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makepagestyle{these}
\makeevenhead{these}{\thepage}{}{\leftmark}
\makeoddhead{these}{\rightmark}{}{\thepage}
\makepsmarks{these}{%
  \nouppercaseheads
  \createmark{chapter}{left}{shownumber}{\@chapapp\ }{\ ---\ }
  \createmark{section}{right}{shownumber}{}{\ ---\ }
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}
}

\makeheadrule{these}{\textwidth}{\normalrulethickness}

\makepagestyle{cthesis}
\makeevenfoot{cthesis}{\thepage\quad{\color{paon}\rule[-90pt]{1.25pt}{100pt}}\quad\leftmark}{}{}
\makeoddfoot{cthesis}{}{}{\rightmark\quad{\color{paon}\rule[-90pt]{1.25pt}{100pt}}\quad\thepage}
\makepsmarks{cthesis}{%
  \nouppercaseheads
  \createmark{chapter}{left}{shownumber}{\bfseries\@chapapp\ }{\ ---\ \color{paon}}
  \createmark{section}{right}{shownumber}{}{\ ---\ \color{paon}}
  \createplainmark{toc}{both}{\contentsname}
  \createplainmark{lof}{both}{\listfigurename}
  \createplainmark{lot}{both}{\listtablename}
  \createplainmark{bib}{both}{\bibname}
  \createplainmark{index}{both}{\indexname}
  \createplainmark{glossary}{both}{\glossaryname}
}

\aliaspagestyle{part}{empty}

\def\defaultstyle{
  \pagestyle{these}
  \chapterstyle{chapterhead}
}

\def\ctstyle{
  \pagestyle{cthesis}
  \chapterstyle{cleanthesis}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page de titre
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\timenow{%
  \@tempcnta=\time \divide\@tempcnta by 60 \number\@tempcnta:\multiply
  \@tempcnta by 60 \@tempcntb=\time \advance\@tempcntb by -\@tempcnta
  \ifnum\@tempcntb <10 0\number\@tempcntb\else\number\@tempcntb\fi}

\def\@leJury{
  \if@juryPresent
  \else%
    \juryDefaut
  \fi
  \vbox{\unvcopy\@juryBox}%
}

\def\@type{
  \if@hdr
    HABILITATION À DIRIGER\\[0.5cm]LES RECHERCHES
  \else
    \if@master
      MÉMOIRE DE MASTER
    \else
      THÈSE DE DOCTORAT
    \fi
  \fi
}

\def\@bloc{
  \if@hdr
    {\bfseries Présentée en vue de l’obtention de\\l'habilitation à diriger les recherche\\en} \@discipline\\
  \else
    \if@master
      {\bfseries Présentée en vue de l’obtention du\\diplôme de master\\en} \@discipline\\
      {\bfseries d'}Université Côte d'Azur
      \if\@coTutelle\@empty\else{\\\bfseries et de} \@coTutelle\fi\\[0.2cm]
      {\bfseries Stage encadré par :}\\\@directeurThese\\
      \if\@codirecteurThese\@empty\else\@codirecteurThese\\\fi
      \if\@coencadrantThese\@empty\else\@coencadrantThese\\\fi
    \else
      {\bfseries Présentée en vue de l’obtention\\du grade de docteur en} \@discipline\\
      {\bfseries d'}Université Côte d'Azur
      \if\@coTutelle\@empty\else{\\\bfseries et de} \@coTutelle\fi\\[0.2cm]
      {\bfseries Dirigée par :} \@directeurThese\\
      \if\@codirecteurThese\@empty\else{\bfseries Co-dirigée par :} \@codirecteurThese\\\fi
      \if\@coencadrantThese\@empty\else{\bfseries Co-encadrée par :} \@coencadrantThese\\\fi
    \fi
  \fi
  \if\@date\@empty\else{{\bfseries Soutenue le :} \@date}\fi
}

\renewcommand\maketitle{%
\if@titlepage
  % Début page de titre
  \begin{titlingpage}
    \fontfamily{ptm}\selectfont
    \enlargethispage{1cm}

    %%%% Entête de l'ED
    \begin{center}
      \begin{tikzpicture}[remember picture, overlay]
        \path (current page.north west) -- ++ (-\hoffset, -\voffset) node [inner sep = 0mm, anchor = north west] {\includegraphics[width=\paperwidth]{visuel.jpg}};

        \if\@coTutelleLogo\@empty\else
          \path (current page.north east) -- ++ (-\hoffset-1.5cm, -\voffset-1cm) node [inner sep = 0mm, anchor = north east] {\includegraphics[height=3cm]{\@coTutelleLogo}};
        \fi
      \end{tikzpicture}

      \vspace*{3.5cm}
      \hspace*{-1.5cm}
      \begin{minipage}[b][2cm]{16cm}
        \centering
        {\color{white}\fontsize{36pt}{36pt}\selectfont\bfseries\fontfamily{qhv}\selectfont
          \@type
        }
      \end{minipage}\\[1.5cm]

      \hspace*{-1.5cm}
      %%%% Bloc Titre + Sous-titre. S'étend vers le haut.
      \begin{minipage}{16cm}
        \centering
        \usefont{OT1}{phv}{m}{n}\fontsize{26pt}{26pt}\selectfont
        \@titre
        \if@soustitre{%
          \\[.5cm]%
          \fontsize{18pt}{18pt}%
          \selectfont%
        }
      \end{minipage}\\

      %%%% Bloc Auteur
      \hspace*{-1.5cm}
      \begin{minipage}{16cm}
        \centering
        \vspace*{1.5cm}
        {\fontsize{24pt}{24pt}\selectfont\bfseries\fontfamily{phv}\selectfont \@firstname\ \IFmiddlename \@lastname}\\[0.5cm]
        {\fontsize{14pt}{14pt}\selectfont \@laboratoire}
      \end{minipage}\\[1.cm]

      \hspace*{-1.cm}
      \if@master
        \begin{minipage}[t]{\linewidth}
          \fontsize{11pt}{14pt}\selectfont
          \@bloc
        \end{minipage}\hspace*{0.5cm}
      \else
        %%%% Bloc Thèse
        \begin{minipage}[t]{7.cm}
          \fontsize{11pt}{14pt}\selectfont
          \@bloc
        \end{minipage}\hspace*{0.5cm}
        %%%% Bloc Jury
        \begin{minipage}[t]{7.5cm}
          \fontsize{11pt}{14pt}\selectfont
          {\bfseries Devant le jury, composé de :}

          \hspace*{-0.3cm}\@leJury
        \end{minipage}\\[1cm]
      \fi

      \vfill
      \hspace*{-2.cm}
      \if\@coFinanceursLogo\@empty \else
        \foreach \img in \@coFinanceursLogo {
          \includegraphics[height=2cm]{\img}\hfill
        }
      \fi
    \end{center}
  \end{titlingpage}
\fi
\voffset=-.3cm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Troisième page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\hoffset=.7cm
{\textheight=0.8\paperheight
\cleardoublepage % Création de la page de titre
\mbox{ }
\hspace*{-1.1cm}
\begin{center}
  \Large\bfseries
  {%
    \scshape\@titre%
    \if@soustitre{\\[.5cm]\large}%
  }\par
  \vspace*{.25cm}\par
  \rule{3cm}{.1mm}\par
  \vspace*{.25cm}
  \Large\bfseries
  \textit{\@title}
  \if@subtitle{\\[.3cm]\large\bfseries\itshape} \par
  \vspace{1.5cm}
  \@firstname\ \IFmiddlename \@lastname
  \par
  \vspace*{1cm}
  {\Huge $\triangleright$\hspace{-3pt}$\triangleleft$}\par
\end{center}
\vspace*{2.cm}
\if@master
  {\Large\bfseries Stage encadré par :}\\[0.5cm]
  {\large
  \@directeurThese\\[0.1cm]
  \if\@codirecteurThese\@empty\else\@codirecteurThese\\[0.1cm]\fi
  \if\@coencadrantThese\@empty\else\@coencadrantThese\\[0.1cm]\fi
  }
\else
  {\Large\bfseries Jury :}\\[0.5cm]
  {\large
  \if\@president\@empty\else{\bfseries \presidentname\xspace du jury}\\[0.1cm]
    \@president, \@presidentAdr\\[0.3cm]\fi
  {\bfseries \rapporteursname}\\[0.1cm]
  \@rapporteurs\\[-0.2cm]
  {\bfseries \examinateursname}\\[0.1cm]
  \@examinateurs\\[-0.2cm]
  \if@hdr
  \else
    {\bfseries \directeurname}\\[0.1cm]
    \@directeurThese\\[0.2cm]
    \if\@codirecteurThese\@empty\else{\bfseries \codirecteurname}\\[0.1cm]
      \@codirecteurThese\\[0.2cm]\fi
    \if\@coencadrantThese\@empty\else{\bfseries \coencadrantname}\\[0.1cm]
      \@coencadrantThese\\[0.2cm]\fi
    \if\@invites\@empty\else{\bfseries \invitesname}\\[0.1cm]
      \@invites\\[0.2cm]\fi
  \fi
  }
\fi
\vfill
\begin{center}
  \makebox[5cm]{\hrulefill}\par
  Université Côte d'Azur
\end{center}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quatrième page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newpage\hoffset=-1cm \thispagestyle{empty}
\enlargethispage{2cm}
\vspace*{3cm}
\@firstname\ \IFmiddlename \@lastname\par \smallskip
\hspace*{.6cm}
\begin{minipage}{13cm} \parindent 0pt
  {\textit{\textbf{{\def\\{}\@titre}\if@soustitre{\\ \def\\{}\footnotesize}}}}
\end{minipage}
\par \smallskip
\hspace*{.6cm}\pageref{last@page@front}$+$\pageref{LastPage} p.

\vfill
{\tiny
  \begin{minipage}{8cm}
    \parindent 0pt
    Ce document a été préparé avec \LaTeX2e et
    la classe \texttt{these-ISSS} version~\versionnumber@these.
  \end{minipage}


  \vspace{4\p@}
  \textit{Impression~: \jobname.tex~--~\number\day/\number\month/%
    \number\year~--~\timenow}

  \textit{Révision pour la classe : \RCSId}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Divers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\defaultindexname{Index par défaut}

\RequirePackage[english,french]{babel}

\newcommand{\Nom}[1]{{\textsc{#1}}}
