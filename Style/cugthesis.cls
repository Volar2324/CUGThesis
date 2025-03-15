% == 模板来自 中国科学院大学 Latex 模板 ==
% reference: https://github.com/mohuangrui/ucasthesis/
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\newcommand*\@iflatexlater{\@ifl@t@r\fmtversion}%
\@iflatexlater{2017/01/01}{}{%
    \ClassError{cugthesis}{TeXLive/MikTex >= 2017 is required ...}{}%
}
\ProvidesClass{cugthesis}[2014/10/01 v1.0 LaTeX document class]%

% ===========================  Layout  =======================================
\DeclareOption{oneside}{%
    \PassOptionsToClass{oneside}{ctexbook}%
}
\DeclareOption{twoside}{%
    \PassOptionsToClass{twoside}{ctexbook}%
}
\newif\ifcug@print \cug@printfalse
\DeclareOption{print}{%
    \PassOptionsToClass{twoside}{ctexbook}%
    \cug@printtrue%
}
%-
%-> Language
%-
\newif\ifcug@plain \cug@plainfalse
\DeclareOption{scheme=plain}{% enable plain writing style
    \PassOptionsToClass{scheme=plain}{ctexbook}%
    \cug@plaintrue%
}
%-
%-> Draft version info
%-
\newif\ifcug@versioninfo \cug@versioninfofalse
\DeclareOption{draftversion}{%
    \cug@versioninfotrue%
}

%-
%-> Handle non-implemented options
%-
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexbook}%
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%

%%%%%%  ==========================  Load Class Information =================================
% default as -4
\LoadClass[UTF8,a4paper,zihao=-4]{ctexbook}%
\@ifclasslater{ctexbook}{2017/01/01}{}{%
    \ClassError{cugthesis}{ctex >= 2017/01/01 is required ...}{}%
}
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\cugifstreq}{\expandafter\ifstrequal\expandafter}% expansion control
\newcommand{\cugifstrbk}{\expandafter\ifblank\expandafter}% expansion control
\RequirePackage{expl3}% LaTeX3 programming environment
\ExplSyntaxOn
% \newcommand{\cuglntotab}[2][1pt]{% convert lines into table lines
%     \seq_set_split:NnV \l_tmpa_seq {\\} {#2}
%     \clist_set_from_seq:NN \l_tmpa_clist \l_tmpa_seq
%     \clist_clear:N \l_tmpb_clist
%     \clist_map_inline:Nn \l_tmpa_clist
%       {%
%         \clist_put_right:Nn \l_tmpb_clist
%           { \ulenhance[#1]{\ulextend{##1}} }
%       }
%     %\clist_show:N\l_tmpb_clist% show the content of comma list
%     \clist_use:Nn \l_tmpb_clist { \\ & }
% }
\newcommand{\cuglntotab}[2][1pt]{% convert lines into table lines
    \seq_set_split:NnV \l_tmpa_seq {\\} {#2}
    \clist_set_from_seq:NN \l_tmpa_clist \l_tmpa_seq
    \clist_clear:N \l_tmpb_clist
    \clist_map_inline:Nn \l_tmpa_clist{
        \clist_put_right:Nn \l_tmpb_clist {##1}
    }
    \clist_use:Nn \l_tmpb_clist { \\ & }
}
\ExplSyntaxOff
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{Style/cugthesis.cfg}{}{}
    \makeatother
}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- use \topmargin insead of \voffset to shift the complete text vertically
%- use \<odd|even>sidemargin insead of \hoffset to shift text horizontally
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin (1.0in = 25.4mm)
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{150mm}% set required text width first  % 3 + 3 + 15 = 21
\setlength{\hoffset}{0mm}% set horizontal offset
\ifcug@print% if print layout enabled
    \setlength{\oddsidemargin}{9.2mm}% binding side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{4.6mm}% left side margin
    \setlength{\evensidemargin}{4.6mm}% ensure uniform left side width for EThesis
\fi
\setlength{\marginparwidth}{35pt}% width of margin notes
\setlength{\marginparsep}{10pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{237mm}% set required text height first
\setlength{\voffset}{0mm}% set vertical offset
\setlength{\topmargin}{-25.4mm}% vertical margin above header
\setlength{\headheight}{25mm}% header height, 页眉 2.5cm(25mm)
\setlength{\headsep}{5mm}% vertical margin between header and body text
\setlength{\footskip}{15mm}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0ex}
% \setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\linespread{1.388}% line space setting; 20pt, scale = 20 / 12 / 1.2 = 1.388...
% \linespread{\customdoubleline}% line space setting
\newcommand{\customsingleline}{1.083} % 单倍行距, 1.3 / 1.2 = 1.083
\newcommand{\customonequarterline}{1.354} % 单倍行距, 1.3 / 1.2 = 1.083
\newcommand{\customonehalfline}{1.625} % 单倍行距, 1.3 / 1.2 = 1.083
\newcommand{\customdoubleline}{2.166} % 单倍行距, 1.3 / 1.2 = 1.083
% \def\customdoubleline{2.166} % 单倍行距, 1.3 / 1.2 = 1.083
% \def\customdoubleline{2.166} % 单倍行距, 1.3 / 1.2 = 1.083
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
%% remove header, and set as default of \cleardoublepage
\renewcommand{\cleardoublepage}[1][empty]{%
    \clearpage\if@twoside\ifodd\c@page\else%
            \thispagestyle{#1}%
            \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- underline
\ifxetex%
    \RequirePackage{ulem}%
\else%
    \RequirePackage{ulem}%
\fi
\newcommand{\ulunify}[1]{\uline{#1}}% unified name
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \setlength{\ULdepth}{0.5em}% set depth
    \expandafter\ulunify\expandafter{#2}% linebreak fix
}
\newcommand{\ulhshift}{-4em}% horizontal shift on underline
\newcommand{\ulextend}[2][350pt]{% extend underline length
    \hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}}
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> Chinese item commands
%-
\RequirePackage{zhnumber}
% \RequirePackage{xeCJK}
\newcommand{\cugthesisdate}[2]{%
    \zhdigits{#1}年\zhdigits{#2}月
}

\def\cug@value@ch@confidential{}
\newcommand{\confidential}[1]{\def\cug@value@ch@confidential{#1}}
\def\cug@value@ch@schoolname{}
\newcommand{\schoolname}[1]{\def\cug@value@ch@schoolname{#1}}
\def\cug@value@ch@schoolcode{}
\newcommand{\schoolcode}[1]{\def\cug@value@ch@schoolcode{#1}}
\def\cug@value@ch@studentID{}
\newcommand{\studentID}[1]{\def\cug@value@ch@studentID{#1}}
\def\cug@value@ch@orderid{}
\newcommand{\orderid}[1]{\def\cug@value@ch@orderid{#1}}
\def\cug@value@ch@classid{}
\newcommand{\classid}[1]{\def\cug@value@ch@classid{#1}}
\def\cug@value@ch@udc{}
\newcommand{\udc}[1]{\def\cug@value@ch@udc{#1}}
\def\cug@value@ch@schoollogo{}
\newcommand{\schoollogo}[2][]{\def\cug@value@ch@schoollogo{\cugifstrbk{#1}{\zihao{-2}\bfseries\sffamily #2}{\includegraphics[#1]{#2}}}}
\def\cug@value@ch@title{}
\def\cug@value@ch@titlemark{}
\renewcommand{\title}[2][\cug@value@ch@title]{%
    \def\cug@value@ch@title{#2}
    %\def\cug@value@ch@titlemark{\MakeUppercase{#1}}}
    \def\cug@value@ch@titlemark{#1}}
\def\cug@value@ch@author{}
\renewcommand{\author}[1]{\def\cug@value@ch@author{#1}}
\def\cug@value@ch@advisor{}
\newcommand{\advisor}[1]{\long\def\cug@value@ch@advisor{#1}}
\def\cug@value@ch@advisors{}
\newcommand{\advisors}[1]{\long\def\cug@value@ch@advisors{#1}}
\def\cug@value@ch@degree{}
\newcommand{\degree}[1]{\def\cug@value@ch@degree{#1}}
\def\cug@value@ch@degreetype{}
\newcommand{\degreetype}[1]{\def\cug@value@ch@degreetype{#1}}
\def\cug@value@ch@subject{}
\newcommand{\subject}[1]{\def\cug@value@ch@subject{#1}}
\def\cug@value@ch@major{}
\newcommand{\major}[1]{\def\cug@value@ch@major{#1}}
\def\cug@value@ch@institute{}
\newcommand{\institute}[1]{\long\def\cug@value@ch@institute{#1}}
\def\cug@value@ch@school{}
\newcommand{\school}[1]{\def\cug@value@ch@school{#1}}
\def\cug@value@ch@orginization{}
\newcommand{\orginization}[1]{\def\cug@value@ch@orginization{#1}}
\def\cug@value@ch@completedate{}
\newcommand{\completedate}[1]{\def\cug@value@ch@completedate{#1}}
\def\cug@value@ch@submitdate{}
\newcommand{\submitdate}[1]{\def\cug@value@ch@submitdate{#1}}
\def\cug@value@ch@studydatefrom{}
\newcommand{\studydatefrom}[1]{\def\cug@value@ch@studydatefrom{#1}}
\def\cug@value@ch@studydateto{}
\newcommand{\studydateto}[1]{\def\cug@value@ch@studydateto{#1}}
\def\cug@value@ch@date{}
\renewcommand{\date}[2]{\def\cug@value@ch@date{\cugthesisdate{#1}{#2}}}

%%% add name of school
\def\cug@label@ch@schoolname{}
\def\cug@label@ch@schoolnameWH{}
\newcommand{\cugname}[2]{\def\cug@label@ch@schoolname{#1} \def\cug@label@ch@shoolnameWH{#2}}

%-
%-> English item commands
%-
\def\cug@value@en@title{}
\def\cug@value@en@titlemark{}
\newcommand{\TITLE}[2][\cug@value@en@title]{%
    \def\cug@value@en@title{#2}
    %\def\cug@value@en@titlemark{\MakeUppercase{#1}}}
    \def\cug@value@en@titlemark{#1}}
\def\cug@value@en@author{}
\newcommand{\AUTHOR}[1]{\def\cug@value@en@author{#1}}
\def\cug@value@en@advisor{}
\newcommand{\ADVISOR}[1]{\def\cug@value@en@advisor{#1}}
\def\cug@value@en@degree{}
\newcommand{\DEGREE}[1]{\edef\cug@value@en@degree{\zap@space#1 \@empty}}% expand and remove space
\def\cug@value@en@degreetype{}
\newcommand{\DEGREETYPE}[1]{\def\cug@value@en@degreetype{#1}}
\def\cug@value@en@thesistype{}
\newcommand{\THESISTYPE}[1]{\def\cug@value@en@thesistype{#1}}
\def\cug@value@en@major{}
\newcommand{\MAJOR}[1]{\def\cug@value@en@major{#1}}
\def\cug@value@en@institute{}
\newcommand{\INSTITUTE}[1]{\def\cug@value@en@institute{#1}}
\def\cug@value@en@school{}
\newcommand{\SCHOOL}[1]{\def\cug@value@en@school{#1}}
\def\cug@label@en@schoolname{}
\newcommand{\CUGNAME}[1]{\def\cug@label@en@schoolname{#1}}
\def\cug@label@en@schoolloc{}
\newcommand{\CUGLOC}[1]{\def\cug@label@en@schoolloc{#1}}
\def\cug@label@en@headersep{}
\newcommand{\HEADERSEP}[1]{\def\cug@label@en@headersep{#1}}

\def\cug@value@en@date{}
\newcommand{\DATE}[1]{\def\cug@value@en@date{#1}}
\def\cug@fixtable@length{5em}
%-
%-> Detect and adjust items
%-
\AtEndPreamble{%
    \cugifstreq{\cug@value@en@degree}{Bachelor}{%
        \def\cug@label@ch@thesis{\cug@label@ch@thesis@bac}%
        \def\cug@label@ch@author{\cug@label@ch@author@bac}%
        \def\cug@label@ch@major{\cug@label@ch@major@bac}%
        \def\cug@label@ch@institute{\cug@label@ch@institute@bac}%
        \def\cug@value@en@thesistype{\cug@value@en@thesistype@bac}%
        \def\maketitle{\maketitle@xpdc}
        \def\MAKETITLE{\MAKETITLE@xpdc}
    }{%
        \cugifstreq{\cug@value@en@degree}{Master}{%
            \def\cug@label@ch@thesis{\cug@label@ch@thesis@mas}%
            \def\cug@label@ch@author{\cug@label@ch@author@mas}%
            \def\cug@label@en@author{\cug@label@en@author@mas}%
            \def\cug@label@ch@major{\cug@label@ch@major@mas}%
            \def\cug@label@ch@institute{\cug@label@ch@institute@mas}%
            \def\cug@value@en@thesistype{\cug@value@en@thesistype@mas}%
            \def\maketitle{\maketitle@xpdc}
            \def\MAKETITLE{\MAKETITLE@xpdc}
        }{%
            \cugifstreq{\cug@value@en@degree}{MasterFull}{%
                \def\cug@label@ch@thesis{\cug@label@ch@thesis@masful}%
                \def\cug@label@ch@author{\cug@label@ch@author@masful}%
                \def\cug@label@en@author{\cug@label@en@author@masful}%
                \def\cug@label@ch@major{\cug@label@ch@major@masful}%
                \def\cug@label@ch@institute{\cug@label@ch@institute@masful}%
                \def\cug@value@en@thesistype{\cug@value@en@thesistype@masful}%
                \def\cug@fixtable@length{7em}
                \def\maketitle{\maketitle@xpdc}
                \def\MAKETITLE{\MAKETITLE@xpdc}
            }{
                \cugifstreq{\cug@value@en@degree}{Doctor}{%
                    \def\cug@label@ch@thesis{\cug@label@ch@thesis@doc}%
                    \def\cug@label@ch@author{\cug@label@ch@author@doc}%
                    \def\cug@label@en@author{\cug@label@en@author@doc}%
                    \def\cug@label@ch@major{\cug@label@ch@major@doc}%
                    \def\cug@label@ch@institute{\cug@label@ch@institute@doc}%
                    \def\cug@value@en@thesistype{\cug@value@en@thesistype@doc}%
                    \def\maketitle{\maketitle@xpdc}
                    \def\MAKETITLE{\MAKETITLE@xpdc}
                }{%
                    \cugifstreq{\cug@value@en@degree}{Postdoctor}{%
                        \def\cug@label@ch@thesis{\cug@label@ch@thesis@pdc}%
                        \def\cug@label@ch@author{\cug@label@ch@author@pdc}%
                        \def\cug@label@ch@major{\cug@label@ch@major@pdc}%
                        \def\cug@label@ch@institute{\cug@label@ch@institute@pdc}%
                        \def\cug@value@en@thesistype{\cug@value@en@thesistype@pdc}%
                        \def\maketitle{\maketitle@pdc}
                        \def\MAKETITLE{\MAKETITLE@pdc}
                    }{%
                        \ClassWarning{cugthesis}{Invalid value of '\string\DEGREE', please check the spelling}%
                    }}}}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ++
%-
%-> Define Chinese style
%-
%%%%% 封面表格
\newcommand{\cug@info@table@item}[2]{
    \makebox[6.5em][s]{#1} & \makebox[8em][l]{#2} & \\
}

\newcommand{\maketitle@xpdc}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \linespread{\customsingleline}
        \zihao{3}
        \vspace*{\stretch{2}}

        {\cug@label@ch@schoolcode \cug@value@ch@schoolcode} \hfill{} {\cug@label@ch@studentID \cug@value@ch@studentID}

        \vspace*{\stretch{1}}

        {\zihao{1}\bfseries\cug@label@ch@schoolname \par}

        \vspace*{\stretch{1}}

        {\zihao{1}\bfseries\cug@label@ch@thesis \par}

        \vspace*{\stretch{2}}

        {\zihao{2}\bfseries\sffamily \cug@value@ch@title \par} % heiti

        \vspace*{\stretch{3}}

        \def\arraystretch{1.5}
        \begin{tabular}{r@{\hskip 1em}l}
            \makebox[\cug@fixtable@length][s]{\cug@label@ch@author}    & \makebox[7em][l]{\cug@value@ch@author}               \\
            \makebox[\cug@fixtable@length][s]{\cug@label@ch@major}     & \cug@value@ch@major                \\
            \makebox[\cug@fixtable@length][s]{\cug@label@ch@advisor}   & \cuglntotab{\cug@value@ch@advisor} \\
            \makebox[\cug@fixtable@length][s]{\cug@label@ch@institute} & \cug@value@ch@institute            \\
        \end{tabular}

        \vspace*{\stretch{4}}

        {\cug@value@ch@date}

        \vspace*{\stretch{4}}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifcug@versioninfo
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifcug@versioninfo
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
    \ifcug@print%
        \hypersetup{% set hyperlinks
            hidelinks,% remove link color and border
        }
    \fi
}
\newcommand{\maketitle@pdc}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}

        \vspace*{30pt}

        \linespread{2.0}
        \zihao{4}

        \makebox[3.0em][s]{\cug@label@ch@classid} \ulenhance{\ulextend[6em]{\zihao{5}\cug@value@ch@classid}} \hfill{} \cug@label@ch@confidential \ulenhance{\ulextend[6em]{\zihao{5}\cug@value@ch@confidential}}

        \makebox[3.0em][s]{\cug@label@ch@udc} \ulenhance{\ulextend[6em]{\zihao{5}\cug@value@ch@udc}} \hfill{} \cug@label@ch@orderid \ulenhance{\ulextend[6em]{\zihao{5}\cug@value@ch@orderid}}

        \vspace*{\stretch{6}}

        {\ziju{1.5}\cug@value@ch@schoollogo}

        \vspace*{\stretch{1}}

        {\zihao{-2}\bfseries\sffamily{\ziju{0.5}\cug@label@ch@thesis}}

        \vspace*{\stretch{3}}

        {\zihao{-3} \ulenhance[1.5pt]{\cug@value@ch@title}}

        \vspace*{\stretch{2.5}}

        \cug@value@ch@author

        \vspace*{\stretch{2.5}}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.3}
        \begin{tabular}{l@{\quad}c}
            \cug@label@ch@completedate & \ulenhance{\ulextend[200pt]{\cug@value@ch@completedate}} \\
            \cug@label@ch@submitdate   & \ulenhance{\ulextend[200pt]{\cug@value@ch@submitdate}}   \\
        \end{tabular}

        \vspace*{\stretch{2}}

        \cug@value@ch@institute

        \cug@value@ch@date

        \vspace*{\stretch{4}}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
    \ifcug@print%
        \hypersetup{% set hyperlinks
            hidelinks,% remove link color and border
        }
    \fi
}
%-
%-> Define English style
%-
\newcommand{\MAKETITLE@xpdc}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \linespread{\customsingleline}
        \zihao{3}

        \vspace*{\stretch{1}}

        {\linespread{\customonehalfline}\zihao{3} \cug@label@en@statement\par}

        \vspace*{\stretch{3}}

        {\zihao{2}\bfseries \cug@value@en@title \par}

        \vspace*{\stretch{2.5}}

        \def\arraystretch{1.5}
        \begin{tabular}{r@{\hskip 1em}l}
            \cug@label@en@author  & \makebox[10em][l]{\cug@value@en@author}              \\
            \cug@label@en@major   & \cug@value@en@major                \\
            \cug@label@en@advisor & \cuglntotab{\cug@value@en@advisor} \\
        \end{tabular}

        \vspace*{\stretch{4}}

        {\linespread{\customonehalfline}\zihao{3}\cug@label@en@schoolname\par \cug@label@en@schoolloc \par}

        \vspace*{\stretch{3}}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
\newcommand{\MAKETITLE@pdc}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \linespread{2.0}
        \zihao{4}

        \vspace*{50pt}

        {\zihao{3} \cug@value@ch@title}

        \vspace*{\stretch{3}}

        {\zihao{-3} \cug@value@en@title}

        \vspace*{\stretch{3}}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.3}
        \begin{tabular}{l@{\quad}l}
            \makebox[11em][s]{\cug@label@ch@author}  & \cug@value@ch@author  \\
            \makebox[11em][s]{\cug@label@ch@subject} & \cug@value@ch@subject \\
            \makebox[11em][s]{\cug@label@ch@major}   & \cug@value@ch@major   \\
        \end{tabular}

        \vspace*{\stretch{3}}

        \cug@label@ch@studydatefrom \quad \cug@value@ch@studydatefrom

        \cug@label@ch@studydateto \quad \cug@value@ch@studydateto

        \vspace*{\stretch{3}}

        \cug@value@ch@orginization

        \cug@value@ch@date

        \vspace*{\stretch{3}}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
%---------------------------------------------------------------------------%
%->> Author's declaration
%---------------------------------------------------------------------------%
\newcommand{\makedeclaration}{%
    \cleardoublepage
    \thispagestyle{empty}
    {
        \linespread{1.7}
        \zihao{4}

        \vspace*{16.5mm}

        \begin{center}
            {\linespread{\customonequarterline}\zihao{3}\sffamily \cug@label@ch@schoolnameWH 研究生学位论文原创性声明\par}
        \end{center}

        \vspace*{6mm}


        {本人郑重声明：本人所呈交的\cug@value@ch@degree 学位论文《\cug@value@ch@title 》，是本人在导师的指导下，在\cug@label@ch@schoolnameWH 攻读\cug@value@ch@degree 学位期间独立进行研究工作所取得的成果。论文中除已注明部分外不包含他人已发表或撰写过的研究成果，对论文的完成提供过帮助的有关人员已在文中说明并致以谢意。

            本人所呈交的\cug@value@ch@degree 学位论文没有违反学术道德和学术规范，没有侵权行为，并愿意承担由此而产生的法律责任和法律后果。}


        \vspace*{15mm}

        {\linespread{3}\zihao{4}
            {\hfill{} {学位论文作者签名：\ulenhance[0.5pt]{\qquad\qquad\quad}}}

            {\hfill{} {日\quad 期：\qquad\quad 年\qquad 月\qquad 日}}\par
        }

        \vspace*{6ex}
    }
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
\newcommand{\maketeacherdeclaration}{%
    \cleardoublepage
    \thispagestyle{empty}
    {
        \linespread{1.7}
        \zihao{4}

        \vspace*{16.5mm}

        \begin{center}
            {\linespread{\customonequarterline}\zihao{3}\sffamily \cug@label@ch@schoolnameWH 研究生学位论文导师承诺书\par}
        \end{center}

        \vspace*{10mm}

        {本人郑重承诺：本人所指导的\cug@value@ch@degree 学位论文《\cug@value@ch@title 》，是在本人的指导下，研究生在\cug@label@ch@schoolnameWH 攻读\cug@value@ch@degree 学位期间独立进行研究工作所取得的成果，论文由研究生独立完成。

            研究生所呈交的\cug@value@ch@degree 学位论文没有违反学术道德和学术规范，没有侵权行为，并愿意承担由此而产生的与导师相关的责任和后果。}

        \vspace*{15mm}

        {\linespread{2}\zihao{4}
            {\hfill{} {指导老师（签字）：\ulenhance[0.5pt]{\qquad\qquad\quad}}}

            {\hfill{} {日\quad 期：\hspace*{2.2em} 年\qquad 月\qquad 日}}\par}

        \vspace*{6ex}
    }
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
\newcommand{\makeip}{%
    \cleardoublepage
    \thispagestyle{empty}
    {
        \linespread{1.7}
        \zihao{4}

        \vspace*{16.5mm}

        \begin{center}
            {\linespread{\customonequarterline}\zihao{3}\sffamily \cug@label@ch@schoolnameWH 研究生学位论文使用授权书\par}
        \end{center}

        \vspace*{6mm}

        {本人授权\cug@label@ch@schoolnameWH 可采用影印、缩印、数字化或其它复制手段保存本学位论文；学校可向国家有关部门或机构送交本学位论文的电子版全文，编入有关数据库进行检索、下载及文献传递服务；同意在校园网内提供全文浏览和下载服务。

            涉密论文解密后适用于本授权书。}


        \vspace*{15mm}

        {\linespread{3}\zihao{4}
            {\hfill{} {学位论文作者签名：\ulenhance[0.5pt]{\qquad\qquad\quad}}}

            {\hfill{} {日\quad 期：\qquad\quad 年\qquad 月\qquad 日}}\par
        }

        \vspace*{6ex}
    }
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
%---------------------------------------------------------------------------%
%->> New environments
%---------------------------------------------------------------------------%
%- define chinese keywords
\newcommand{\keywords}[1]{%
    \vspace{\baselineskip}
    \noindent {\bfseries \cug@label@ch@keywords} #1}
%- define engish keywords
\newcommand{\KEYWORDS}[1]{%
    \vspace{\baselineskip}
    \noindent {\bfseries \cug@label@en@keywords} #1}
%---------------------------------------------------------------------------%
%->> Structure elements
%---------------------------------------------------------------------------%
\ifcug@plain%
    \def\contentsname{\cug@label@en@tocname}
    \def\listfigurename{\cug@label@en@lsfigname}
    \def\listappfigname{}
    \def\listtablename{\cug@label@en@lstabname}
    \def\listapptabname{}
    \def\bibname{\cug@label@en@bibname}
    \def\refname{\cug@label@en@bibname}
    \def\algname{\cug@label@en@algname}
    \def\bibetal{\cug@label@en@bibetal}
    \def\biband{\cug@label@en@biband}
    \def\axiomname{\cug@label@en@axiomname}
    \def\theoremname{\cug@label@en@theoremname}
    \def\lemmaname{\cug@label@en@lemmaname}
    \def\corollaryname{\cug@label@en@corollaryname}
    \def\assertionname{\cug@label@en@assertionname}
    \def\propositionname{\cug@label@en@propositionname}
    \def\conjecturename{\cug@label@en@conjecturename}
    \def\definitionname{\cug@label@en@definitionname}
    \def\examplename{\cug@label@en@examplename}
    \def\remarkname{\cug@label@en@remarkname}
    \def\proofname{\cug@label@en@proofname}
    \def\@title{\cug@value@en@titlemark}
    \def\@author{\cug@value@en@author}
\else
    \def\contentsname{\cug@label@ch@tocname}
    \def\listfigurename{\cug@label@ch@lsfigname}
    \def\listappfigname{}
    \def\listtablename{\cug@label@ch@lstabname}
    \def\listapptabname{}
    \def\algname{\cug@label@ch@algname}
    \def\bibname{\cug@label@ch@bibname}
    \def\refname{\cug@label@ch@bibname}
    \def\bibetal{\cug@label@ch@bibetal}
    \def\biband{\cug@label@ch@biband}
    \def\axiomname{\cug@label@ch@axiomname}
    \def\theoremname{\cug@label@ch@theoremname}
    \def\lemmaname{\cug@label@ch@lemmaname}
    \def\corollaryname{\cug@label@ch@corollaryname}
    \def\assertionname{\cug@label@ch@assertionname}
    \def\propositionname{\cug@label@ch@propositionname}
    \def\conjecturename{\cug@label@ch@conjecturename}
    \def\definitionname{\cug@label@ch@definitionname}
    \def\examplename{\cug@label@ch@examplename}
    \def\remarkname{\cug@label@ch@remarkname}
    \def\proofname{\cug@label@ch@proofname}
    \def\@title{\cug@value@ch@titlemark}
    \def\@author{\cug@value@ch@author}
\fi
%---------------------------------------------------------------------------%
%->> Structure layout
%---------------------------------------------------------------------------%
%- chapter
% \RequirePackage{titlesec}% LaTeX engine detection
% \RequirePackage{interfaces-titlesec}% LaTeX engine detection
% \sectionformat\chapter*{%
%      shape=block,
%         format = \linespread{1.0}\zihao{3}\bfseries\sffamily\centering,
%        top=-\baselineskip,
%     bottom=\baselineskip}
\newcounter{cug@authorcv@section}
\newcommand{\cugcvsection}[1]{%
    \stepcounter{cug@authorcv@section}
    {\par \zihao{-4}\sffamily \noindent \chinese{cug@authorcv@section}、 #1}\par
}

\newcommand{\makeabstractname}[1]{
    \intobmk*{\cleardoublepage}{#1}
    {\linespread{\customsingleline}\zihao{-2}\sffamily\bfseries \centering#1\par}
    \vspace*{10pt}
}
\newcommand{\makecvname}[1]{
    {\linespread{\customsingleline}\zihao{3}
            \vspace*{2\baselineskip}
            \begin{center}
                {\sffamily #1}
            \end{center}
            \vspace*{2\baselineskip}\par
        }
}

\ctexset {
    chapter = {
      format = \linespread{1.0}\zihao{3}\bfseries\sffamily\centering,
      nameformat = {},
      titleformat = {},
      number = \zhnum{chapter},
      numberformat = \sffamily,
      aftername = \quad,
      beforeskip = {2\baselineskip},
      fixskip=true,
      afterskip = {2\baselineskip},
      pagestyle = plain,
     }
}

%- section
\ctexset {
    section = {
      format = \linespread{1.0}\zihao{4}\bfseries\sffamily\centering,
      numberformat = \rmfamily,
      aftername = \quad,
      fixskip=true,
      beforeskip = {\baselineskip},
      afterskip = {\baselineskip},
     }
}
%- subsection
\ctexset {
    subsection = {
            format = \linespread{1.0}\zihao{-4}\sffamily\raggedright,
            numberformat = \rmfamily,
            aftername = \quad,
            fixskip=true,
            beforeskip = {\baselineskip},
            afterskip = {\baselineskip},
        }
}
%- subsubsection
\ctexset {
    subsubsection = {
            format = \linespread{1.0}\zihao{-4}\sffamily\raggedright,
            numberformat = \rmfamily,
            aftername = \quad,
            fixskip=true,
            beforeskip = {12pt},
            afterskip = {6pt},
        }
}
%- appendix
\ctexset {
    appendix = {
            numbering = true,
            number = \rmfamily\zhnum{chapter},
        }
}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- the table of contents is specified by defining \l@chapter, \l@section, ...
%- most commands are then defined with the \@dottedtocline:
%- \@dottedtocline{⟨level⟩}{⟨indent⟩}{⟨numwidth⟩}{⟨title⟩}{⟨page⟩}
%- ⟨level⟩    an entry is produced only if ⟨level⟩ <= value of the tocdepth counter
%-            note, \chapter is level 0, \section is level 1, etc
%- ⟨indent⟩   indentation from the outer left margin of the start of the contents line
%- ⟨numwidth⟩ width of a box in which the section number is to go
%- <title>    title
%- <page>     page number
\RequirePackage{tocloft}
\setlength{\cftbeforetoctitleskip}{0pt}   % space above title, (set a negative value to decrease the indent)
\setlength{\cftaftertoctitleskip}{10pt}
\renewcommand{\cftaftertoctitle}{\thispagestyle{empty}} % set header of toc to empty

\setlength{\cftbeforeloftitleskip}{20pt}   % space above listoffigure, (set a negative value to decrease the indent)
\setlength{\cftafterloftitleskip}{20pt}
\renewcommand{\cftloftitlefont}{\hfill\sffamily\zihao{-2}} % set fontsize to -2
\renewcommand{\listfigurename}{图清单} % rename title to ...
\renewcommand{\cftafterloftitle}{\hfill}

\setlength{\cftbeforelottitleskip}{20pt}   % space above listoftable, (set a negative value to decrease the indent)
\setlength{\cftafterlottitleskip}{20pt}
\renewcommand{\cftlottitlefont}{\hfill\sffamily\zihao{-2}}
\renewcommand{\listtablename}{表清单}
\renewcommand{\cftafterlottitle}{\hfill}

\renewcommand{\contentsname}{\zihao{3}\bfseries\sffamily\cug@label@ch@tocname}
\newcommand{\contenttobmk}{
    \intobmk*{\cleardoublepage}{\cug@label@ch@tocname}% add link to bookmark
}
\newcommand{\makesymbollist}{
    \intobmk*{\cleardoublepage}{符号列表}% add link to bookmark
    {\linespread{\customsingleline}\zihao{3}\sffamily\bfseries \centering 符号列表 \par}
    \vspace*{10pt}
}

%- parameters for spacing and length in toc
\def\@dotsep{1.5mu}% separation between dots in mu units
\def\@pnumwidth{2em}% width of a box in which the page number is put
\def\@tocrmarg{2em}% right margin for multiple line entries, \@tocrmarg ≥ \@pnumwidth
\def\@chaptervspace{1ex}% vertical space between chapter titles

%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
            \parindent #2\relax\@afterindenttrue
            \interlinepenalty\@M
            \leavevmode \zihao{-4}\rmfamily
            \@tempdima #3\relax
            \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
            {#4}\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
            \nobreak
            \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
            \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from book.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty{-\@highpenalty}%
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        {\leavevmode
            \zihao{4}\rmfamily #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
        \nobreak
        \global\@nobreaktrue
        \everypar{\global\@nobreakfalse\everypar{}}%
        \endgroup
    \fi
}
%- redefine l@chapter from book.cls to add dotted toc line
\renewcommand*{\l@chapter}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        % \vskip \@chaptervspace \@plus\p@
        \setlength\@tempdima{1.5em}%
        \begingroup
        \parindent \z@ \rightskip \@pnumwidth
        \parfillskip -\@pnumwidth
        \leavevmode \zihao{4}\rmfamily
        \advance\leftskip\@tempdima
        \hskip -\leftskip
        #1\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
        \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
        \penalty\@highpenalty
        \endgroup
    \fi
}
%- redefine indentation for others
\renewcommand*\l@section{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{2em}{2.8em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{3em}{3.8em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{4em}{4.8em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{5em}{5.8em}}
\renewcommand*\l@figure{\@dottedtocline{1}{1em}{1.8em}}
\renewcommand*\l@table{\@dottedtocline{1}{1em}{1.8em}}
%---------------------------------------------------------------------------%
% allow line-change of url 
\RequirePackage{url}
\expandafter\def\expandafter\UrlBreaks\expandafter{\UrlBreaks%  save the current one
    \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
    \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
    \do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D%
    \do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
    \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X%
    \do\Y\do\Z\do\*\do\-\do\~\do\'\do\"\do\-}

\endinput

