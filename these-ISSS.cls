%%-----------------------------------------------------------------------------
%% these-ISSS.cls --
%% Style de thèse pour l'I3S
%%   [Laboratoire d'Informatique, de Signaux et Systèmes de Sophia-Antipolis]
%% Auteur : Frédéric Goualard (Frederic.Goualard@cwi.nl)
%%          Centrum voor Wiskunde en Informatica, The Netherlands
%%          Modifié par DoccY <alban.mancheron@univ-nantes.fr>
%%          Modifié par Marie Pelleau <Marie.Pelleau@unice.fr>
%%          I3S, France
%% Maintenance : 
%%         Association ADSTIC
%% Style basé sur 'these-LINA.cls'
%% CVS Id: $Id: these-ISSS.cls,v 2.10 2020/06/24 14:16:37 mpelleau $
%%-----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\IfFileExists{rcs.sty}{%
	\RequirePackage{rcs}%
}{%
\AtEndOfClass{%
	\ClassWarningNoLine{these-ISSS}{%
		Impossible de charger le package rcs[-latex].%
	}%
}%
\def\RCS $##1: ##2 ${\expandafter\def\csname RCS##1\endcsname{##2}}%
}
\RCS $Revision: 2.10 $
\RCS $Date: 2020/06/24 14:16:37 $
\RCS $Id: these-ISSS.cls,v 2.10 2020/06/24 14:16:37 mpelleau $
\def\versionnumber@these{v. \RCSRevision}
\def\version@packageThese{\RCSDate\space\versionnumber@these}
\ProvidesClass{these-ISSS}[\version@packageThese]
\def\LoGiN{%
	L\kern-.25em\raise.4ex%
	\hbox{\sc o}%
	\kern-.05emG\kern-.05em%
	\lower.5ex\hbox{I}\kern-.05emN%
	\spacefactor1000%
	\xspace%
}
\typeout{Style de thèse I3S, Nice (version non officielle)}
\typeout{© Association ADSTIC, Université Côte d'Azur}
\typeout{par Frédéric Goualard, ..., Lucas, Norwin, DoccY, Marie Pelleau.}
\typeout{\RCSId}

\RequirePackage{keyval}%
\RequirePackage{color}
\RequirePackage[final]{graphicx}
\graphicspath{{images//}{img//}{fig//}}
\IfFileExists{pst-grad}{\RequirePackage{pst-grad}}{\RequirePackage{gradient}}
\RequirePackage{amsthm}
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{times}
\RequirePackage{fancyvrb}
\RequirePackage{fancybox}
\RequirePackage{lastpage}
\RequirePackage{eso-pic}
\RequirePackage{pgffor}
\frenchspacing

%% Emprunté sur http://www.tuteurs.ens.fr/logiciels/latex/nouveau_package.html %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pour gérer les deux types d'options :                                  %
%  1. les options normales (\DeclareOption{...}{...})                    %
%  2. les options type key-val option=value (\define@key{...}{...}{...}) %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\@ifundefined{my@unusedlist}{%
	\let\my@unusedlist\@empty}{}
\@ifundefined{my@extractkey}{%
	\def\my@extractkey#1=#2\my@extractkey{#1}}{}
\newcommand{\ProcessUnusedOptions}[1]{%
	\let\my@tempa\@empty
	\let\my@tempb\@empty
	\@for\CurrentOption:=\my@unusedlist\do{%
		\expandafter\expandafter\expandafter\def
		\expandafter\expandafter\expandafter\my@key
		\expandafter\expandafter\expandafter{%
			\expandafter\my@extractkey\CurrentOption=\my@extractkey}%
		\@ifundefined{KV@#1@\my@key}{%
			\edef\my@tempa{\my@tempa,\CurrentOption,}}{%
			\edef\my@tempb{\my@tempb,\CurrentOption,}}}%
	\@for\CurrentOption:=\my@tempa\do{%
		\ifx\CurrentOption\@empty\else
		\ClassWarning{these-ISSS}{%
			l'option ``\CurrentOption'' n'est pas d\string éfinie.
			Cette option sera pass\string ée aux packages
			pr\string écharg\string és par la classe.%
		}\fi%
	}
	\edef\my@tempb{%
		\noexpand\setkeys{#1}{\my@tempb}}%
	\my@tempb
	\AtEndOfClass{\let\@unprocessedoptions\relax}
}

\DeclareOption*{%
	\expandafter\expandafter\expandafter\def
	\expandafter\expandafter\expandafter\my@unusedlist
	\expandafter\expandafter\expandafter{%
		\expandafter\my@unusedlist\expandafter,%
		\CurrentOption}}
%%%%%%%%%%%%%%%
% Fin du bloc %
%%%%%%%%%%%%%%%

% CONFIGURATION DE LA CÉSURE (-> Axel Reichert)
\tolerance = 1414
\hbadness = 1414
\emergencystretch 1.5em
\hfuzz 0.3pt
\widowpenalty=10000
\vfuzz \hfuzz
\raggedbottom


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mes variables										%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@blason@name{------}
\def\@blason@width{30mm}
\def\blason#1#2{\def\@blason@name{#2}\def\@blason@width{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Option du document							%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\@ptsize{}
\newif\if@inAnnexe
\newif\if@intables
\@intablesfalse
\@inAnnexefalse
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
% Informations de révisions (version, date d'impression...)
\newif\if@revision
\@revisionfalse
\newif\if@openright
\newif\if@withParts
\@withPartsfalse
\if@compatibility\else
\DeclareOption{revision}{\@revisiontrue}
\DeclareOption{annexe}
{\@inAnnexetrue}
\DeclareOption{corps}
{\@inAnnexefalse}
\DeclareOption{a4paper}
{\setlength\paperheight {297mm}%
	\setlength\paperwidth  {210mm}}
\DeclareOption{parts}
{\global\@withPartstrue}
\fi
\if@compatibility
\renewcommand\@ptsize{0}
\else
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{%
	\AtEndOfPackage{%
		\RequirePackage[french, first, bottomafter, outline]{draftcopy}%
		\RequirePackage{showkeys}%
		\def\SK@refcolor{\lightgray}%
		\def\SK@labelcolor{\lightgray}%
		\setlength\overfullrule{5pt}%
	}%
}
\if@compatibility\else
\DeclareOption{final}{
	\setlength\overfullrule{0pt}
	\def\SK@refcolor{\lightgray}%
	\def\SK@labelcolor{\lightgray}%
}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility
\else
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\fi
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\newif\if@footnoteArabic
\DeclareOption{arabic}{\@footnoteArabictrue}
\DeclareOption{symbol}{\@footnoteArabicfalse}
\newif\if@beurkEnglish
\@beurkEnglishfalse
\DeclareOption{beurkAlAnglaise}{\@beurkEnglishtrue}
\DeclareOption{openbib}{%
	\AtEndOfPackage{%
		\renewcommand\@openbib@code{%
			\advance\leftmargin\bibindent
			\itemindent -\bibindent
			\listparindent \itemindent
			\parsep \z@
		}%
		\renewcommand\newblock{\par}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifb@ckref
\b@ckreffalse
\define@key{these-ISSS}{backref}[pageref]{%
	\gdef\b@ckrefstyle{#1}
	\def\@tmp{pageref}
	\ifx\b@ckrefstyle\@tmp
	\gdef\b@ckrefnamesingulier{\`a la page\xspace}
	\gdef\b@ckrefnamepluriel{aux pages\xspace}
	\else
	\gdef\b@ckrefnamesingulier{dans la section\xspace}
	\gdef\b@ckrefnamepluriel{dans les sections\xspace}
	l
	\b@ckreftrue
}

\ExecuteOptions{a4paper,11pt,twoside,onecolumn,final,openright,corps,symbol}
\ProcessOptions
\ProcessUnusedOptions{these-ISSS}

\input{size1\@ptsize.clo}

\RequirePackage{fancyhdr}
\headheight 13.6pt
\hoffset=-1cm
\voffset=-.3cm
\textwidth=15cm
\textheight=22cm
\oddsidemargin=2cm
\evensidemargin=1cm

\RequirePackage[english,french]{babel}
\selectlanguage{french}
%\NoAutoSpaceBeforeFDP

\newif\if@mainmatter
\newbox{\fourth@coverGlobA}
\newbox{\fourth@coverGlobB}

\if@inAnnexe
\def\pagenumbering#1{%
	\global\c@page \@ne \gdef\thepage{A-\csname @#1\endcsname
		\c@page}}
\fi

\def\cleardoublepage{\clearpage\thispagestyle{empty}%
	\if@twoside \ifodd\c@page\else
	\hbox{}\newpage\thispagestyle{empty}\if@twocolumn\hbox{}\newpage\fi\fi\fi}

% fichier de labels.
\newwrite\@lblout
\openout\@lblout=\jobname.lbl


\def\timenow{%
	\@tempcnta=\time \divide\@tempcnta by 60 \number\@tempcnta:\multiply
	\@tempcnta by 60 \@tempcntb=\time \advance\@tempcntb by -\@tempcnta
	\ifnum\@tempcntb <10 0\number\@tempcntb\else\number\@tempcntb\fi}


%------------------------------------------------------------------------------


\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\if@twoside
\def\ps@headings{%
	\let\@oddfoot\@empty\let\@evenfoot\@empty
	\let\@mkboth\markboth
	\let\@mkright\markright
	\def\chaptermark##1{%
		\markboth {\MakeUppercase{%
				\ifnum \c@secnumdepth >\m@ne
				\if@mainmatter
				\@chapapp\ \thechapter. \ %
				\fi 
				\fi
				##1}}{}}%
	\def\sectionmark##1{%
		\markright {\MakeUppercase{%
				\ifnum \c@secnumdepth >\z@
				\if@mainmatter
				\thesection. \ %
				\fi
				\fi
				##1}}}
	\def\@evenhead{\thepage\hfil\slshape\leftmark}%
	\def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
}
\else
\def\ps@headings{%
	\let\@oddfoot\@empty\let\@evenfoot\@empty
	\let\@mkboth\markboth
	\let\@mkright\markright
	\def\chaptermark##1{%
		\markboth {\MakeUppercase{%
				\ifnum \c@secnumdepth >\m@ne
				\if@mainmatter
				\@chapapp\ \thechapter. \ %
				\fi  
				\fi
				##1}}}
	\def\sectionmark##1{%
		\markright {\MakeUppercase{%
				\ifnum \c@secnumdepth >\z@
				\if@mainmatter
				\thesection. \ %
				\fi
				\fi
				##1}}}
	\def\@evenhead{\thepage\hfil\slshape\leftmark}%
	\def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
}
\fi

\newlength{\titlewidth}
\setlength{\titlewidth}{10cm}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Page du titre														%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\ps@myheadings{%
	\let\@oddfoot\@empty\let\@evenfoot\@empty
	\def\@evenhead{\thepage\hfil\slshape\leftmark}%
	\def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
	\let\@mkboth\@gobbletwo
	\let\chaptermark\@gobble
	\let\sectionmark\@gobble
}

\def\@leJury{
	\if@juryPresent
	\else%
	\juryDefaut
	\fi
	\vbox{\unvcopy\@juryBox}%
}

% Début des pages de titre
\if@titlepage
\newcommand\maketitle{%
	% Début page de titre
	\begin{titlepage}
	
	\fontfamily{ptm}\selectfont
		\enlargethispage{3.5cm}
		\begin{center}
		
			%%%% Entête de l'ED
			\AddToShipoutPicture*{
		 		\put(25.75, 262){ 
					\parbox[b][\paperheight]{\paperwidth}{ 
						\vfill 
						\includegraphics[width=\paperwidth]{visuel_STIC.jpg}
						\vfill 
					}
				}
				
				\if\@coTutelleLogo\@empty\else
		 		\put(430, 715){ 
					\parbox[t][4cm]{10cm}{ 
						\includegraphics[height=3cm]{\@coTutelleLogo}
					}
				}
				\fi
			}
			
			
			\vspace*{3.5cm}
			\hspace*{-1.5cm}
			\begin{minipage}[b][2cm]{16cm}
				\centering
				{\color{white}\fontsize{36pt}{36pt}\selectfont\bfseries\fontfamily{qhv}\selectfont 
					\if@hdr
						HABILITATION À DIRIGER\\[0.5cm]LES RECHERCHES
					\else
						THÈSE DE DOCTORAT
					\fi
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
			
			%%%% Bloc Thèse
			\hspace*{-1.cm}
			\begin{minipage}[t]{7.cm}
				\fontsize{11pt}{14pt}\selectfont
				\if@hdr
				{\bfseries Présentée en vue de l’obtention de\\l'habilitation à diriger les recherche\\en} \@discipline\\
				\else
				{\bfseries Présentée en vue de l’obtention\\du grade de docteur en} \@discipline\\
				{\bfseries d'}Université Côte d'Azur
				\if\@coTutelle\@empty\else{\\\bfseries et de} \@coTutelle\fi\\[0.2cm]
				{\bfseries Dirigée par :} \@directeurThese\\
				\if\@codirecteurThese\@empty\else{\bfseries Co-dirigée par :} \@codirecteurThese\\\fi
				\if\@coencadrantThese\@empty\else{\bfseries Co-encadrée par :} \@coencadrantThese\\\fi
				\fi
				\if\@date\@empty\else{{\bfseries Soutenue le :} \@date}\fi
			\end{minipage}\hspace*{0.5cm}
			%%%% Bloc Jury
			\begin{minipage}[t]{7.5cm}
				\fontsize{11pt}{14pt}\selectfont
				{\bfseries Devant le jury, composé de :}
				
				\hspace*{-0.3cm}\@leJury

			\end{minipage}\\[1cm]
			
			\vfill
			\hspace*{-2.cm}
			\if\@coFinanceursLogo\@empty \else
				\foreach \img in \@coFinanceursLogo {
					\includegraphics[height=2cm]{\img}\hfill
				}
			\fi
			\end{center}
		\end{titlepage}
		\voffset=-.3cm
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Troisième page																	%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		\hoffset=.7cm
		\cleardoublepage % Création de la page de titre
		\mbox{ }
		%  \rput(5.9,-3){ \includegraphics[width=\@blason@width]{\@blason@name}}
		%  \rput(5.9,-5){\normalsize\it favet neptunus eunti}
		\hspace*{-1.1cm}\begin{minipage}{14cm}
			\begin{center}
				\Large\bf
				\vspace*{2.5cm}
				{%
					\scshape\@titre%
					\if@soustitre{\\[.5cm]\large}%
				}\par
				\vspace*{.25cm}\par
				\rule{3cm}{.1mm}\par
				\vspace*{.25cm}
				\Large\bf
				\textit{\@title}
				\if@subtitle{\\[.3cm]\large\bfseries\itshape} \par
				\vspace{1.5cm}
				\@firstname\ \IFmiddlename \@lastname
				\par
				\vspace*{1cm}
				{\Huge $\triangleright$\hspace{-3pt}$\triangleleft$}\par
			\end{center}
			\vspace*{2.cm}
			{\Large\bf Jury :}\\[0.5cm]
			{\large
			\if\@president\@empty\else{\bf \presidentname\xspace du jury}\\[0.1cm]
			\@president, \@presidentAdr\\[0.3cm]\fi
			{\bf \rapporteursname}\\[0.1cm]
			\@rappoteurs\\[-0.2cm]
			{\bf \examinateursname}\\[0.1cm]
			\@examinateurs\\[-0.2cm]
			{\bf \invitesname}\\[0.1cm]
			\@invites
			}
			\vspace*{2.cm}
			\begin{center}
				\makebox[5cm]{\hrulefill}\par
				Université Côte d'Azur
			\end{center}
		\end{minipage}
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Quatrième page															%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
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
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Pages des résumés	et mots clés								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
		\newpage
		\setcounter{footnote}{0}%
		\global\let\thanks\relax
		\global\let\maketitle\relax
		\global\let\@thanks\@empty
		%  \global\let\@author\@empty
		\global\let\@date\@empty
		%  \global\let\@title\@empty
		\global\let\title\relax
		\global\let\date\relax
		\global\let\and\relax
	}
	\else
	\newcommand\maketitle{\par
		\begingroup
		\renewcommand\thefootnote{\@fnsymbol\c@footnote}%
		\def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
		\long\def\@makefntext##1{\parindent 1em\noindent
			\hb@xt@1.8em{%
				\hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
		\if@twocolumn
		\ifnum \col@number=\@ne
		\@maketitle
		\else
		\twocolumn[\@maketitle]%
		\fi
		\else
		\newpage
		\global\@topnum\z@   % Prevents figures from going at top of page.
		\@maketitle
		\fi
		\thispagestyle{plain}\@thanks
		\endgroup
		\setcounter{footnote}{0}%
		\global\let\thanks\relax
		\global\let\maketitle\relax
		\global\let\@maketitle\relax
		\global\let\@thanks\@empty
		%  \global\let\@author\@empty
		\global\let\@date\@empty
		%  \global\let\@title\@empty
		\global\let\title\relax
		\global\let\date\relax
		\global\let\and\relax
	}
	\def\@maketitle{%
		\newpage
		\null
		\vskip 2em%
		\begin{center}%
			\let \footnote \thanks
			{\LARGE\bfseries\@titre\if@soustitre{\\[5mm]\Large}}\par%
			\vskip 1.5em%
			{\large
				\lineskip .5em%
				\begin{tabular}[t]{c}%
					\@firstname\ \IFmiddlename \@lastname
				\end{tabular}\par}%
			\vskip 1em%
			{\large \@date}%
		\end{center}%
		\par
		\vskip 1.5em}
	\fi
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Fin title													%
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	\newcommand*\chaptermark[1]{}
	\setcounter{secnumdepth}{3}
	\newcounter {part}
	\newcounter {chapter}
	\newcounter {section}[chapter]
	\newcounter {subsection}[section]
	\newcounter {subsubsection}[subsection]
	\newcounter {paragraph}[subsubsection]
	\newcounter {subparagraph}[paragraph]
	\if@inAnnexe
	\renewcommand \thepart {}
	\renewcommand \thechapter {\@arabic\c@chapter}
	\renewcommand \thesection {\thechapter.\@arabic\c@section}
	\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
	\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
	\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
	\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
	\else%
	\renewcommand \thepart {}
	\renewcommand \thechapter {\@arabic\c@chapter}
	\renewcommand \thesection {\thechapter.\@arabic\c@section}
	\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
	\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
	\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
	\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
	\fi
	\newcommand\@chapapp{\chaptername}
	
	\gdef\partTitle{}
	\font\partfont=bchbc8t at 26pt
	
	\newcommand\Part{%
		\if@openright
		\cleardoublepage
		\else
		\clearpage
		\fi%
		\if@twocolumn
		\onecolumn
		\@tempswatrue
		\else
		\@tempswafalse
		\fi
		\null\vfil
		\secdef\@Part\@Spart}
	
	\def\@Part[#1]#2{%
		\gdef\partTitle{#1}
		\ifnum \c@secnumdepth >-2\relax
		\refstepcounter{part}%
		\addtocontents{toc}{\protect\contentsline{part}{#1}{\protect{\thepart}}{part.\arabic{part}}}%
%		\addtocontents{lox}{\protect\contentsline{part}{#1}{\protect{\thepart}}{part.\arabic{part}}}%
%		\addtocontents{lof}{\protect\contentsline{part}{#1}{\protect{\thepart}}{part.\arabic{part}}}%
%		\addtocontents{lot}{\protect\contentsline{part}{#1}{\protect{\thepart}}{part.\arabic{part}}}%
		\else
		\addcontentsline{toc}{part}{#1}%
%		\addcontentsline{lox}{part}{#1}%
%		\addcontentsline{lof}{part}{#1}%
%		\addcontentsline{lot}{part}{#1}%
		\fi
		\markboth{}{}%
		{\centering
			\interlinepenalty \@M
			\normalfont
			\ifnum \c@secnumdepth >-2\relax
			{\partfont\partname~\thepart}
			\par
			\vskip 20\p@
			\fi
			\Huge \bfseries #2\par}%
		\thispagestyle{empty}}
	\def\@Spart#1{%
		{\centering
			\interlinepenalty \@M
			\normalfont
			\Huge \bfseries #1\par}}
	
	\let\part=\Part
	
	
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Résumé et toc des chapitre %
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	\def\mycleardoublepage{\clearpage
		\if@twoside\ifodd\c@page \else
		\thispagestyle{empty}\hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}
	
	\newcommand{\chapres}[2]{
		\bigskip
		\begin{center}
			{\it
				\begin{minipage}{0.9\textwidth}
					#1
					
					\hrulefill
					
					#2
				\end{minipage}}
				
				\bigskip
				\begin{minipage}{0.9\textwidth}\minitoc\end{minipage}\mycleardoublepage\end{center}}
		
		\newcommand{\chapintro}[1]{
			\bigskip\begin{center}{\it\begin{minipage}{0.9\textwidth}#1\end{minipage}}
				
				\bigskip
				\begin{minipage}{0.9\textwidth}\minitoc\end{minipage}\mycleardoublepage\end{center}}
		
		\newcommand{\chaptoc}{
			\bigskip\begin{center}
				\begin{minipage}{0.9\textwidth}\minitoc\end{minipage}\mycleardoublepage\end{center}}
		
		
		
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Styles pour les têtes de chapitres	 %
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
		% Chapitre numéroté (\chapter{})
		\newcommand{\chapitreN}[2]{%
			\begin{flushright}  
				\usefont{T1}{ptm}{m}{sc}\fontsize{28pt}{37pt}\selectfont
				\@chapapp\ 
				\usefont{T1}{ptm}{m}{n}\fontsize{60pt}{37pt}\selectfont #1%
			\end{flushright}
			\noindent\rule{\linewidth}{.9pt}\par
			\vspace{5mm}
			%\noindent\psline(0,.5)(\textwidth,.5)\par
			%\hfill\begin{minipage}{15cm}
			\hfill\begin{minipage}{13cm}
				\begin{flushright}
					\usefont{T1}{ptm}{b}{n}\fontsize{35pt}{37pt}\selectfont #2%
				\end{flushright}
			\end{minipage}
			\if@revision
			\footnotetext{%
				\textbf{\jobname.tex}~--~{%
					\def\\{}\@titre}~--~\number\day/\number\month/%
				\number\year~--~\timenow}
			\fi 
		}
		% Chapitre non numéroté (\chapter*{})
		\newcommand{\chapitre}[1]{%
			\begin{flushright}
				%\begin{minipage}{15cm}
				\begin{minipage}{13cm}
					\begin{flushright}
						\usefont{T1}{ptm}{b}{n}\fontsize{35pt}{37pt}\selectfont #1%
					\end{flushright}
				\end{minipage}
				\if@revision
				\footnotetext{%
					\textbf{\jobname.tex}~--~{%
						\def\\{}\@titre}~--~\number\day/\number\month/%
					\number\year~--~\timenow}
				\fi 
			\end{flushright}
			\noindent\rule{\linewidth}{.9pt}\par
			%\noindent\psline(0,0)(\textwidth,0)\par
		}
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Redéfinition Chapitre											%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
		\gdef\chapterTitle{}
		%\def\chapter#1{\begin{flushright} \begin{minipage}{100mm} \begin{flushright} \Huge \textsc{Chapitre} \thechapter\\ \textbf{#1} \end{flushright}\end{minipage} \end{flushright} }
		\renewcommand{\sectionmark}[1]{\markright{\thesection{} #1}}
		\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
			\if@intables
			\lhead[\thepage]{\chapterTitle}
			\rhead[\chapterTitle]{\thepage}
			\else
			\if@inAnnexe
			\lhead[\thepage]{\textsc{Annexe}~\thechapter}
			\rhead[\textsc{Annexe}~\thechapter]{\thepage}
			\else
			\if@chapterStar
			\lhead[\thepage]{\chapterTitle}
			
			\if@withParts
			\if&\partTitle&
			\rhead[\leftmark]{\thepage}
			\else
			\rhead[\textsc{Partie}\hskip1ex\thepart~---~\partTitle\relax]{\thepage}
			\fi
			\else
			\rhead[\leftmark]{\thepage}
			\fi
			\else
			\lhead[\thepage]{\thesection~--~\rightmark}
			\if@withParts
			\if&\partTitle&
			\rhead[\textsc{Chapitre}\hskip1ex\thechapter~---~\chapterTitle]{\thepage}
			\else
			\rhead[\textsc{Partie}\hskip1ex\thepart~---~\partTitle\relax]{\thepage}
			\fi
			\else
			\rhead[\textsc{Chapitre}\hskip1ex\thechapter~---~\chapterTitle]{\thepage}
			\fi
			\fi\fi\fi
			\global\@topnum\z@
			\@afterindentfalse
			\secdef\@chapter\@schapter
		}
		
		% \Chapter{} : ne numérote par le chapitre mais le fait apparaÃ®tre dans la toc.
		\newif\if@chapterStar
		\newcommand{\Chapter}[1]{\newpage\gdef\chapterTitle{#1}%
			\@chapterStartrue\chapter*{#1}%
			\@chapterStarfalse\addcontentsline{toc}{chapter}{#1}\adjustmtc}
		
		\def\@chapter[#1]#2{%
			\gdef\chapterTitle{#1}
			\ifnum \c@secnumdepth >\m@ne
			\refstepcounter{chapter}%
			\typeout{\@chapapp\space\thechapter.}%
			\thispagestyle{plain}%
			\if@inAnnexe
			\addcontentsline{toc}{chapter}%
			{\protect\numberline{\thechapter}% 
				\chapterTitle}%
			\else
			\if@mainmatter
			\addcontentsline{toc}{chapter}%
			{\protect\numberline{\thechapter}%
				\chapterTitle}%
			\else
			\addcontentsline{toc}{chapter}{%
				\chapterTitle}
			\fi\fi
			\else
			\addcontentsline{toc}{chapter}{#1}%
			\fi
			\chaptermark{%
				\chapterTitle}%
			\addtocontents{lof}{\protect\addvspace{10\p@}}%
			\addtocontents{lot}{\protect\addvspace{10\p@}}%
			\if@twocolumn
			\@topnewpage[\@makechapterhead{#2}]%
			\else
			\@makechapterhead{#2}%
			\@afterheading
			\fi}
		\def\@makechapterhead#1{\thispagestyle{plain}%
			%  \vspace*{20\p@}%
			{\parindent \z@ \raggedright \normalfont
				\ifnum \c@secnumdepth >\m@ne
				\if@mainmatter
				\chapitreN{\thechapter}{#1}
				\vskip 1cm
				\else
				\chapitre{#1}
				\vskip 1cm
				\fi
				\fi
			}}
			\def\@Makechapterhead#1{%
				\vspace*{50\p@}%
				{\parindent \z@ \raggedright \normalfont
					\ifnum \c@secnumdepth >\m@ne
					\par\nobreak
					\vskip 20\p@
					\fi
					\interlinepenalty\@M
					\Huge \bfseries #1\par\nobreak
					\vskip 40\p@
				}}
				\def\@schapter#1{\if@twocolumn
					\@topnewpage[\@makeschapterhead{#1}]%
					\else
					\@makeschapterhead{#1}%
					\@afterheading
					\fi}
				\def\@makeschapterhead#1{\thispagestyle{plain}%
					%  \vspace*{20\p@}%
					{\parindent \z@ \raggedright   \interlinepenalty\@M
						\chapitre{#1}
						\vskip 1cm}}
				
				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				% Redéfinition des sections								%
				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				
				\newcommand\section{\@startsection {section}{1}{\z@}%
					{-3.5ex \@plus -1ex \@minus -.2ex}%
					{2.3ex \@plus.2ex}%
					{\normalfont\Large\bfseries}}
				\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
					{-3.25ex\@plus -1ex \@minus -.2ex}%
					{1.5ex \@plus .2ex}%
					{\normalfont\large\bfseries}}
				\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
					{-3.25ex\@plus -1ex \@minus -.2ex}%
					{1.5ex \@plus .2ex}%
					{\normalfont\normalsize\bfseries}}
				\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
					{3.25ex \@plus1ex \@minus.2ex}%
					{-1em}%
					{\normalfont\normalsize\bfseries}}
				\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
					{3.25ex \@plus1ex \@minus .2ex}%
					{-1em}%
					{\normalfont\normalsize\bfseries}}
				\if@twocolumn
				\setlength\leftmargini  {2em}
				\else
				\setlength\leftmargini  {2.5em}
				\fi
				\leftmargin  \leftmargini
				\setlength\leftmarginii  {2.2em}
				\setlength\leftmarginiii {1.87em}
				\setlength\leftmarginiv  {1.7em}
				\if@twocolumn
				\setlength\leftmarginv  {.5em}
				\setlength\leftmarginvi {.5em}
				\else
				\setlength\leftmarginv  {1em}
				\setlength\leftmarginvi {1em}
				\fi
				\setlength  \labelsep  {.5em}
				\setlength  \labelwidth{\leftmargini}
				\addtolength\labelwidth{-\labelsep}
				\@beginparpenalty -\@lowpenalty
				\@endparpenalty   -\@lowpenalty
				\@itempenalty     -\@lowpenalty
				\renewcommand\theenumi{\@arabic\c@enumi}
				\renewcommand\theenumii{\@alph\c@enumii}
				\renewcommand\theenumiii{\@roman\c@enumiii}
				\renewcommand\theenumiv{\@Alph\c@enumiv}
				\newcommand\labelenumi{\theenumi.}
				\newcommand\labelenumii{(\theenumii)}
				\newcommand\labelenumiii{\theenumiii.}
				\newcommand\labelenumiv{\theenumiv.}
				\renewcommand\p@enumii{\theenumi}
				\renewcommand\p@enumiii{\theenumi(\theenumii)}
				\renewcommand\p@enumiv{\p@enumiii\theenumiii}
				%\renewcommand\labelitemi{\textbullet}
				%\renewcommand\labelitemii{\normalfont\bfseries \textendash}
				%\renewcommand\labelitemiii{\textasteriskcentered}
				%\renewcommand\labelitemiv{\textperiodcentered}
				\newenvironment{description}
				{\list{}{\labelwidth\z@ \itemindent-\leftmargin
						\let\makelabel\descriptionlabel}}
				{\endlist}
				\newcommand*\descriptionlabel[1]{\hspace\labelsep
					\normalfont\bfseries #1}
				\newenvironment{verse}
				{\let\\\@centercr
					\list{}{\itemsep      \z@
						\itemindent   -1.5em%
						\listparindent\itemindent
						\rightmargin  \leftmargin
						\advance\leftmargin 1.5em}%
					\item\relax}
				{\endlist}
				\newenvironment{quotation}
				{\list{}{\listparindent 1.5em%
						\itemindent    \listparindent
						\rightmargin   \leftmargin
						\parsep        \z@ \@plus\p@}%
					\item\relax}
				{\endlist}
				\newenvironment{quote}
				{\list{}{\rightmargin\leftmargin}%
					\item\relax}
				{\endlist}
				\if@compatibility
				\newenvironment{titlepage}
				{%
					\if@twocolumn
					\@restonecoltrue\onecolumn
					\else
					\@restonecolfalse\newpage
					\fi
					\thispagestyle{empty}%
					\setcounter{page}\z@
				}%
				{\if@restonecol\twocolumn \else \newpage \fi
				}
				\else
				\newenvironment{titlepage}
				{%
					\if@twocolumn
					\@restonecoltrue\onecolumn
					\else
					\@restonecolfalse\newpage
					\fi
					\thispagestyle{empty}%
					\setcounter{page}\@ne
				}%
				{\if@restonecol\twocolumn \else \newpage \fi
					\if@twoside\else
					\setcounter{page}\@ne
					\fi
				}
				\fi
				
				\newcommand\appendix{%
					\@inAnnexetrue
					\addcontentsline{toc}{part}{Annexes}%
					\Part*{\appendixname}
					\setcounter{chapter}{0}%
					\setcounter{section}{0}%
					\renewcommand\@chapapp{\appendixname}%
					\renewcommand\thechapter{\@Alph\c@chapter}
					\renewcommand\thesection{\@Alph\c@section}
					\renewcommand\thesubsection{\@Alph\c@section.\@arabic\c@subsection}}
				
				\setlength\arraycolsep{5\p@}
				\setlength\tabcolsep{6\p@}
				\setlength\arrayrulewidth{.4\p@}
				\setlength\doublerulesep{2\p@}
				\setlength\tabbingsep{\labelsep}
				\skip\@mpfootins = \skip\footins
				\setlength\fboxsep{3\p@}
				\setlength\fboxrule{.4\p@}
				\@addtoreset {equation}{chapter}
				\renewcommand\theequation
				{\ifnum \c@chapter>\z@ \thechapter.\else\thesection.\fi \@arabic\c@equation}
				\newcounter{figure}[chapter]
				\renewcommand \thefigure
				{\ifnum \c@chapter>\z@ \thechapter.\else\thesection.\fi \@arabic\c@figure}
				\def\fps@figure{tbp}
				\def\ftype@figure{1}
				\def\ext@figure{lof}
				\def\fnum@figure{\figurename~\thefigure}
				\newenvironment{figure}
				{\@float{figure}}
				{\end@float}
				\newenvironment{figure*}
				{\@dblfloat{figure}}
				{\end@dblfloat}
				\newcounter{table}[chapter]
				\renewcommand \thetable
				{\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
				\def\fps@table{tbp}
				\def\ftype@table{2}
				\def\ext@table{lot}
				\def\fnum@table{\tablename~\thetable}
				\newenvironment{table}
				{\@float{table}}
				{\end@float}
				\newenvironment{table*}
				{\@dblfloat{table}}
				{\end@dblfloat}
				\newlength\abovecaptionskip
				\newlength\belowcaptionskip
				\setlength\abovecaptionskip{10\p@}
				\setlength\belowcaptionskip{0\p@}
				\long\def\@makecaption#1#2{%
					\vskip\abovecaptionskip
					\sbox\@tempboxa{#1: #2}%
					\ifdim \wd\@tempboxa >\hsize
					#1: #2\par
					\else
					\global \@minipagefalse
					\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
					\fi
					\vskip\belowcaptionskip}
				\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
				\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
				\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
				\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
				\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
				\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
				\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
				\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
				\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
				\newcommand\@pnumwidth{1.55em}
				\newcommand\@tocrmarg{2.55em}
				\newcommand\@dotsep{4.5}
				\setcounter{tocdepth}{2}
				\newcommand\tableofcontents{%
					\if@twocolumn
					\@restonecoltrue\onecolumn
					\else
					\@restonecolfalse
					\fi
					\global\@intablestrue
					\clearpage
					\gdef\chapterTitle{\MakeUppercase{\contentsname}}
					\chapter*{\contentsname
						\@mkboth{%
							\MakeUppercase{\contentsname}}{%
							\MakeUppercase{\contentsname}}}%
					%    \addcontentsline{toc}{chapter}{\contentsname}
					\@starttoc{toc}\@intablesfalse%
					\if@restonecol\twocolumn\fi
				}
				\newcommand*\l@part[2]{%
					\ifnum \c@tocdepth >-2\relax
					\addpenalty{-\@highpenalty}%
					\addvspace{2.25em \@plus\p@}%
					\begingroup
					\setlength\@tempdima{3em}%
					\parindent \z@ \rightskip \@pnumwidth
					\parfillskip -\@pnumwidth
					{\protect\centering{\bf\large #1}\par}
					\nobreak
					\global\@nobreaktrue
					\everypar{\global\@nobreakfalse\everypar{}}%
					\endgroup
					\fi}
				\newcommand*\l@chapter[2]{%
					\ifnum \c@tocdepth >\m@ne
					\addpenalty{-\@highpenalty}%
					\vskip 1.0em \@plus\p@
					\setlength\@tempdima{1.5em}%
					\begingroup
					\parindent \z@ \rightskip \@pnumwidth
					\parfillskip -\@pnumwidth
					\leavevmode \bfseries
					\advance\leftskip\@tempdima
					\hskip -\leftskip
					\if@inAnnexe
					#1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
					\else
					#1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
					\fi
					\penalty\@highpenalty
					\endgroup
					\fi}
				\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
				\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
				\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
				\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
				\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
				\newcommand\listoffigures{%
					\if@twocolumn
					\@restonecoltrue\onecolumn
					\else
					\@restonecolfalse
					\fi
					\global\@intablestrue
					\clearpage
					\gdef\chapterTitle{\MakeUppercase{\listfigurename}}
					\chapter*{\listfigurename
						\@mkboth{\MakeUppercase{\listfigurename}}%
						{\MakeUppercase{\listfigurename}}}%
					\addcontentsline{toc}{chapter}{\listfigurename}
					\@starttoc{lof}
					\global\@intablesfalse%
					\vfill
					\vbox{\unvcopy\credit@boxG}%
					\if@restonecol\twocolumn\fi
				}
				\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
				\newcommand\listoftables{%
					\if@twocolumn
					\@restonecoltrue\onecolumn
					\else
					\@restonecolfalse
					\fi
					\global\@intablestrue
					\clearpage
					\gdef\chapterTitle{\MakeUppercase{\listtablename}}
					\chapter*{\listtablename
						\@mkboth{%
							\MakeUppercase\listtablename}{\MakeUppercase\listtablename}}%
					\addcontentsline{toc}{chapter}{\listtablename}
					\@starttoc{lot}%
					\global\@intablesfalse%
					\if@restonecol\twocolumn\fi
				}
				\let\l@table\l@figure
				\newdimen\bibindent
				\setlength\bibindent{1.5em}
				\def\bibdata#1{\gdef\@bibfiles{#1}}
				\def\@bibid{.}
				\def\@bibfiles{.}
				\newcommand{\BibId}[1]{%
					\if\@bibid.%
					\gdef\@bibid{#1}%
					\else%
					\gdef\@bibid{$Biblio from multiple Bib\TeX{} files \{\@bibfiles\}$}%
					\fi%
				}
				\AtBeginDocument{\renewenvironment{thebibliography}[1]
					{\newpage
						\global\@intablestrue
						\gdef\chapterTitle{\MakeUppercase\bibname}
						\chapter*{\bibname
							\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}}%
						\addcontentsline{toc}{chapter}{\bibname}
						\if\@bibid.\gdef\@bibid{$Biblio from Bib\TeX{} file(s) \{\@bibfiles\}$}\fi
						\Revision{\@bibid}
						\list{\@biblabel{\@arabic\c@enumiv}}%
						{\settowidth\labelwidth{\@biblabel{#1}}%
							\leftmargin\labelwidth
							\advance\leftmargin\labelsep
							\@openbib@code
							\usecounter{enumiv}%
							\let\p@enumiv\@empty
							\renewcommand\theenumiv{\@arabic\c@enumiv}}%
						\sloppy\@intablesfalse
						\clubpenalty4000
						\@clubpenalty \clubpenalty
						\widowpenalty4000%
						\sfcode`\.\@m}
					{\def\@noitemerr
						{\@latex@warning{Empty `thebibliography' environment}}%
						\endlist}}
				\newenvironment{thebibliography}[1]{bla}{}
				\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
				\let\@openbib@code\@empty
				
				\newenvironment{theindex}{%
					\cleardoublepage
					\if@twocolumn
					\@restonecolfalse
					\else
					\@restonecoltrue
					\fi
					\columnseprule \z@
					\columnsep 35\p@
					\pagestyle{fancy}
					\idxtitle@default{\defaultindexname}%
					\edef\@indexname{%
						\expandafter\the\@nameuse{idxtitle@\@indextype}%
					}%
					\lhead[\thepage]{\MakeUppercase\@indexname}
					\rhead[\MakeUppercase\@indexname]{\thepage}
					\lfoot[]{}
					\rfoot[]{}
					\cfoot[]{}
					\twocolumn[\@makeschapterhead{\@indexname}]%
					\addcontentsline{toc}{chapter}{\@indexname}
					\@mkboth{\MakeUppercase\@indexname}%
					{\MakeUppercase\@indexname}%
					\thispagestyle{plain}\parindent\z@
					\parskip\z@ \@plus .3\p@\relax
					\let\item\@idxitem
				}{
				\if@restonecol\onecolumn\else\clearpage\fi
			}
			\newcommand\defaultindexname{Index}
			\newcommand\@idxitem{\par\hangindent 40\p@}
			\newcommand\subitem{\@idxitem \hspace*{20\p@}}
			\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
			\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
			
			\newenvironment{theglossary}{%
				\cleardoublepage
				\pagestyle{fancy}
				\lhead[\thepage]{\MakeUppercase\glossaryname}
				\rhead[\MakeUppercase\glossaryname]{\thepage}
				\lfoot[]{}
				\rfoot[]{}
				\cfoot[]{}
				\@makeschapterhead{\glossaryname}%
				\addcontentsline{toc}{chapter}{\glossaryname}
				\@mkboth{\MakeUppercase\glossaryname}%
				{\MakeUppercase\glossaryname}%
				\thispagestyle{plain}\parindent\z@
				\parskip\z@ \@plus .3\p@\relax
				%  \let\item\@idxitem
				\begin{description}
				}{%
			\end{description}
		}
		\def\printglossary{\@input@{\jobname.gls}}
		\AtBeginDocument{
			\let\orig@glossary\glossary
			\newcommand{\nop}[1]{}
			\renewcommand\glossary[3][*]{%
				\orig@glossary{\expandafter\if*#1#2\else#1\fi @[#2~:]#3}%
			}
		}
		\renewcommand\footnoterule{%
			\kern-3\p@
			\hrule\@width.4\columnwidth
			\kern2.6\p@}
		\@addtoreset{footnote}{chapter}
		\newcommand\@makefntext[1]{%
			\parindent 1em%
			\noindent
			\hb@xt@1.8em{\hss\@makefnmark}#1}
		\renewcommand\today{}
		\edef\today{\ifcase\month\or
			January\or February\or March\or April\or May\or June\or
			July\or August\or September\or October\or November\or December\fi
			\space\number\day, \number\year}
		\setlength\columnsep{10\p@}
		\setlength\columnseprule{0\p@}
		\pagestyle{plain}
		\pagenumbering{arabic}
		\if@twoside
		\else
		\raggedbottom
		\fi
		\if@twocolumn
		\twocolumn
		\sloppy
		\flushbottom
		\else
		\onecolumn
		\fi
		
		%--------------------------------------
		
		%% Macros prédéfinies dans le style french de Bernard Gaulle
		\newcommand{\fsc}[1]{\bsc{#1}}
		%% Lettrine
		\font\lettrinefont=yinit at 8pt
		\newdimen\approche \approche=3pt
		\def\lettrine#1{%
			\lettrineaux#1\end}
		\def\lettrineaux#1#2\end{\par\noindent
			\setbox0\hbox{\lettrinefont #1}%
			\setbox0\hbox{\lower1.25\baselineskip \vbox{\box0}}%
			\dimen0=\wd0 \advance\dimen0 by\approche
			\hangafter-2 \hangindent=\dimen0 \kern-\dimen0
			\dp0=0pt \box0{\kern.2em \textsc{#2}}}
		
		\def\@firstname{\ClassError{these-ISSS}{Il manque le prénom de l'auteur}{Utilisez la macro \string\firstname}}
		\def\@middlename{.}
		\def\IFmiddlename{\if\@middlename.\else\@middlename\ \fi}
		\def\@lastname{\ClassError{these-ISSS}{Il manque le nom de l'auteur}{Utilisez la macro \string\lastname}}
		\def\firstname#1{\gdef\@firstname{#1}}
		\def\middlename#1{\gdef\@middlename{#1}}
		\def\lastname#1{\gdef\@lastname{\fsc{#1}}}
		\def\@laboratoire{Laboratoire d'Informatique, de Signaux et Systèmes de Sophia Antipolis (I3S)\\[.2cm]UMR7271 UCA CNRS}
		\def\laboratoire#1{\gdef\@laboratoire{#1}}
		
		% Environnement epigraphe pour mettre une épigraphe au début d'un chapitre.
		% Prend deux arguments et une option :
		% 1. le nom de l'auteur de la citation
		% 2. le titre de l'oeuvre d'oÃ¹ est extraite l'épigraphe.
		% opt. langue de la citation [english|french] (french par défaut)
		% Il est possible de modifier la taille des lignes en donnant une nouvelle
		% valeur a la variable \epigraphwidth.
		\newif\if@epigraphWithAuthor
		\newif\if@epigraphWithTitle
		\newsavebox{\epigraph@boxauthor}
		\newsavebox{\epigraph@boxtitle}
		\newlength{\epigraphwidth}
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
						\begin{it}}%
						{\end{it}
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
			
			\newlength{\topicswidth}
			\setlength{\topicswidth}{11cm}
			\newenvironment{topics}{%
				\def\SEP{~---~}%
				\par\vspace*{-1em}
				\begin{center}\begin{minipage}{\topicswidth}
						\itshape}{\end{minipage}\end{center} \par\vspace*{2em}}
			
			
			
			\newcommand{\acknowledgementname}{Remerciements}
			\newenvironment{remerciements}{%
				\if@openright\cleardoublepage\else\clearpage\fi
				\chapter*{\acknowledgementname}}{\vfill\thispagestyle{empty}}
			
			\newcounter{@front}
			\setcounter{@front}{0}
			\newcommand\frontmatter[1][0]{%
				\@intablestrue
				\setcounter{@front}{\value{page}}
				\addtocounter{@front}{-2}
				\pagestyle{fancy}
				\lhead[\thepage]{\rightmark}
				\rhead[\leftmark]{\thepage}
				\lfoot[]{}
				\rfoot[]{}
				\cfoot[]{}
				%  \@mainmatterfalse
				\if@beurkEnglish
				\tableofcontents
				\else
				\pagenumbering{roman}  
				\setcounter{page}{\value{@front}}
				\gdef\chapterTitle{\MakeUppercase{\sommairename}}
				\chapter*{\sommairename
					\@mkboth{%
						\MakeUppercase{\sommairename}}{%
						\MakeUppercase{\sommairename}}}%
				\bgroup
				\def\l@chapter##1##2{%
					\ifnum \c@tocdepth >\m@ne
					\addpenalty{-\@highpenalty}%
					\vskip 0.2em \@plus\p@
					\setlength\@tempdima{1.5em}%
					\begingroup
					\parindent \z@ \rightskip \@pnumwidth
					\parfillskip -\@pnumwidth
					\leavevmode \bfseries
					\advance\leftskip\@tempdima
					\hskip -\leftskip
					\if@inAnnexe
					##1\nobreak\dotfill ##2\par
					\else
					##1\nobreak\dotfill ##2\par
					\fi
					\penalty\@highpenalty
					\endgroup
					\fi}
				\def\l@part##1##2{%
					\ifnum \c@tocdepth >-2\relax
					\addpenalty{-\@highpenalty}%
					\addvspace{1em \@plus\p@}%
					\begingroup
					\setlength\@tempdima{3em}%
					\parindent \z@ \rightskip \@pnumwidth
					\parfillskip -\@pnumwidth
					{\large\bfseries ##2\hspace{1em}##1\hfill~\par}
					%   \nobreak
					\global\@nobreaktrue
					\everypar{\global\@nobreakfalse\everypar{}}%
					\endgroup
					\fi}
				\makeatletter
				\setcounter{secnumdepth}{0}
				\setcounter{tocdepth}{#1}
				\@input{\jobname.toc}
				\setcounter{secnumdepth}{2}
				\setcounter{tocdepth}{2}
				\egroup
				\fi
				\@mainmatterfalse
				\setcounter{@front}{1}
				\if@openright
				\cleardoublepage
				\else
				\clearpage
				\fi
			}
			
			\newcommand\mainmatter{%
				\addtocounter{@front}{\value{page}}
				\immediate\write\@auxout{%
					\string\newlabel{last@page@front}{{}{\roman{@front}}{}{}{}}}
				\setcounter{chapter}{0}
				\@intablesfalse
				\@mainmattertrue
				\if@openright
				\cleardoublepage
				\else
				\clearpage
				\fi
				\pagestyle{fancy}
				\lhead[\thepage]{\textsc{Chapitre}\hskip1ex\thechapter~---~\chapterTitle}
				\if@withParts
				\rhead[\textsc{Partie}\hskip1ex\thepart~---~\partTitle\relax]{\thepage}
				\else
				\rhead[\textsc{Chapitre}\hskip1ex\thechapter~---~\chapterTitle]{\thepage}
				\fi
				\lfoot[]{}
				\rfoot[]{}
				\cfoot[]{}
				%  \@mainmattertrue
				\pagenumbering{arabic}}
			
			\newcommand\fourthcover{%
				\cleardoublepage
				\thispagestyle{empty}\mbox{ }\clearpage
				\pagestyle{empty}
				\enlargethispage{4cm}
				
				\vspace*{-3.4cm}
				\begin{center}
					\begin{minipage}{15cm}
						\begin{center}
							{%
								\bfseries%
								\fontsize{16pt}{22pt}\selectfont\@titre%
								\par%
								\if@soustitre{\vspace{5mm}\fontsize{16pt}{18pt}\selectfont}%
							}
							\par\vspace{0.5cm}
							\Large\@firstname\ \IFmiddlename \@lastname\par\vspace{1cm}
						\end{center}
					\end{minipage}
					\begin{minipage}{\textwidth}
						\vspace{-0.5cm}
						\begin{center}
							\vfill
							\small
							\noindent\unvcopy\fourth@coverGlobB
							\ifx\@motscles\@empty\else
							\smallskip
							\begin{flushleft}
								\noindent\textbf{Mots-clés :} \@motscles
							\end{flushleft}
							\fi
							\vfill
							\noindent\unvcopy\fourth@coverGlobA
							\ifx\@keywords\@empty\else
							\smallskip
							\begin{flushleft}
								\noindent\textbf{Keywords:} \foreignlanguage{english}{\@keywords}
							\end{flushleft}
							\fi
							\vfill
							\begin{flushleft}
								\unvcopy\@classificationBoxGlobal
							\end{flushleft}
							\normalsize
						\end{center}
					\end{minipage}
				\end{center}
				\@mainmatterfalse}
			
			\newcommand{\backmatter}{%
				\clearpage
				\addtocontents{toc}{\par\addvspace{20\p@ }}%
				%    \protect\centering{\bf\large ~}\par}%
			}
			
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			% Jury																%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			\newbox{\@juryBox}
			\newsavebox{\@juryBoxA}
			\newcounter{nbRapporteurs}
			\newcounter{nbExaminateurs}
			\newcounter{nbInvites}
			\newif\if@juryPresent
			\@juryPresentfalse
			\newif\if@hdr
			\@hdrfalse
			\def\@inconnu{\hbox to 3cm{\hrulefill}}
			\def\@directeurThese{\@empty}
			\def\@codirecteurThese{\@empty}
			\def\@coencadrantThese{\@empty}
			\def\@coTutelle{\@empty}
			\def\@coTutelleLogo{\@empty}
			\def\@coFinanceursLogo{\@empty}
			\def\@president{\@empty}
			\gdef\@presidentAdr{\@empty}
			\gdef\@rappoteurs{}
			\gdef\@examinateurs{}
			\gdef\@invites{}
			\def\creerPresident #1/#2+{\gdef\@president{#1}\gdef\@presidentAdr{#2}}
			\newcommand{\rapporteursname}{Rapporteurs}
			\newcommand{\presidentname}{Président}
			\newcommand{\examinateursname}{Examinateurs}
			\newcommand{\invitesname}{Membres invités}
			\newcommand{\directeurname}{{\itshape Directeur de thèse}}
			\newcommand{\codirecteurname}{{\itshape Co-directeur de thèse}}
			\newcommand{\coencadrantname}{{\itshape Co-encadrant de thèse}}
			\newcommand{\directeur}[1]{\gdef\@directeurThese{#1}}
			\newcommand{\codirecteur}[1]{\gdef\@codirecteurThese{#1}}
			\newcommand{\coencadrant}[1]{\gdef\@coencadrantThese{#1}}
			\newcommand{\cotutelle}[1]{\gdef\@coTutelle{#1}}
			\newcommand{\cotutellelogo}[1]{\gdef\@coTutelleLogo{#1}}
			\newcommand{\cofinanceurslogo}[1]{\gdef\@coFinanceursLogo{#1}}
			\newcommand{\hdr}{\global\@hdrtrue}
			\newenvironment{jury}[1][+]{%
				\if#1+\else \creerPresident #1+\fi%
				\global\@juryPresenttrue%
				\def\rapporteur##1##2##3{\stepcounter{nbRapporteurs}
					##1, ##2, ##3 \\
					\g@addto@macro\@rappoteurs{##1, ##2, ##3 \\}
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
						\if\@president\@empty\else\@president, \@presidentAdr\\\fi
						}{\end{tabular}\end{lrbox}%
				\global\setbox\@juryBox=\vbox{\copy\@juryBoxA}}
			\newcommand{\juryDefaut}{%
				\def\directeur##1{\gdef\@directeurThese{##1}}
				\def\codirecteur##1{\gdef\@codirecteurThese{##1}}
				\def\president##1{\gdef\@president{##1}}
				\def\rapporteur##1##2##3{\ifnum\value{nbRapporteurs}>0 \else%
					\hbox to 2.8cm{\rapporteursname\hss:}\fi \stepcounter{nbRapporteurs}
					& ##1, ##2 $\bullet$ ##3 \\}
				\def\examinateur##1##2##3{\ifnum\value{nbExaminateurs}>0 \else%
					\hbox to 2.8cm{\examinateursname\hss:}\fi \stepcounter{nbExaminateurs}
					& ##1, ##2 $\bullet$ ##3 \\}
				\def\invite##1##2##3{\ifnum\value{nbInvites}>0 \else%
					\hbox to 2.8cm{\invitesname\hss:}\fi \stepcounter{nbInvites}
					& ##1, ##2 $\bullet$ ##3 \\}
				\begin{lrbox}{\@juryBoxA}
					\begin{tabular}{lll}
						\hbox to 2.8cm{\presidentname\hss:} & \@president &\@inconnu\\
						\if\@directeurThese\@inconnu \directeur{\@inconnu}\fi
						\if\@codirecteurThese\@inconnu \codirecteur{\@inconnu}\fi
						\rapporteur{\@inconnu}{\@inconnu}{\@inconnu}
						\rapporteur{\@inconnu}{\@inconnu}{\@inconnu}
						\examinateur{\@inconnu}{\@inconnu}{\@inconnu}
						\examinateur{\@inconnu}{\@inconnu}{\@inconnu}
						\examinateur{\@inconnu}{\@inconnu}{\@inconnu}
						\invite{\@inconnu}{\@inconnu}{\@inconnu}
					\end{tabular}\end{lrbox}%
					\global\setbox\@juryBox=\vbox{\copy\@juryBoxA}}
				
				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				% Environnement de dédicace								%
				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				\newenvironment{dedicace}{\if@openright\cleardoublepage\else\clearpage\fi%
					\thispagestyle{empty}\vspace*{1cm}\begin{flushright}\it}{\end{flushright}
					\vfill}
				
				
				
				\def\enddocument{%
					\@enddocumenthook
					\@checkend{document}%
					\clearpage
					\begingroup
					\if@filesw
					\immediate\closeout\@mainaux
					\immediate\closeout\@lblout
					\let\@setckpt\@gobbletwo
					\let\@newl@bel\@testdef
					\@tempswafalse
					\makeatletter \input\jobname.aux
					\fi
					\@dofilelist
					\ifdim \font@submax >\fontsubfuzz\relax
					\@font@warning{Size substitutions with differences\MessageBreak
						up to \font@submax\space have occurred.\@gobbletwo}%
					\fi
					\@defaultsubs
					\@refundefined
					\if@filesw
					\ifx \@multiplelabels \relax
					\if@tempswa
					\@latex@warning@no@line{Label(s) may have changed.
						Rerun to get cross-references right}%
					\fi
					\else
					\@multiplelabels
					\fi
					\fi
					\endgroup
					\deadcycles\z@\@@end}
				
				
				% Page de résumé et de mots-clés
				\newenvironment{ResumeMotsCles}{
					\cleardoublepage
					\thispagestyle{empty}
					\enlargethispage{2cm}
					\vspace*{-2.5cm}
				}{
				\begin{center}\Large\bf \@titre\end{center}
				
				\noindent\unvcopy\fourth@coverGlobB
				\ifx\@motscles\@empty\else
				\smallskip
				\noindent\textbf{Mots-clés :} \@motscles
				\fi
				\vspace{1cm}
				\begin{center}\Large\bf \@title\end{center}
				\smallskip
				\noindent\unvcopy\fourth@coverGlobA
				\ifx\@keywords\@empty\else
				\smallskip
				\noindent\textbf{Keywords:} \foreignlanguage{english}{\@keywords}
				\fi
				\vspace{1cm}
				\unvcopy\@classificationBoxGlobal
				\newpage}
			
			% Environnement ``abstract''. Redéfinir la largeur avec \abstractwidth.
			\newsavebox{\fourth@coverA} % Sauvegarde du résumé pour la 4e de couverture.
			\newsavebox{\fourth@coverB}
			\newlength{\abstractwidth}
			\setlength{\abstractwidth}{\textwidth}
			\newlength{\abs@width}
			\newenvironment{abstract}{
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
			
			\def\addouterlabels#1{\immediate\write\@mainaux{\string\@input{#1.lbl}}}
			
			
			\def\caption{\refstepcounter\@captype \@dblarg{\@caption\@captype}}
			\long\def\@caption#1[#2]#3{%
				\begingroup\normalfont\par
				\addcontentsline{\csname ext@#1\endcsname}{#1}%
				{\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
				\begingroup
				\@parboxrestore
				\if@minipage
				\@setminipage
				\fi
				\normalsize
				\@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
				\endgroup\endgroup}
			
			
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			%Environement customisés											%
			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			\newenvironment{block-line}{
				\begin{center}
					\begin{minipage}{0.9\textwidth} \rule{\linewidth}{.5pt}
					}{
					\rule{\linewidth}{.5pt}
				\end{minipage}
			\end{center}
		}
		\definecolor{BLOCKBG}{RGB}{220,220,220}
		\newbox\blockbox
		\newenvironment{block}[1]{
			\setbox\blockbox=\hbox to 0.95\textwidth\bgroup  \begin{minipage}{0.95\textwidth} {\normalsize\bf #1}
				\par
			}{
		\end{minipage}\egroup
		\begin{center}
			\begin{tikzpicture}
			\draw (0, 0) node[fill=BLOCKBG] (box) {\box\blockbox};
			\end{tikzpicture}
		\end{center}
	}
	\newenvironment{itemize:bullet}{
		%$\CIRCLE$
		%$\blacktriangleright$
		\begin{enumerate}[$\bullet$]
		}{
	\end{enumerate}
}
\newenvironment{itembullet}{\begin{itemize:bullet}}{\end{itemize:bullet}}
\newenvironment{itemize:lex}{
	\begin{enumerate}[(a)]
	}{
\end{enumerate}
}
\newenvironment{itemlex}{\begin{itemize:lex}}{\end{itemize:lex}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Note importante (on peut choisir le ``titre''. Par défaut, c'est ``Note :'')
\newenvironment{Note}[1][{Note : }]{\par\parindent0pt %
	\medskip\textbf{#1}\begin{sf}}{\end{sf}\par\medskip}

% Environnement VerbProgram
\renewcommand{\theFancyVerbLine}{%
	{\red\tiny%
		\arabic{FancyVerbLine}}}
\newlength{\programskip}
\setlength{\programskip}{2cm}
\newlength{\numprogskip}
\setlength{\numprogskip}{2pt}
\DefineVerbatimEnvironment{VerbProgram}%
{Verbatim}{xleftmargin=4mm,resetmargins=true,numbers=left,%
	numbersep=\numprogskip,samepage=true,formatcom=\footnotesize,%
	commandchars=\\\@\~}


% La macro ToDo permet de marquer les endroits incomplets ou \`a revoir.
% Elle admet comme argument optionnel un texte \`a écrire au lieu de "À revoir".
\newcommand{\ToDo}[1][À revoir\ldots]{%
	\begin{center}%
		\textcolor[rgb]{1,0,0}{
			\hrule\smallskip\hrule%
			\smallskip#1\smallskip%
			\hrule\smallskip\hrule%
		}
	\end{center}%
}

% Footnote numérotées par des symboles ou des chiffres
\if@footnoteArabic
\def\thefootnote{\ensuremath{\arabic{footnote}}}
\else
\def\thefootnote{\ensuremath{\fnsymbol{footnote}}}
\fi

\def\@discipline{\textsc{Informatique}}
\newcommand{\discipline}[1]{\gdef\@discipline{#1}}

% Environnement Jakadi
\newsavebox{\jakadi@box}
\newenvironment{Jakadi}[1]{\vspace{.3cm}\sbox{\jakadi@box}{#1}%
	\begin{savenotes}\begin{minipage}{\hsize}
			\begin{quote}\itshape
				\og~}%
			{~\fg \hspace*{1pt} \begin{flushright}---~\usebox{\jakadi@box}%
				\end{flushright}\end{quote}\end{minipage}\end{savenotes}\vspace{.3cm}}
			
			
			% Paramètres pour \InPetto{}
			\reversemarginpar
			\setlength{\marginparwidth}{2.3cm}
			\setlength{\marginparsep}{1mm}
			
			% Mise en forme d'un nom propre
			%\newcommand{\Nom}[1]{\index{#1@\textsc{#1}}{\textsc{#1}}}
			\newcommand{\Nom}[1]{{\textsc{#1}}}			
			
			\AtBeginDocument{
				% Correction pb interaction babel et input/latin1
				\def\@Fpt{{\ifcase\value{part}\or Première\or Deuxième\or
						Troisième\or Quatrième\or Cinquième\or Sixième\or
						Septième\or Huitième\or Neuvième\or Dixième\or Onzième\or
						Douzième\or Treizième\or Quatorzième\or Quinzième\or
						Seizième\or Dix-septième\or Dix-huitième\or Dix-neuvième\or
						Vingtième\fi}\space\def\thepart{}}%
				
				\if@revision % On veut faire afficher les infos de révision
				\newcommand{\Revision}[1]{\footnotetext{{\blue\sffamily \(#1\)}}}
				\else
				\newcommand{\Revision}[1]{\relax}
				\fi
			}
			
			\def\lastpage@putlabel{\addtocounter{page}{-1}%
				\immediate\write\@auxout{\string
					\newlabel{last@page}{{}{\thepage}}{}{}{}}%
				\addtocounter{page}{1}}
			
			\AtEndDocument{
				\fourthcover
				%  \clearpage
				\lastpage@putlabel
			}
			
			% Classification ACM
			\newcommand{\categoryname}{Catégories et descripteurs de sujets :}
			\newcommand{\termsname}{Termes généraux :}
			
			\let\@keywords=\@empty
			\let\@motscles=\@empty
			\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
			\newcommand{\motscles}[1]{\gdef\@motscles{#1}}
			
			% Catégories ACM
			\newsavebox{\@classificationBox}
			\newbox{\@classificationBoxGlobal}
			\newenvironment{classification}{%
				\begin{lrbox}{\@classificationBox}%
					\begin{minipage}{\textwidth}}{%
						\vspace*{-5pt}
						\begin{center}
							\textbf{Classification \textsc{acm}}
						\end{center}
						\vspace*{-10pt}
						% La partie ci-dessous est reprise de esub2acm.
						\ifx\@categories\@empty \else
						\vskip 4\p@\relax 
						\def\and{\unskip{\rm;} }%
						\categoryname\ \@categories\par
						\fi
						\ifx\@terms\@empty\else
						\vskip 4\p@
						\termsname\ \ignorespaces
						\@terms
						\par
						\fi
					\end{minipage}\end{lrbox}
					\global\setbox\@classificationBoxGlobal=\vbox{\copy\@classificationBox}}
				% Ci-dessous: code repris de esub2acm.cls
				\def\terms{\gdef\@terms}
				\let\@terms\@empty
				\def\category#1#2#3{%
					\@ifnextchar [{\@category{#1}{#2}{#3}}{\@category{#1}{#2}{#3}[]}%
				}
				\def\@category#1#2#3[#4]{%
					\edef\@tempa{\ifx \@categories\@empty \else ; \fi}%
					\begingroup
					\def\protect{\noexpand\protect\noexpand}%
					\let\and\relax
					\xdef\@categories{%
						\@categories
						\@tempa
						#1 [{\bf #2}]%
						\if!#4!%
						\if!#3!\else : #3\fi
						\else
						:\space
						\if!#3!\else #3\kern\z@---\hskip\z@\fi
						{\it #4}%
						\fi
					}%
					\endgroup
				}
				\let\@categories\@empty
				% << Classification ACM
				
				\def\@titre{\ClassError{these-ISSS}{Il manque le titre en français}{
						Utilisez la macro \noexpand\titre}}
				\def\@title{\ClassError{these-ISSS}{Il manque le titre en anglais}{
						Utilisez la macro \noexpand\title}}
				\def\@soustitre{.}
				\def\@subtitle{.}
				\def\titre#1{\gdef\@titre{#1}}
				\def\soustitre#1{\gdef\@soustitre{#1}}
				\def\subtitle#1{\gdef\@subtitle{#1}}
				\def\if@soustitre#1{\if\@soustitre.\else{#1\@soustitre}\fi}
				\def\if@subtitle#1{\if\@subtitle.\else{#1\@subtitle}\fi}
				
				% Environnement ``contenu''
				\newenvironment{contenu}{%
					\par\vspace{2cm}\begin{center}\begin{EnGrise}%
							\begin{minipage}{12cm}\Large\bfseries}{%
							\end{minipage}\end{EnGrise}\end{center}}
							
							%% Crédit photo
							\newsavebox{\credit@box}
							\newbox{\credit@boxG}
							\newcommand{\creditname}{Crédit photo}
							\newenvironment{creditPhoto}{%
								\begin{lrbox}{\credit@box}
									\begin{minipage}{\textwidth}
										\begin{center}
											\textbf{\creditname}\par
										\end{center}
									}{%
								\end{minipage}
							\end{lrbox}
							\global\setbox\credit@boxG=\vbox{\copy\credit@box}}
						
						%% Citation inversée de la bibliographie basée sur le package backref
						\ifb@ckref
						\typeout{On charge backref avec l'option \b@ckrefstyle}
						\RequirePackage[verbose, \b@ckrefstyle]{backref}
						\fi
						
						%% Les macros suivantes n'ont de sens que si b@ckref est \`a vrai!!!
						%% permet de manger ce qu'il y a entre une virgule et un $
						\def\m@nge@gule#1{
							\@ifnextchar${\expandafter\if$}%$ Pour XEmacs
							{\m@nge@gule}%
						}
						
						%% permet de manger l'argument en relanÃ§ant une itération.
						\def\m@ngec@r#1{\if@virgule}
						
						%% équivalent \`a \iftrue s'il y a une virgule avant le prochain $, \iffalse sinon.
						\def\if@virgule{%
							\@ifnextchar,{\m@nge@gule}{%
								\@ifnextchar${\expandafter\if10}
								{\m@ngec@r}%$ Pour XEmacs
							}%
						}
						
						%% Texte explicite au singulier ou au pluriel selon les cas.
						\def\b@ckref#1{%
							\expandafter\expandafter\expandafter\if@virgule#1$%$ Pour XEmacs
							Cette référence a été citée \b@ckrefnamepluriel
							\else
							Cette référence a été citée \b@ckrefnamesingulier
							\fi%
							#1%
						}
						
						%% Redéfinition de backref.
						%% Citation explicite (\cite) ou implicite (\nocite).
						%% Texte explicite au singulier ou au pluriel selon les cas.
						\def\backref#1{
							\expandafter\ifx#1\relax
							Cette référence n'a pas été citée explicitement%
							\else
							\b@ckref{#1}%
							\fi
						}
						
						%% Redéfinition de BR@@lbibitem et de BR@@bibitem.
						%% Ajout du point final.
						\def\BR@@lbibitem[#1]#2#3\par{%
							\BRorg@bibitem[#1]{#2}#3
							\newblock
							\begingroup
							\csname @safe@activestrue\endcsname
							\backref{\csname br@#2\endcsname}.%
							\endgroup
							\par
						}%
						\def\BR@@bibitem#1#2\par{%
							\BRorg@bibitem{#1}#2
							\newblock
							\begingroup
							\csname @safe@activestrue\endcsname
							\backref{\csname br@#1\endcsname}.%
							\endgroup
							\par
						}
						
						\endinput
						%% Local Variables:
						%% mode:latex
						%% End:
						