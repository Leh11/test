
    \usepackage[hidelinks, unicode=true, colorlinks, breaklinks]{hyperref}
    \usepackage[justification=centering]{caption}
    \RequirePackage{etoolbox}
    %\RequirePackage{filecontents}
    \newtoggle{qqtshowframe}
    \newtoggle{qqtnatbib}

    % Display first page geometry frame around header and footer only (use for debug).
    \DeclareOption{headshowframe}
    {
    \toggletrue{qqtshowframe}
    }

    % Biblatex bibtex backend
    \DeclareOption{bibtex}
    {
    \PassOptionsToPackage{backend=bibtex,bibencoding=ascii}{biblatex}
    }

    % Biblatex biber backend
    \DeclareOption{biber}
    {
    \PassOptionsToPackage{backend=biber,bibencoding=utf-8}{biblatex}
    }

    \DeclareOption{biblatex}
    {
    \togglefalse{qqtnatbib}
    }

    % (DEPRECATED)
    \DeclareOption{natbib}
    {
    \toggletrue{qqtnatbib}
    }

    \ExecuteOptions{10pt,biblatex}
    \ProcessOptions\relax

    %--------------------------------------------
    % BIBLATEX CUSTOM CONFIG
    %--------------------------------------------
    %
    \begin{filecontents}{biblatex-dm.cfg}
    \DeclareDatamodelFields[type=field, datatype=verbatim]{pmid}
    \DeclareDatamodelEntryfields{pmid}
    \DeclareDatamodelFields[type=field, datatype=verbatim]{pmcid}
    \DeclareDatamodelEntryfields{pmcid}
    \end{filecontents}


    %--------------------------------------------
    % CLASS BASE
    %--------------------------------------------

    \NeedsTeXFormat{LaTeX2e}
    \ProvidesClass{qqtarticle}[2020/19/08, V1.0]
    \LoadClass{article}

    %--------------------------------------------
    % PACKAGES
    %--------------------------------------------

    % Detect tex4ht or htlatex use.
    \newif\ifhttex \ifx\HCode\undefined \httexfalse \else \httextrue \fi

    % Compatibility with Luatex
    \RequirePackage{ifluatex}
    \ifluatex
    \RequirePackage{fontspec}
    \else
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[T1]{fontenc}
    \fi

    \RequirePackage[english]{babel}
    \RequirePackage{lmodern}
    \RequirePackage{geometry}
    \RequirePackage{fancyhdr}
    \RequirePackage{amsfonts,amsmath,amssymb,amsthm}
    \RequirePackage[table]{xcolor}
    \RequirePackage{tikz}
    \usetikzlibrary{calc,trees,positioning,arrows,chains,shapes.geometric,%
    decorations.pathreplacing,decorations.pathmorphing,shapes,%
    matrix,shapes.symbols}
    \PassOptionsToPackage{hyphens}{url}

    % For epub format
    \ifhttex
    \else
    % Not compatible with tex4ht
    \RequirePackage{mdframed}
    \RequirePackage{floatrow}
    \fi

    %\RequirePackage[unicode=true, colorlinks=true, breaklinks=true]{hyperref}
    \RequirePackage{anysize}
    \RequirePackage{titling}
    \iftoggle{qqtnatbib}
    {/
    \RequirePackage[super,comma]{natbib}
    }
    {
    \RequirePackage[natbib,
                    style=numeric-comp,
                    giveninits=true,
                    terseinits=true,
                    sorting=none,
                    minbibnames=6,
                    maxbibnames=6,
                    maxcitenames=2,
                    backend=bibtex,
                    bibencoding=ascii]{biblatex}
    }
    \RequirePackage{csquotes}
    \RequirePackage{titlesec}
    \RequirePackage{setspace}
    \RequirePackage[singlelinecheck=false, font=it, font=small]{caption}
    \RequirePackage{booktabs}
    \RequirePackage[siunitx]{circuitikz}
    \RequirePackage[scaled=1.00]{sourcesanspro}
    \RequirePackage[absolute]{textpos}
    \RequirePackage{textcomp}
    \RequirePackage{listings}
    \RequirePackage{graphicx}
    \RequirePackage{tabularx}
    %\RequirePackage{l3regex}

    \RequirePackage{enumitem}
    \RequirePackage{amsmath}
    \RequirePackage{amssymb}
    \RequirePackage{amsfonts}
    \RequirePackage{amsthm}

    %--------------------------------------------
    % PAPER FORMAT
    %--------------------------------------------

    % Define all sizes.

    % All page
    \newlength\qqtTop
    \newlength\qqtBottom
    \newlength\qqtLeft
    \newlength\qqtRight
    \newlength\qqtHeadHeight
    \newlength\qqtHeadSep
    \newlength\qqtFootSkip
    % First page.
    \newlength\qqtFrontTop
    \newlength\qqtFrontBottom
    \newlength\qqtFrontFootRuleWidth
    \newlength\qqtFrontFootHeight
    \newlength\qqtFrontFootSkip
    \newlength\qqtFrontHeadHeight
    \newlength\qqtFrontHeadRuleWidth
    \newlength\qqtFrontHeadInnerTop
    \newlength\qqtFrontTextTop
    \newlength\qqtFrontTextReduce
    \newlength\qqtFrontFootTop
    \newlength\qqtLogoVShift
    \newlength\qqtTitleSep
    \newlength\qqtAuthorsSep
    \newlength\qqtAffiliationsSep
    \newlength\qqtAbstractSep
    \newlength\qqtKeywordsSep

    % All pages.
    \qqtTop=8mm
    \qqtBottom=1.27cm
    \qqtLeft=1.27cm
    \qqtRight=1.27cm
    \qqtHeadHeight=12pt
    \qqtHeadSep=10pt
    \qqtFootSkip=8pt
    % First page.
    \qqtFrontTop=.3cm
    \qqtFrontHeadHeight=1.22cm
    \qqtFrontHeadInnerTop=0pt
    \qqtFrontHeadRuleWidth=2pt
    \qqtFrontBottom=1.3cm
    \qqtFrontFootHeight=1.35cm
    \qqtFrontFootSkip=.35cm
    \qqtFrontFootRuleWidth=1pt
    \qqtLogoVShift=2pt
    \qqtTitleSep=.35cm
    \qqtAuthorsSep=11pt
    \qqtAffiliationsSep=13pt
    \qqtAbstractSep=8pt
    \qqtKeywordsSep=10pt
    %\toggletrue{qqtshowframe}


    % Calculate text exactly at the top
    \qqtFrontTextTop=\dimexpr(-\qqtTop-\qqtHeadHeight-\qqtHeadSep)
    % Calculate text after frontpage header
    \qqtFrontTextTop=\dimexpr(\qqtFrontTextTop + \qqtFrontTop + \qqtFrontHeadHeight
    + \qqtTitleSep + 1\qqtFrontHeadRuleWidth)
    % Calculate reduce size for textheight. Remove global size et set footer to page bottom.
    \qqtFrontTextReduce=\dimexpr(\qqtBottom)
    % Calculate text above footer
    \qqtFrontTextReduce=\dimexpr(\qqtFrontTextReduce - \qqtFrontBottom - \qqtFrontFootHeight -\qqtFrontFootSkip - 2\qqtFrontFootRuleWidth)
    % Fix
    \qqtFrontTextReduce=\dimexpr(\qqtFrontTextReduce - 2pt)
    % Calculate footer to glue bottom.
    \qqtFrontFootTop=\dimexpr(21cm-\qqtFrontFootHeight-2\qqtFrontFootRuleWidth)%-\qqtFrontBottom)
    % Calculate footer from origin
    \qqtFrontFootTop=\dimexpr(\qqtFrontFootTop-\qqtFrontBottom)

    % All pages format.
    \geometry{
    %showframe, % Ignore for the first page as we use custom made geometry.
    a5paper,
    left=\qqtLeft,
    right=\qqtRight,
    top=\qqtTop,
    bottom=\qqtBottom,
    headheight=\qqtHeadHeight,
    headsep=\qqtHeadSep,
    footskip=\qqtFootSkip,
    includehead,
    ignorefoot,
    heightrounded,
    twoside,
    }%
    %\fancy@setoffs
    \f@nch@setoffs

    \setlength{\textfloatsep}{12pt plus 1pt minus 1pt}  %% Or whatever length
    %\captionsetup[table]{aboveskip=0pt,belowskip=0pt}

    \ifhttex
    \else
    \floatsetup[table]{capposition=top,captionskip=2pt}
    \floatsetup[figure]{captionskip=4pt}
    \fi

    %-------------------------------------------------------------------------------
    % CAPTION
    %-------------------------------------------------------------------------------

    %\captionsetup[table]{labelfont=it}
    \captionsetup{labelfont=it}

    \DeclareCaptionLabelSeparator{colon}{. }
    \addto\captionsenglish{\renewcommand{\figurename}{Fig.}}
    %\addto\captionsenglish{\renewcommand{\tablename}{Tab.}}
    \addto\captionsenglish{\renewcommand{\lstlistingname}{Code}}

    \newcommand{\figref}[1]{\figurename~\ref{#1}}
    \newcommand{\tabref}[1]{\tablename~\ref{#1}}
    \newcommand{\codref}[1]{\lstlistingname~\ref{#1}}

    %-------------------------------------------------------------------------------
    % FONT
    %-------------------------------------------------------------------------------

    \renewcommand{\familydefault}{\sfdefault}

    \def\fontsizeSeven{\fontsize{7pt}{7pt}\selectfont}
    \def\fontsizeEight{\fontsize{8pt}{8pt}\selectfont}
    \def\fontsizeEightFive{\fontsize{8.5pt}{8pt}\selectfont}
    \def\fontsizeNine{\fontsize{9pt}{9pt}\selectfont}
    \def\fontsizetitle{\fontsize{22pt}{22pt}\selectfont}

    %-------------------------------------------------------------------------------
    % COLORS
    %-------------------------------------------------------------------------------

    \definecolor{rightheadercol}{HTML}{133644}
    \definecolor{qqttablecolor}{HTML}{BDD4D6}

    %-------------------------------------------------------------------------------
    % URL, LINKS, HYPERLINKS, PDF METADATA
    %-------------------------------------------------------------------------------

    \renewcommand\UrlFont{}

    \hypersetup{
    unicode=false,         % non-Latin characters in Acrobat's bookmarks
    pdftoolbar=true,       % show Acrobat's toolbar?
    pdfmenubar=true,       % show Acrobat's menu?
    pdffitwindow=false,    % window fit to page when opened
    pdfborder={0 0 0},     % remove border
    pdfstartview={FitH},   % fits the width of the page to the window
    %    pdfpagelabels=true,
    %    pagebackref=true,
    %    bookmarks=true,
    bookmarksopen=true,
    bookmarksopenlevel=1,
    bookmarksnumbered=true,
    colorlinks=true,   % false: boxed links; true: colored links
    linkcolor=black,    % color of internal links
    citecolor=black,   % color of links to bibliography
    filecolor=black, % color of file links
    urlcolor=black,  % color of external links
    }

    %-------------------------------------------------------------------------------
    % CODE
    %-------------------------------------------------------------------------------

    \lstset{
    basicstyle=\normalfont\small\ttfamily,
    frame=single,
    belowcaptionskip=1\baselineskip,
    breaklines=true,
    resetmargins=true, % itemize,enumerate
    xleftmargin=4pt, %\parindent,%4pt,
    xrightmargin=4pt, %\parindent,%4pt,
    showstringspaces=false,
    postbreak=\raisebox{0ex}[0ex][0ex]{\ensuremath{\color{gray}\hookrightarrow\space}},
    backgroundcolor=\color{cyan!30!white!20!},
    keywordstyle=\bfseries\color{green!40!black},
    commentstyle=shape\color{purple!40!black},
    identifierstyle=\color{blue!30!black},
    stringstyle=\color{orange},
    abovecaptionskip=4pt,
    belowcaptionskip=4pt,
    %numbers=left,
    %numbersep=5pt,
    %numberstyle=\tiny\color{gray},
    }

    %-------------------------------------------------------------------------------
    % NOTICE MESSAGE
    %-------------------------------------------------------------------------------

    \def\qqtcmdcol#1{\textcolor{blue!50!black}{#1}}
    \def\qqt@msg@Title{\normalfont{\normalsize{\textcolor{red}{< Add a title (use \qqtcmdcol{qqtTitle}). >}}}}
    \def\qqt@msg@RunningTitle{\normalfont{\normalsize{\textcolor{red}{< Add a short title (use \qqtcmdcol{qqtRunningTitle}). >}}}}
    \def\qqt@msg@Correspondance{\textcolor{red}{< Adress for the correspondence (use \qqtcmdcol{qqtCorrespondence}). >}}
    \def\qqt@msg@CorrespondanceEmail{\textcolor{red}{< email of the person to contact (\qqtcmdcol{qqtCorrespondenceEmail}). >}}
    \def\qqt@msg@AbstractPurpose{\textcolor{red}{< Briefly describe the purpose of this article (use \qqtcmdcol{qqtAbstractPurpose}). >}}
    \def\qqt@msg@AbstractMethods{\textcolor{red}{< Briefly describe the method used (use \qqtcmdcol{qqtAbstractMethods}). >}}
    \def\qqt@msg@AbstractResults{\textcolor{red}{< Briefly describe your results (use \qqtcmdcol{qqtAbstractResults}). >}}
    \def\qqt@msg@AbstractConclusion{\textcolor{red}{< give a brief conclusion (use \qqtcmdcol{qqtAbstractConclusion}). >}}
    \def\qqt@msg@Affiliations{\textcolor{red}{< Add at least one affiliation (use \qqtcmdcol{qqtAddAffiliation}). >}}
    \def\qqt@msg@Authors{\textcolor{red}{< Add at least one author (use \qqtcmdcol{qqtAddAuthor}). >}}
    \def\qqt@msg@Keywords{\textcolor{red}{< 5 to 8 keywords or phrases in alphabetical order,separated by commas (use \qqtcmdcol{qqtAddKeyword}). >}}


    %-------------------------------------------------------------------------------
    % USER FORM VARIABLES
    %-------------------------------------------------------------------------------

    % Available commands.
    \newcommand{\qqtTitle}[1]{\ifx#1\empty\else \def\@qqtTitle{#1} \fi}
    \newcommand{\qqtRunningTitle}[1]{\ifx#1\empty\else \def\@qqtRunningTitle{#1} \fi}
    \newcommand{\qqtCorrespondence}[1]{\ifx#1\empty\else \def\@qqtCorrespondence{#1} \fi}
    \newcommand{\qqtCorrespondenceEmail}[1]{\ifx#1\empty\else \def\@qqtCorrespondenceEmail{#1} \fi}
    \newcommand{\qqtAbstractPurpose}[1]{\ifx#1\empty\else \def\@qqtAbstractPurpose{#1} \fi}
    \newcommand{\qqtAbstractMethods}[1]{\ifx#1\empty\else \def\@qqtAbstractMethods{#1} \fi}
    \newcommand{\qqtAbstractResults}[1]{\ifx#1\empty\else \def\@qqtAbstractResults{#1} \fi}
    \newcommand{\qqtAbstractConclusion}[1]{\ifx#1\empty\else \def\@qqtAbstractConclusion{#1} \fi}
    \newcommand{\qqtJournalName}[1]{\ifx#1\empty\else \def\@qqtJournalName{#1} \fi}
    \newcommand{\qqtJournalDate}[1]{\ifx#1\empty\else \def\@qqtJournalDate{#1} \fi}
    \newcommand{\qqtJournalTitle}[1]{\ifx#1\empty\else \def\@qqtJournalTitle{#1} \fi}
    \newcommand{\qqtCustomRunningAuthors}[1]{\def\@qqtCustomRunningAuthors{#1}}

    % Available commands default values
    \qqtTitle{\qqt@msg@Title}
    \qqtRunningTitle{\qqt@msg@RunningTitle}
    \qqtCorrespondence{\qqt@msg@Correspondance}
    \qqtCorrespondenceEmail{\qqt@msg@CorrespondanceEmail}
    \qqtAbstractPurpose{\qqt@msg@AbstractPurpose}
    \qqtAbstractMethods{\qqt@msg@AbstractMethods}
    \qqtAbstractResults{\qqt@msg@AbstractResults}
    \qqtAbstractConclusion{\qqt@msg@AbstractConclusion}
    \qqtJournalTitle{\qqt@msg@JournalTitle}
    \qqtCustomRunningAuthors{} % Optional

    % Private variables
    \newcommand{\qqtAuthors}[1]{\def\@qqtAuthors{#1}}
    \newcommand{\qqtAuthorsIdx}[1]{\def\@qqtAuthorsIdx{#1}}
    \newcommand{\qqtRunningAuthors}[1]{\def\@qqtRunningAuthors{#1}}
    \newcommand{\qqtRunningAuthorsIdx}[1]{\def\@qqtRunningAuthorsIdx{#1}}
    \newcommand{\qqtAffiliations}[1]{\def\@qqtAffiliations{#1}}
    \newcommand{\qqtKeywords}[1]{\def\@qqtKeywords{#1}}
    \qqtAuthors{}
    \qqtAuthorsIdx{}
    \qqtRunningAuthors{}
    \qqtRunningAuthorsIdx{}
    \qqtAffiliations{}
    \qqtKeywords{}

    %--------------------------------------------------------------------------------
    % HEADER, FOOTER
    %--------------------------------------------------------------------------------

    \fancypagestyle{frontpage}
    {
    \fancyhead[RE]{}
    \fancyhead[LE,RO]{}
    \fancyhead[LO]{}
    \renewcommand{\headrulewidth}{0pt}
    }

    \AtBeginDocument
    {
    \pagestyle{fancy}
    \fancyhead{} % clear all header fields
    \fancyhead[RE]
    {
    \ifx\@qqtCustomRunningAuthors\empty
        \@qqtRunningAuthors
    \else
        \@qqtCustomRunningAuthors
    \fi
    }
    \fancyhead[LE,RO]{\thepage}
    \fancyhead[LO]{\@qqtRunningTitle}
    \fancyfoot{} % clear all footer fields
    }

    \renewcommand{\headrulewidth}{1pt}

    %--------------------------------------------------------------------------------
    % FRONT PAGE HEADER, FOOTER FRAME
    %--------------------------------------------------------------------------------

    \def\isFrontShowFrame{\iftoggle{qqtshowframe}{true}{false}}

    \ifhttex
    % no mdframed config
    \else
    \newmdenv[skipabove=0pt,
    skipbelow=0pt,
    innertopmargin=0pt,
    innerleftmargin=0pt,
    innerrightmargin=0pt,
    innerbottommargin=0pt,
    topline=\isFrontShowFrame,
    bottomline=\isFrontShowFrame,
    leftline=\isFrontShowFrame,
    rightline=\isFrontShowFrame,
    linewidth=1pt,
    linecolor=red,
    ]{fmodebugframe}

    \newmdenv[skipabove=0pt,
    skipbelow=0pt,
    innertopmargin=0pt,
    innerleftmargin=0pt,
    innerrightmargin=0pt,
    innerbottommargin=0pt,
    topline=false,
    bottomline=true,
    leftline=false,
    rightline=false,
    linewidth=\qqtFrontHeadRuleWidth,
    linecolor=black,
    ]{fmoheadframe}

    \newmdenv[skipabove=0pt,
    skipbelow=0pt,
    innertopmargin=0pt,
    innerleftmargin=0pt,
    innerrightmargin=0pt,
    innerbottommargin=0pt,
    topline=true,
    bottomline=true,
    leftline=false,
    rightline=false,
    linewidth=\qqtFrontFootRuleWidth,
    linecolor=black,
    ]{fmofootframe}
    \fi

    %--------------------------------------------
    % SECTION
    %--------------------------------------------

    \titleformat{\section}{\fontsize{13pt}{10pt}\selectfont\bf}{\thesection\textbf{.}}{2pt}{}
    \titleformat{\subsection}{\fontsize{10pt}{10pt}\selectfont\bf}{\thesubsection}{4pt}{}
    \titleformat{\subsubsection}{\fontsize{10pt}{10pt}\selectfont\it}{\thesubsubsection}{4pt}{}

    %--------------------------------------------
    % BIBLIOGRAPHY
    %--------------------------------------------

    % Overfull box
    \emergencystretch=1em

    \iftoggle{qqtnatbib}
    {
    % NATBIB (DEPRECATED)
    \bibliographystyle{abbrv}
    \renewcommand{\bibfont}{\small}
    \renewcommand{\bibnumfmt}[1]{\texttt{#1}.}
    \setlength{\bibsep}{0pt plus 0.3ex} % Bibliography separation.

    \def\addbibresource#1{
    \filename@parse{#1}
    \AtEndDocument{
        \bibliography{\filename@base}
    }
    }
    }
    {
    % BIBLATEX
    \renewcommand{\bibfont}{\fontsizeEight\linespread{1.2}\selectfont}
    %\DeclareFieldFormat*{postnote}{#1}%
    \DeclareNameAlias{author}{last-first}
    \renewcommand*{\revsdnamepunct}{} % Remove comma

    % Redefine bib title format (biblatex doc p176)
    \DeclareFieldFormat*{booktitle}{#1}
    \DeclareFieldFormat*{eventtitle}{#1}
    \DeclareFieldFormat*{issuetitle}{#1}
    \DeclareFieldFormat*{journaltitle}{#1}
    \DeclareFieldFormat*{maintitle}{#1}
    \DeclareFieldFormat*{origtitle}{#1}
    \DeclareFieldFormat*{title}{#1}
    \DeclareFieldFormat*{number}{(#1)\addcolon}
    \DeclareFieldFormat*{date}{#1\addsemicolon}
    \DeclareFieldFormat*{volume}{#1}
    %\DeclareFieldFormat{labelnumberwidth}{\ttfamily\fontsizeEightFive{#1\!.}}
    \DeclareFieldFormat{labelnumberwidth}{\fontsizeEightFive{#1\!.}}
    \DeclareFieldFormat{url}{Available from\addcolon\space\url{#1}}
    \DeclareFieldFormat{doi}{doi\addcolon\space
        \ifhyperref
        {\href{https://doi.org/#1}{\nolinkurl{#1}}}
        {\nolinkurl{#1}}
    }
    \DeclareFieldFormat{eprint:pmid}{%
        PubMed PMID\addcolon\space
        \ifhyperref
            {\href{http://www.ncbi.nlm.nih.gov/pubmed/?term=#1}{\nolinkurl{#1}}}
            {\nolinkurl{#1}}
    }

    \DeclareFieldFormat{eprint:pmcid}{%
        PMCID\addcolon\space
        \ifhyperref
            {\href{http://www.ncbi.nlm.nih.gov/pmc/articles/#1}{\nolinkurl{#1}}}
            {\nolinkurl{#1}}
    }
    \DeclareFieldAlias{eprint:PMC}{eprint:pmcid}
    \DeclareFieldAlias{eprint:PMCID}{eprint:pmcid}
    \DeclareFieldAlias{eprint:pmc}{eprint:pmcid}
    \DeclareFieldAlias{pmcid}{eprint:pmcid}
    \DeclareFieldAlias{pmid}{eprint:pmid}

    \renewbibmacro*{doi+eprint+url}{%
    \iftoggle{bbx:eprint}
    {\usebibmacro{eprint}}
    {}%
    \newunit\newblock
    \iftoggle{bbx:url}
    {\usebibmacro{url+urldate}}
    {}
    \newunit\newblock
    \printfield{pmid}%
    \newunit\newblock
    \printfield{pmcid}%
    \newunit\newblock
    \iftoggle{bbx:doi}
    {\printfield{doi}}
    {}%
    }

    \renewbibmacro*{volume+number+eid}{%
    %\setunit*{\adddot}%
    %\setunit*{\addsemicolon}% 
    \printfield{volume}%
    %\setunit*{\addnbspace}%
    \printfield{number}%
    %\setunit{\addcomma\space}%
    \printfield{eid}
    }

    \renewbibmacro*{journal+issuetitle}{%
    \usebibmacro{journal}%
    \setunit*{\addspace}%
    \iffieldundef{series}
    {}
    {\newunit
        \printfield{series}%
    \setunit{\addspace}}%
    \usebibmacro{issue+date}%
    \setunit{\addcomma}%
    \usebibmacro{volume+number+eid}%
    \setunit{\addcomma}%
    \usebibmacro{issue}%
    \newunit
    }

    \renewbibmacro{in:}{}

    \DefineBibliographyStrings{english}{%
    page      = {\ifbibliography{}{\adddot}},
    pages     = {\ifbibliography{}{\adddot}},
    url       = {\ifbibliography{}}
    }

    \renewcommand*{\finalnamedelim}{\addcomma\addspace}
    \renewcommand{\bibopenparen}{\addcomma\addspace}
    \renewcommand{\bibcloseparen}{\addcomma\addspace}

    \setlength{\biblabelsep}{6pt} % Bibliography separation.
    \setlength\bibitemsep{1.5pt}
    \setlength\bibparsep{0pt}

    % Biblatex specific.
    \AtEndDocument%
    {
    \setlength\baselineskip{10pt}
    \printbibliography
    }

    \renewcommand\cite[1]{\supercite{#1}}
    \renewcommand\autocite[1]{\supercite{#1}}

    % Remove biblatex fields
    %\AtEveryBibitem{\clearfield{url}}
    }

    %--------------------------------------------------------------------------------
    % LOGO
    %--------------------------------------------------------------------------------

    \def\logoqqt{img/qquantsidelogo.png}

    % Not available on CTAN (ref:
    % https://github.com/zerotoc/pdfinlimg/blob/master/pdfinlimg.pl)
    %
    \newcommand{\pdfinlimg}[5]{
    \makebox[#1cm][l]{\special{pdf:literal direct
        q
        #3 0 0 #4 0 0 cm
        #1 0 0 #2 0 0 cm
        0.885 0 0 0.885 0 0 cm 
        BI
        /W #3
        /H #4
        /CS /RGB
        /BPC 8
        /F [ /AHx /Fl ]
        ID
        #5>
        EI
        Q
        }\vbox to #2cm{
    }}}

    %--------------------------------------------------------------------------------
    % qqt COMMANDS
    %--------------------------------------------------------------------------------

    \def\void{} % To exit recursive macro
    \newcounter{nauthors}
    \newcounter{naffiliations}
    \newcounter{nkeywords}
    \newcounter{tmpcount}
    \newcounter{maxrunningauthors}
    \newtoggle{authidx}

    % Initialize global counters
    \setcounter{naffiliations}{0}
    \setcounter{nauthors}{0}
    \setcounter{maxrunningauthors}{2}

    %--------------------------------------------------------------------------------
    % Add a new affiliation
    % args:   <id> - Affiliation identity (start at 1, then 2, ...)
    %       <name> - Affiliation name
    \def\qqtAddAffiliation#1#2
    {
    \stepcounter{naffiliations}
    \expandafter\def\csname qqt@affiliation\Alph{naffiliations}\endcsname{\textit{\({}^\textit{#1}\)#2}}
    }

    %--------------------------------------------------------------------------------
    % Add a new author and his affiliation.
    % args:           <id> - affiliation identity.
    %       <firname name> - Author's firstname space name.
    %
    \ExplSyntaxOn
    \def\qqtAddAuthor#1#2#3
    {
    \stepcounter{nauthors}
    \expandafter\edef\csname qqt@authLastname\Alph{nauthors}\endcsname{#3}
    \expandafter\edef\csname qqt@authFirstname\Alph{nauthors}\endcsname{#2}
    \expandafter\edef\csname qqt@authi\Alph{nauthors}\endcsname{#1}

    % We generate the firstname abbreviation using LaTeX3 regex package.
    % Note that multiple names must be separated by - or space, but spaces
    % should be escaped
    \tl_set:Nn \l_fname_tl {#2}
    \regex_replace_all:nnN {(-?\s*)(\w)\w+} {\2.} \l_fname_tl
    \expandafter\edef\csname qqt@authFirstnameAbr\Alph{nauthors}\endcsname{%
    \use:c {l_fname_tl}
    }
    }
    \ExplSyntaxOff

    %--------------------------------------------------------------------------------
    % Add a new author and his affiliation.
    % args:           <id> - affiliation identity.
    %       <firname name> - Author's firstname space name.
    %
    \def\qqtAddKeyword#1
    {
    \stepcounter{nkeywords}
    \expandafter\edef\csname qqt@keyword\Alph{nkeywords}\endcsname{#1}
    }

    %--------------------------------------------------------------------------------
    % qqtMakeAuthors: generate two list of authors from defined authors with and
    % without affiliation indices ( see qqtAddAuthor).
    % args: <start>   - Counter start
    %       <showidx> - Boolean to generate indice the index list
    % NB: (dev) Use recursion method
    \newcommand\qqtMakeAuthors[2]
    {%
    \settoggle{authidx}{#2}
    \setcounter{tmpcount}{#1}
    \ifnum#1>\value{nauthors}
    \expandafter\void % Exit
    \else
    \iftoggle{authidx}
    {% Add to author list with indices
    \edef\@qqtAuthorsIdx{%
        \unexpanded\expandafter{\@qqtAuthorsIdx}%
        \ifnum#1>1,\space\fi%
        \noexpand \csname qqt@authFirstname\Alph{tmpcount}\endcsname%
        \ifnum#1>0 \space\fi%
        \noexpand \csname qqt@authLastname\Alph{tmpcount}\endcsname%
        ${}^{\expandafter\csname qqt@authi\Alph{tmpcount}\endcsname}$\noindent
        }%
        \expandafter\qqtMakeAuthors\expandafter%
        {\number\numexpr#1+1\expandafter}{#2}
    }%
    {%
    % Add to author list
    \edef\@qqtAuthors{%
        \unexpanded\expandafter{\@qqtAuthors}%
        \ifnum#1>1,\space\fi%
        \noexpand \csname qqt@authFirstname\Alph{tmpcount}\endcsname
        \ifnum#1>0 \space\fi%
        \noexpand \csname qqt@authLastname\Alph{tmpcount}\endcsname
        }%
        \expandafter\qqtMakeAuthors\expandafter%
        {\number\numexpr#1+1}{#2}
    }%
    \fi%
    }

    %--------------------------------------------------------------------------------
    % qqtMakeRunningAuthors: generate two list of authors from defined authors with and
    % without affiliation indices ( see qqtAddAuthor).
    % args: <start>   - Counter start
    %       <showidx> - Boolean to generate indice the index list
    % NB: (dev) Use recursion method
    \newcommand\qqtMakeRunningAuthors[2]
    {%
    \settoggle{authidx}{#2}
    \setcounter{tmpcount}{#1}
    \def\maxrauth{
    \ifnum\value{nauthors}>\value{maxrunningauthors} 1
    \else \value{maxrunningauthors}
    \fi
    }
    \ifnum#1>\maxrauth
    \iftoggle{authidx}
    { % With indices
    \edef\@qqtRunningAuthorsIdx{%
        \unexpanded\expandafter{\@qqtRunningAuthorsIdx}%
        \ifnum\value{nauthors}>2 \space et al.\fi
        }
    }
    { % No indices
    \edef\@qqtRunningAuthors{%
        \unexpanded\expandafter{\@qqtRunningAuthors}%
        \ifnum\value{nauthors}>2 \space et al.\fi
        }
    }
    \expandafter\void % Exit
    \else
    \iftoggle{authidx}
    {% Add to author list with indices
    \edef\@qqtRunningAuthorsIdx{%
        \unexpanded\expandafter{\@qqtRunningAuthorsIdx}%
        \ifnum#1>1 \ifnum#1=\value{nauthors}-1 \space and\space\fi \fi%
        \noexpand \csname qqt@authFirstnameAbr\Alph{tmpcount}\endcsname%
        \ifnum#1>0 \space \fi%
        \noexpand \csname qqt@authLastname\Alph{tmpcount}\endcsname%
        ${}^{\noindent\expandafter\csname
        qqt@authi\Alph{tmpcount}\endcsname}$\noindent
        }%
        \expandafter\qqtMakeRunningAuthors\expandafter%
        {\number\numexpr#1+1\expandafter}{#2}
    }%
    {%
    % Add to author list
    \edef\@qqtRunningAuthors{%
        \unexpanded\expandafter{\@qqtRunningAuthors}%
        \ifnum#1>1 \ifnum#1=\value{nauthors}-1 \space and\space\fi \fi%
        \noexpand \csname qqt@authFirstnameAbr\Alph{tmpcount}\endcsname%
        \ifnum#1>0 \space\fi%
        \noexpand \csname qqt@authLastname\Alph{tmpcount}\endcsname%
        }%
        \expandafter\qqtMakeRunningAuthors\expandafter%
        {\number\numexpr#1+1}{#2}
    }%
    \fi%
    }

    %--------------------------------------------------------------------------------
    % qqtMakeAffiliations
    % args: <start>   - Counter start
    \newcommand\qqtMakeAffiliations[1]
    {%
    \setcounter{tmpcount}{#1}
    \ifnum#1>\value{naffiliations}
    \expandafter\void % Exit
    \else
    \edef\@qqtAffiliations{%
        \unexpanded\expandafter{\@qqtAffiliations}%
        \ifnum#1>1,\space\fi%
        \noexpand \csname qqt@affiliation\Alph{tmpcount}\endcsname
        }%
        \expandafter\qqtMakeAffiliations\expandafter%
        {\number\numexpr#1+1\expandafter}
    \fi%
    }

    %--------------------------------------------------------------------------------
    % qqtMakeKeywords
    % args: <start>   - Counter start
    \newcommand\qqtMakeKeywords[1]
    {%
    \setcounter{tmpcount}{#1}
    \ifnum#1>\value{nkeywords}
    \expandafter\void % Exit
    \else
    \edef\@qqtKeywords{%
        \unexpanded\expandafter{\@qqtKeywords}%
        \ifnum#1>1,\space\fi%
        \noexpand \csname qqt@keyword\Alph{tmpcount}\endcsname
        }%
        \expandafter\qqtMakeKeywords\expandafter%
        {\number\numexpr#1+1\expandafter}
    \fi%
    }

    %--------------------------------------------------------------------------------
    % qqtMakeTitle: generate the title.
    \newcommand\qqtMakeTitle
    {
    % TITLE
    \bgroup
    \linespread{1.2}
    \noindent
    \fontsizetitle
    \begin{flushleft}
    \textbf{\@qqtTitle}
    \end{flushleft}
    \egroup
    \vspace{\qqtAuthorsSep}
    % AUTHORS(S)
    \noindent\@qqtAuthorsIdx
    \vspace{\qqtAffiliationsSep}
    \newline
    % AFFILIATION
    \@qqtAffiliations
    }

    %--------------------------------------------------------------------------------
    % qqtMakeAbstract: insert abstract in the text. The abstract is build from
    % several variables to be filled by users.
    \newcommand\qqtMakeAbstract
    {
    \section*{Abstract}

    \noindent\textit{Purpose}: \@qqtAbstractPurpose
    \newline
    \noindent\textit{Methods}: \@qqtAbstractMethods
    \newline
    \noindent\textit{Results}: \@qqtAbstractResults
    \newline
    \noindent\textit{Conclusion}: \@qqtAbstractConclusion
    }

    %--------------------------------------------------------------------------------
    % qqtshowframe: Show first page geometry frame similarly to geometry package,
    % or display the first argument (NB: horizontal rule in frontpage).
    \newcommand\qqtshowframe[1]
    {
    \iftoggle{qqtshowframe}
    {\textcolor{red}{\rule{\textwidth}{1pt}}}
    {#1}
    }

    %--------------------------------------------------------------------------------
    \newcommand\qqtMakeLogo
    {
    \@ifundefined{logoHEX}
    {
    \@ifundefined{logoqqt}
    {}
    {\includegraphics[width=1.5cm]{\logoqqt}}
    }
    {
    % Embed base64 image 0.8cm*16cm=0.05cm
    \vspace*{\qqtLogoVShift}
    \resizebox{.06cm}{!}{
        \pdfinlimg{16}{16}{456}{458}{\logoHEX}
    }
    \vspace*{-\qqtLogoVShift}
    }
    }

    %--------------------------------------------------------------------------------
    % qqtMakeFrontpageHeadter: insert the header in the first page at the top.
    % NB: top margin has to be calculated.
    \newcommand\qqtMakeFrontpageHeader
    {
    \ifhttex
    % No header
    \else
    \bgroup
    \textblockorigin{0mm}{0cm}
    \setlength{\parindent}{0pt}
        % Header absolute positioning in the document top margin.
    \begin{textblock*}{\textwidth}[0,0](\qqtLeft,\qqtFrontTop)
        \begin{fmodebugframe}
        \begin{fmoheadframe}
            \begin{minipage}[t][\qqtFrontHeadHeight][t]{\textwidth}
            \vfil
            \begin{tabular}[t]{@{}p{0.2\textwidth}@{}>{\hfill}p{0.8\textwidth}@{}}
                % LEFT HEADER
                \qqtMakeLogo
                &
                % RIGHT HEADER
                \textcolor{rightheadercol}
                {
                \bgroup
                \def\arraystretch{0.8}
                \begin{tabular}{@{}l@{}}
                    \fontsizeSeven
                    \textcopyright\hspace{1pt} \@qqtJournalName\;\@qqtJournalDate
                    \
                    \fontsizeEight
                    \textit{\@qqtJournalTitle}
                \end{tabular}
                \egroup
                }
            \end{tabular}
            \end{minipage}
        \end{fmoheadframe}
        \end{fmodebugframe}
    \end{textblock*}
    \egroup
    \fi
    }

    %--------------------------------------------------------------------------------
    % qqtMakeFrontpageFooter: insert the footer at the bottom of the first page
    \newcommand\qqtMakeFrontpageFooter
    {
    \ifhttex
        % No Footer
    \else
    \bgroup
        % FOOTER
    \textblockorigin{0mm}{0mm}
    \setlength{\parindent}{0pt}
        % Footer absolute positioning in the document bottom margin.
    \begin{textblock*}{\textwidth}[0,0](\qqtLeft,\qqtFrontFootTop)
    \begin{fmodebugframe}
        \begin{fmofootframe}
        \begin{minipage}[t][\qqtFrontFootHeight][t]{\textwidth}
            \vfil
            \begin{tabular}[t]{@{}p{\textwidth}@{}}
            \small\textbf{Correspondence}: \@qqtCorrespondence{}.
            \
            \small E-mail: \@qqtCorrespondenceEmail
            \end{tabular}
            \vfil
        \end{minipage}
        \end{fmofootframe}
    \end{fmodebugframe}
    \end{textblock*}
    \egroup
    \fi
    }

    %--------------------------------------------------------------------------------
    % qqtMakeFrontpage: generate the front page from previous defined commands.
    \newcommand\qqtMakeFrontpage
    {
    % Comment these 2 lines to hide the header and the footer.
    \qqtMakeFrontpageHeader
    \qqtMakeFrontpageFooter

    % Fix space when this command is called after begin document.
    % Check using geometry showframe option that remove
    \vspace*{-18pt}
    % Comment this line to debug top margin with previous space.
    \vspace{\qqtFrontTextTop}

    \thispagestyle{frontpage}

    \enlargethispage{\qqtFrontTextReduce}
    \qqtMakeTitle
    \null
    \vspace{\qqtAbstractSep}
    \qqtMakeAbstract
    \vspace{\qqtKeywordsSep}

    %\qqtMakeKeywords
    \noindent\textit{Keywords}: \@qqtKeywords
    % Add TOC tex4ht or by option
    \ifhttex
    \tableofcontents
    \renewcommand\tableofcontents{}
    \fi
    }

    %--------------------------------------------------------------------------------
    % REMOVE COMMANDS
    %--------------------------------------------------------------------------------
    %\renewcommand\maketitle{}
    \renewcommand\title[1]{}
    \renewcommand\@title{}
    \renewcommand\footnote{}

    %-------------------------------------------------------------------------------
    % INITIALIZATION
    %-------------------------------------------------------------------------------

    \AtBeginDocument
    {
    % CHECK
    \ifnum\value{nauthors}=0
    \qqtAffiliations{\qqt@msg@Affiliations}
    \fi
    \ifnum\value{nauthors}=0
    \qqtAuthors{\qqt@msg@Authors}
    \fi
    \ifnum\value{nkeywords}=0
    \qqtKeywords{\qqt@msg@Keywords}
    \fi

    % Do generate authors lists (\@qqtAuthorIdx, \@qqtAuthor).
    \qqtMakeAuthors{0}{true}
    \qqtMakeAuthors{0}{false}
    % Do generate authors lists (\@qqtRunningAuthorIdx, \@qqtRunningAuthor).
    \qqtMakeRunningAuthors{0}{true}
    \qqtMakeRunningAuthors{0}{false}

    % Do generate a list of affiliation (\@qqtAffiliations).
    \qqtMakeAffiliations{0}

    % Do generate a list of keywords (\@qqtAffiliations).
    \qqtMakeKeywords{0} %

    % PDF Metadata
    \hypersetup
    {
    pdftitle={\@qqtTitle},
    pdfsubject={\@qqtTitle},
    pdfauthor={\@qqtAuthors},
    pdfkeywords={\@qqtKeywords},
    }
    }

    %%% Local Variables:
    %%% coding: utf-8
    %%% mode: latex
    %%% End:
    % vim:set ft=tex sw=2 tw=80: