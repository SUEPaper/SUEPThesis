%% Copyright (C) 2022-2023 by Haiwen Zhang
%% 
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{math201}
[2023/02/08 v0.1 Shanghai University of Electric Power Graduation Thesis LaTeX Template]

\RequirePackage{ifxetex,ifluatex,ifthen}
  \ifthenelse{\boolean{xetex}\OR\boolean{luatex}}{}{
    \ClassError{suepthesis}{You Should Use XeLaTeX or LuaLaTeX To Compile.}}

\newcommand\version{0.1.0}
\newcommand\suepthesis{\textup{\sffamily suepthesis}}
\newcommand\SUEPThesis{\textup{\sffamily SUEPThesis}}

% 包依赖
\LoadClass[a4paper,UTF8,titlepage,oneside]{ctexbook}

\RequirePackage{graphicx}

% ==============================================================================
% 页面边距
% ==============================================================================
\RequirePackage{geometry}
  \geometry{a4paper,top=2.54cm,bottom=2.54cm,left=3.17cm,right=3.17cm}

\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage[most,minted]{tcolorbox}
\RequirePackage{minted}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{tabularray,multicol,tasks}
\RequirePackage{multirow}
\RequirePackage{listofitems}
\RequirePackage{expl3}
\RequirePackage{ulem}

