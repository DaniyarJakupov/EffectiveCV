\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{effectivecv}[2018/07/11 Effective CV]

% Options
\LoadClassWithOptions{article}

% Document configuration
\renewcommand{\familydefault}{\sfdefault}
\renewcommand*\sfdefault{lmss} % Use Latin Modern Sans Serif

\RequirePackage[margin=5mm]{geometry}
\setlength\parindent{0pt} % Deactivate content indent

\RequirePackage{enumitem}
\setlist[itemize]{noitemsep, topsep=0mm, leftmargin=7mm}

\RequirePackage[hidelinks]{hyperref}
\urlstyle{same} % URL in sans-serif

\RequirePackage[dvipsnames]{xcolor}
\newcommand{\cvcolors}[4]{%
  \colorlet{cvcolorfirst}{#1}%
  \colorlet{cvcolorsecond}{#2}%
  \colorlet{cvcolorthird}{#3}%
}
\cvcolors{RoyalBlue}{black}{darkgray} % Default colors

\RequirePackage{graphicx}
\RequirePackage{fullwidth}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{fontawesome}

% Lengths
\newcommand{\setnewlength}[2]{%
  \newlength{#1}%
  \setlength{#1}{#2}%
}
\setnewlength{\cvcontentwidth}{\textwidth}
\setnewlength{\cvmaincolumnlength}{0.73\textwidth}
\setnewlength{\cvsidecolumnlength}{0.24\textwidth}

% Utilities
\RequirePackage{ifthen}
\newcommand{\ifempty}[3]{%
  \ifthenelse{\equal{#1}{}}{#2}{#3}%
}

% Title
\newcommand{\address}[1]{\renewcommand\@address{#1}}
\newcommand{\@address}{}

\newcommand{\email}[1]{\renewcommand\@email{#1}}
\newcommand{\@email}{}

\newcommand{\phone}[1]{\renewcommand\@phone{#1}}
\newcommand{\@phone}{}

\newcommand{\linkedin}[1]{\renewcommand\@linkedin{#1}}
\newcommand{\@linkedin}{}

\newcommand{\github}[1]{\renewcommand\@github{#1}}
\newcommand{\@github}{}

\newcommand{\portrait}[1]{\renewcommand\@portrait{#1}}
\newcommand{\@portrait}{}

\newcommand{\@makecvtitlecontent}{%
  \multirow{3}{*}[0.75em]{\ifempty{\@portrait}{}{\includegraphics[height=6.5em]{\@portrait}}} & \textbf{\huge\@author} \\[.25em]
  & \textcolor{cvcolorfirst}{\Large\@title} \\[.75em]
  & \textcolor{cvcolorthird}{\small\@address} \\
  & \textcolor{cvcolorthird}{\small%
      \href{mailto:\@email}{\faEnvelopeO~\@email}%
      \ifempty{\@phone}{}{\ | \faPhone~\@phone}%
      \ifempty{\@linkedin}{}{\ | \href{https://linkedin.com/in/\@linkedin}{\faLinkedin~\@linkedin}}%
      \ifempty{\@github}{}{\ | \href{https://github.com/\@github}{\faGithub~\@github}}%
    }%
}

\newcommand{\makecvtitle}{%
  \begin{minipage}[t]{\cvcontentwidth}%
    \ifempty{\@portrait}{%
      \begin{tabularx}{\cvcontentwidth}{@{}l@{}X@{}}%
        \@makecvtitlecontent
      \end{tabularx}%
    }{%
      \begin{tabularx}{\cvcontentwidth}{@{}l X@{}}%
        \@makecvtitlecontent
      \end{tabularx}%
    }%
  \end{minipage}%
  \par\medskip%
}

% CV commands
\newcommand{\cvcontent}[3][onecolumn]{%
  \ifthenelse{\equal{#1}{leftsidecolumn}}{%
    \begin{minipage}[t]{\cvsidecolumnlength}#2\end{minipage}%
    \hfill
    \begin{minipage}[t]{\cvmaincolumnlength}#3\end{minipage}%
  }{%
    \ifthenelse{\equal{#1}{rightsidecolumn}}{%
      \begin{minipage}[t]{\cvmaincolumnlength}#2\end{minipage}%
      \hfill
      \begin{minipage}[t]{\cvsidecolumnlength}#3\end{minipage}%
    }{% Default is onecolumn
      \begin{minipage}[t]{\cvcontentwidth}#2\end{minipage}%
    }%
  }%
}

\renewcommand{\section}[1]{%
  \par\smallskip%
  \textcolor{cvcolorfirst}{\textbf{\large #1}}%
  \par\vspace*{-0.7\baselineskip}%
  \textcolor{cvcolorfirst}{\rule{\textwidth}{0.2mm}}%
  \par%
}

\newcommand{\cvitem}[2]{
  \ifempty{#1}{}{\textcolor{cvcolorsecond}{\textbf{#1}}\\}%
  #2%
  \par\medskip%
}

\newcommand{\cventry}[6]{
  \par\smallskip%
  \begin{tabularx}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}%
    \textcolor{cvcolorsecond}{\textbf{#1}} & \textcolor{cvcolorsecond}{\small #4 -- #5} \\
    \textcolor{cvcolorthird}{\small #2} & \textcolor{cvcolorthird}{\small #3}
  \end{tabularx}%
  \par\addvspace{0.4mm}%
  #6%
  \par\medskip%
}

\endinput