% ==============================================================================
% Options and Declarations
% ==============================================================================
\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
% ------------------------------------------------------------------------------
%   Define \suepsetup command
%
%   Following key-value setup mechanism is adapted from `thuthesis'.
%   thuthesis (https://github.com/xueruini/thuthesis) is licensed under the
%   conditions of the LaTeX Project Public License, either version 1.3. 
% ------------------------------------------------------------------------------
\newcommand\suepsetup{%
  \kvsetkeys{suep}%
}
\newcommand\suep@define@key[1]{%
  \kvsetkeys{suep@key}{#1}%
}
\kv@set@family@handler{suep@key}{%
  \@namedef{suep@#1@@name}{#1}%
  \def\suep@@default{}%
  \def\suep@@choices{}%
  \kv@define@key{suep@value}{name}{%
    \@namedef{suep@#1@@name}{##1}%
  }%
  \kv@define@key{suep@value}{code}{%
    \@namedef{suep@#1@@code}{##1}%
  }%
  \@namedef{suep@#1@@check}{}%
  \@namedef{suep@#1@@code}{}%
  \@namedef{suep@#1@@hook}{%
    \expandafter\ifx\csname\@currname.\@currext-h@@k\endcsname\relax
      \@nameuse{suep@#1@@code}%
    \else
      \AtEndOfClass{%
        \@nameuse{suep@#1@@code}%
      }%
    \fi
  }%
  \kv@define@key{suep@value}{choices}{%
    \def\suep@@choices{##1}%
    \@namedef{suep@#1@@reset}{}%
    \@namedef{suep@#1@@check}{%
      \@ifundefined{%
        ifsuep@\@nameuse{suep@#1@@name}@\@nameuse{suep@\@nameuse{suep@#1@@name}}%
      }{%
        \suep@error{Invalid value "#1 = \@nameuse{suep@\@nameuse{suep@#1@@name}}"}%
      }%
      \@nameuse{suep@#1@@reset}%
      \@nameuse{suep@\@nameuse{suep@#1@@name}@\@nameuse{suep@\@nameuse{suep@#1@@name}}true}%
    }%
  }%
  \kv@define@key{suep@value}{default}{%
    \def\suep@@default{##1}%
  }%
  \kvsetkeys{suep@value}{#2}%
  \@namedef{suep@\@nameuse{suep@#1@@name}}{}%
  \kv@set@family@handler{suep@choice}{%
    \ifx\suep@@default\@empty
      \def\suep@@default{##1}%
    \fi
    \expandafter\newif\csname ifsuep@\@nameuse{suep@#1@@name}@##1\endcsname
    \expandafter\g@addto@macro\csname suep@#1@@reset\endcsname{%
      \@nameuse{suep@\@nameuse{suep@#1@@name}@##1false}%
    }%
  }%
  \kvsetkeys@expandafter{suep@choice}{\suep@@choices}%
  \expandafter\let\csname suep@\@nameuse{suep@#1@@name}\endcsname\suep@@default
  \expandafter\ifx\csname suep@\@nameuse{suep@#1@@name}\endcsname\@empty\else
    \@nameuse{suep@#1@@check}%
    \@nameuse{suep@#1@@hook}%
  \fi
  \kv@define@key{suep}{#1}{%
    \@namedef{suep@\@nameuse{suep@#1@@name}}{##1}%
    \@nameuse{suep@#1@@check}%
    \@nameuse{suep@#1@@hook}%
  }%
}

\suep@define@key{
  title = {
    default = {标题},
  },
  sub-title = {
    default = {},
    name = sub@title,
  },
  title* = {
    name = title@en,
  },
  student = {
    default = {某同学}
  },
  student-id = {
    default = {2023****},
    name    = student@id,
  },
  supervisor = {
    default = {某老师},
  },
  institution = {
    default = {数理学院数学系},
  },
  discipline = {
    default = {信息与计算科学专业 2018 级},
  },
  date = {
    default = {2023 年 2 月 8 日},
  },
  keywords,
  keywords* = {
    name = keywords@en,
  },
}

% 设置图片文件夹路径
\graphicspath{{figures/}{figure/}{pictures/}%
{picture/}{pic/}{pics/}{image/}{images/}}


% 英文默认为Times New Roman
\setmainfont[
    Path=fonts/times/,
    Extension = .ttf,
    UprightFont = * ,
    BoldFont = *bd ,
    ItalicFont = *i ,
    BoldItalicFont = *bi
]{times} 


%% 字体汉化设置

\zihao{-4}
\linespread{1.25}

% 字号设置
% \newcommand{\初号}{\zihao {0}}
% \newcommand{\小初}{\zihao{-0}}
% \newcommand{\一号}{\zihao {1}}
% \newcommand{\小一}{\zihao{-1}}
% \newcommand{\二号}{\zihao {2}}
% \newcommand{\小二}{\zihao{-2}}
% \newcommand{\三号}{\zihao {3}}
% \newcommand{\小三}{\zihao{-3}}
% \newcommand{\四号}{\zihao {4}}
% \newcommand{\小四}{\zihao{-4}}
% \newcommand{\五号}{\zihao {5}}
% \newcommand{\小五}{\zihao{-5}}
% \newcommand{\六号}{\zihao {6}}
% \newcommand{\小六}{\zihao{-6}}
% \newcommand{\七号}{\zihao {7}}
% \newcommand{\八号}{\zihao {8}}

% 伪粗体等级
\xeCJKsetup{EmboldenFactor=3} 
% 宋体
\renewcommand{\songti}{\CJKfontspec[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold]{simsun.ttc}}
% 中文默认为宋体,小四在\documentclass处设置
\setCJKmainfont[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold]{simsun.ttc} 
% \newcommand{\宋体}{\songti}

% 黑体
\renewcommand{\heiti}{\CJKfontspec[Path=fonts/,AutoFakeBold]{simhei.ttf}}
\setCJKsansfont[Path=fonts/]{simhei.ttf}
% \newcommand{\黑体}{\heiti}

% 华文仿宋
\newcommand{\STfangsong}{\CJKfontspec[Path=fonts/,AutoFakeBold={2.2}]{STfangsong.ttf}}
% \newcommand{\仿宋}{\fangsong}

% 楷体
\newcommand{\kaiti}{\CJKfontspec[Path=fonts/,AutoFakeBold={2.0}]{simkai.ttf}}

% 其他
% \newcommand{\隶书}{\lishu}
% \newcommand{\幼圆}{\youyuan}
% \newcommand{\雅黑}{\yahei}
% \newcommand{\苹方}{\pingfang}

% 字体效果汉化设置
% \newcommand{\粗体}{\bfseries}
% \newcommand{\斜体}{\itshape}


% ==============================================================================
% 设置标题
% ==============================================================================

\def\sht@toc@chapter@fmt{\zihao{4}\heiti}
\def\sht@toc@section@fmt{\zihao{-4}\heiti}

% 一级标题格式：第*章  后空一格（全角）黑体　小三号字　居中 1.5倍行距 段前0行 段后0.5行
\ctexset{
  chapter = {
    format = \heiti\zihao{-3}\linespread{1.5}\centering,
    name = {第 ,章},
    aftername = \hspace{\ccwd},
    beforeskip = {0pt},
    afterskip = {0.5ex},
  }
}
% 二级标题格式： 1.1（半角）  后空一格(全角) 黑体四号字 居左 1.5倍行距 段前0.5行 段后0行
\ctexset{
  section = {
    format = \heiti\zihao{4}\linespread{1.5}\raggedright,
    aftername = \hspace{\ccwd},
    beforeskip = {0.5ex},
    afterskip = {0pt},
  }
}

% 三级标题格式： 1.1.1（半角）前空两格、后空一格（全角） 黑体小四号字 居左 1.5倍行距 段前0.5行 段后0行
\ctexset {
  subsection = {
    format = \heiti\zihao{-4}\linespread{1.5},
    indent = {2\ccwd},
    aftername = \hspace{\ccwd},
    beforeskip = {0.5ex},
    afterskip = {0pt},
  },
}


% 设置一级标题


% 设置二级标题


% 设置三级标题


% ------------------------------------------------------------------------------
%   Headers and footers
% ------------------------------------------------------------------------------
% \def\sht@flat@title{\renewcommand\\{\space} \sht@title}
% \def\sht@flat@title@upper@en{%
%   \renewcommand\\{\space}%
%   \MakeUppercase{\sht@title@en}%
% }

% \pagestyle{fancy}
% \fancypagestyle{Plain}{}
% \fancypagestyle{RomanNumbered}{
%   \fancyhf{}
%   \pagenumbering{Roman}
%   \fancyhead[OC]{\footnotesize\nouppercase\leftmark}
%   \fancyhead[EC]{\footnotesize\nouppercase\sht@flat@title}
%   \fancyfoot[C]{\footnotesize\thepage}
%   \renewcommand{\headrulewidth}{0.8pt}
%   \renewcommand{\footrulewidth}{0pt}
% }
% \fancypagestyle{LRNumbered}{
%   \fancyhf{}
%   \fancyhead[OC]{\footnotesize\nouppercase\leftmark}
%   \fancyhead[EC]{\footnotesize\nouppercase\sht@flat@title}
%   \fancyfoot[OR]{\footnotesize\thepage}
%   \fancyfoot[EL]{\footnotesize\thepage}
%   \renewcommand{\headrulewidth}{0.8pt}
%   \renewcommand{\footrulewidth}{0pt}
% }
% \fancypagestyle{LRNumberedAppendix}{
%   \fancyhf{}
%   \fancyhead[OC]{\footnotesize 附\hspace*{1\ccwd}录}
%   \fancyhead[EC]{\footnotesize\nouppercase\sht@flat@title}
%   \fancyfoot[OR]{\footnotesize\thepage}
%   \fancyfoot[EL]{\footnotesize\thepage}
%   \renewcommand{\headrulewidth}{0.8pt}
%   \renewcommand{\footrulewidth}{0pt}
% }

% \fancypagestyle{MNNumberedWithLogo}{
%   \fancyhf{}
%   \fancyhead[L]{\sht@head@logo}
%   \fancyhead[R]{\zihao{-5}\sffamily\sht@flat@title}
%   \fancyfoot[C]{%
%     \footnotesize%
%     第~\thepage~页\hspace*{1\ccwd}共~\pageref*{LastPage}~页%
%   }
%   \renewcommand{\headrulewidth}{0.8pt}
%   \renewcommand{\footrulewidth}{0pt}
% }
% \providecommand{\frontmatter}{}
% \LetLtxMacro{\TmpFrontmatter}{\frontmatter}
% \renewcommand{\frontmatter}{%
%   \TmpFrontmatter%
%   \ifsht@undergraduate%
%     \pagestyle{RomanNumberedWithLogo}%
%   \else%
%     \pagestyle{RomanNumbered}%
%   \fi%
% }
% \providecommand{\mainmatter}{}
% \LetLtxMacro{\TmpMainmatter}{\mainmatter}
% \renewcommand{\mainmatter}{%
%   \TmpMainmatter%
%   \renewcommand{\chaptermark}[1]{%
%     \markboth{第~\thechapter~章\hspace{1\ccwd}##1}{}%
%   }%
%   \ifsht@undergraduate%
%     \pagestyle{MNNumberedWithLogo}%
%   \else%
%     \pagestyle{LRNumbered}%
%   \fi%
% }

% 页眉
\pagestyle{fancy}
\chead{\songti\zihao{-5}\suep@title \suep@sub@title}
\lhead{}

% 页脚
\cfoot{\zihao{-5}-\ \thepage\ -}


\def\ubox@right@shift{0.5\ccwd}
\def\cover@tab@entry@width{200pt}
\def\cover@tab@last@entry@width{\cover@tab@entry@width - 2\ccwd - 0.5\ccwd}
\def\cover@tab@uline@thick{0.4pt}

\def\cover@tab@small@width{50pt}

\ProvideDocumentCommand{\suep@cover@uline}{%
    O{\cover@tab@uline@thick} %
    O{\ubox@right@shift} %
    m}{%
  \def\ULthickness{#1}%
  \setlength{\ULdepth}{0.2em}%
  \hspace*{#2}%
  \uline{#3}%
}
\ProvideDocumentCommand{\suep@cover@bigbox}{%
    O{\cover@tab@entry@width} %
    m}{%
  \makebox[#1][c]{ #2 }%
}

\ProvideDocumentCommand{\suep@cover@smallbox}{%
    O{79pt} %
    m}{%
  \makebox[#1][c]{ #2 }%
}


\newcommand{\makecover}{
    \newgeometry{%
        top=3.57cm,bottom=2.54cm,
        left=3.17cm,right=3.17cm
    }
    \thispagestyle{empty}
    \begin{center}
    {
        \kaiti\zihao{0}\bfseries 
        上海电力大学
    }
    \vskip 50pt
    {
        \STfangsong\zihao{-0}\bfseries 
        本科毕业设计（论文）
    }
    \vskip 60pt
    \includegraphics[width=4.82cm, height=4.82cm]{logo}
    \vskip 40pt

    {
        \songti
        \zihao{4}
        % 调整列距
        \def\tabcolsep{0.5pt}
        % 调整行距
        \def\arraystretch{1.4}
        \begin{tabular}{rcrc}
            题 \hspace{20pt} 目：& \multicolumn{3}{c}{
                \suep@cover@uline{\suep@cover@bigbox{\suep@title}}
            }  \\

            & \multicolumn{3}{c}{
                \suep@cover@uline{\suep@cover@bigbox{\suep@sub@title}}
            }   \\

            院 \hspace{20pt} 系：& \multicolumn{3}{c}{
                \suep@cover@uline{\suep@cover@bigbox{\suep@institution}} 
            } \\

            专业年级：& \multicolumn{3}{c}{
                \suep@cover@uline{\suep@cover@bigbox{\suep@discipline}} 
            } \\

            学生姓名：& \suep@cover@uline{\suep@cover@smallbox{\suep@student}}  
            & 学号： &  \suep@cover@uline{\suep@cover@smallbox{\suep@student@id}}  \\

            指导老师：& \multicolumn{3}{c}{
                \suep@cover@uline{\suep@cover@bigbox{\suep@supervisor}}  
            } \\
        \end{tabular} 

        \vskip 30pt
        \suep@date
    }
\end{center}
}


% 原创性声明 
\newcommand{\makepromise}{
    \newgeometry{%
        top=3.57cm,bottom=2.54cm,
        left=3.17cm,right=3.17cm
    }
    \linespread{1.5}
    \thispagestyle{empty}
    \vskip 4.94mm
    \begin{center}
        \heiti\zihao{-2}
        上海电力大学 \\
        本科毕业设计（论文）原创性声明
    \end{center}
    \vskip 6.35mm

    \songti\zihao{4}
    \linespread{2}
    本人郑重申明：本人所呈交的毕业论文，是在指导老师的指导下独立进行研究所取得的成果。
    论文中凡引用他人已经发布或未发表的成果、数据、观点等，均已明确注明出处。
    论文中除已经注明引用的内容外，不包含任何其他个人或集体已经发表或撰写过的研究成果。
    对本文的研究成果做出重要贡献的个人和集体，均已在论文中以明确的方式标明。

    本声明的法律责任由本人承担。

    \vspace*{10ex}

    {\hfill{}论文作者签名：\hspace*{8em}日期：\hspace*{5em}}
    \clearpage
}

% 使用授权声明
\newcommand{\makeauthorize}{
    \newgeometry{%
        top=3.57cm,bottom=2.54cm,
        left=3.17cm,right=3.17cm
    }
    \linespread{1.5}
    \thispagestyle{empty}
    \vskip 4.94mm
    \begin{center}
        \heiti\zihao{-2}
        上海电力大学 \\
        本科毕业设计（论文）使用授权声明
    \end{center}
    \vskip 6.35mm

    \songti\zihao{4}
    \linespread{2}
    本人在指导老师的指导下所完成的论文及相关的资料，知识产权归属上海电力大学。
    本人完全了解上海电力大学有关保存、使用毕业论文的规定，同意学校保存或向国家有关部门或机构送交论文的纸质版或电子版，允许论文被查阅或借阅。
    本人授权上海电力大学可以将本毕业论文的全部或部分内容编入有关数据库进行检索，可以采用任何复制手段保存或编汇本毕业论文。
    如果发表相关成果，一定征得指导教师同意，且第一署名单位为上海电力大学。本人毕业后使用毕业论文或与该论文直接相关的学术论文或成果时，第一署名单位仍然为上海电力大学。

    \vspace*{10ex}

    {\hfill{}论文作者签名：\hspace*{8em}日期：\hspace*{5em}}

    \vspace*{5ex}

    {\hfill{}指导老师签名：\hspace*{8em}日期：\hspace*{5em}}

    \clearpage
}

% ------------------------------------------------------------------------------
%   Abstract
% ------------------------------------------------------------------------------

\newenvironment{abstract}{
  \vspace*{\baselineskip}
  \begin{center}
    {\heiti\zihao{3}\bfseries 摘\hspace{0.5\ccwd}要}
  \end{center}

  \songti\zihao{-4}
}{
  \vspace*{\baselineskip}
  \par\noindent{\zihao{-4} \heiti \bfseries 关键词：} \suep@keywords
  \vfill
  \newpage
}

\newenvironment{abstract*}{
  \vspace*{\baselineskip}
  \begin{center}
    {\zihao{-2}\bfseries \suep@title@en} \\
    {\zihao{-3}\bfseries Abstract}
  \end{center}

  \zihao{-4}
}{
  \vspace*{\baselineskip}
  \par\noindent{\zihao{4} \bfseries Key Words: \quad} \suep@keywords@en
  \vfill
  \newpage
}
