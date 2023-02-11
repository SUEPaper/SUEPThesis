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
\ProvidesClass{suepthesis}
[2023/02/08 v0.1 Shanghai University of Electric Power Graduation Thesis LaTeX Template]

\newcommand\suep@error[1]{%
  \ClassError{suepthesis}{#1}{}%
}
\newcommand\suep@warning[1]{%
  \ClassWarning{suepthesis}{#1}%
}
\newcommand\suep@patch@error[1]{%
  \suep@error{Failed to patch command \protect#1}%
}

\RequirePackage{iftex}
\ifXeTeX\else
  \ifLuaTeX\else
    \suep@error{XeLaTeX or LuaLaTeX is required to compile this document}
  \fi
\fi

\hyphenation{SUEP-Thesis}
\newcommand\suepthesis{\textup{\sffamily suepthesis}}
\newcommand\SUEPThesis{\textup{\sffamily SUEPThesis}}
\newcommand\version{0.1.0}

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
    default = {\today},
  },
  keywords,
  keywords* = {
    name = keywords@en,
  },
}



% 包依赖
\LoadClass[  
  UTF8,
  a4paper,
  zihao = -4,
  twoside, 
  openany, 
  % scheme = plain
]{ctexbook}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage[most,minted]{tcolorbox}
\RequirePackage{minted}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{tabularray}
\RequirePackage{multirow}
\RequirePackage{listofitems}
\RequirePackage{expl3}
\RequirePackage{ulem}
\RequirePackage{titletoc}


% ==============================================================================
% 页面边距
% ==============================================================================
\geometry{
  top=2.54cm,
  bottom=2.54cm,
  left=3.17cm,
  right=3.17cm,
  % headheight = 1.9cm,
  % headsep    = 1.9cm,
  % footskip   = 1.45cm,
}

% 设置图片文件夹路径
\graphicspath{{figures/}{figure/}{pictures/}%
{picture/}{pic/}{pics/}{image/}{images/}}

% ==============================================================================
% 字体设置
% ==============================================================================

% 英文默认为Times New Roman
\setmainfont{Times New Roman}
% \setmainfont[
%     Path=fonts/times/,
%     Extension = .ttf,
%     UprightFont = * ,
%     BoldFont = *bd ,
%     ItalicFont = *i ,
%     BoldItalicFont = *bi
% ]{times} 

% 伪粗体等级
% \xeCJKsetup{EmboldenFactor=3} 
% 宋体
\renewcommand{\songti}{\CJKfontspec[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold=3]{simsun.ttc}}
% 中文默认为宋体,小四在\documentclass处设置
\setCJKmainfont[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold=3]{simsun.ttc} 
% \newcommand{\宋体}{\songti}

% 黑体
\renewcommand{\heiti}{\CJKfontspec[Path=fonts/,AutoFakeBold=3]{simhei.ttf}}
\setCJKsansfont[Path=fonts/]{simhei.ttf}
% \newcommand{\黑体}{\heiti}

% 华文仿宋
\newcommand{\STfangsong}{\CJKfontspec[Path=fonts/,AutoFakeBold={2.2}]{STfangsong.ttf}}
% \newcommand{\仿宋}{\fangsong}

% 楷体
\newcommand{\kaiti}{\CJKfontspec[Path=fonts/,AutoFakeBold={2.0}]{simkai.ttf}}

% 默认行距
\linespread{1.25}

% 字号汉化设置
\newcommand{\chuhao}{\zihao {0}}
\newcommand{\xiaochu}{\zihao{-0}}
\newcommand{\yihao}{\zihao {1}}
\newcommand{\xiaoyi}{\zihao{-1}}
\newcommand{\erhao}{\zihao {2}}
\newcommand{\xiaoer}{\zihao{-2}}
\newcommand{\sanhao}{\zihao {3}}
\newcommand{\xiaosan}{\zihao{-3}}
\newcommand{\sihao}{\zihao {4}}
\newcommand{\xiaosi}{\zihao{-4}}
\newcommand{\wuhao}{\zihao {5}}
\newcommand{\xiaowu}{\zihao{-5}}
\newcommand{\liuhao}{\zihao {6}}
\newcommand{\xiaoliu}{\zihao{-6}}
\newcommand{\qihao}{\zihao {7}}
\newcommand{\bahao}{\zihao {8}}




% ==============================================================================
% 设置封面
% ==============================================================================
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
        \kaiti\chuhao\bfseries 
        上海电力大学
    }
    \vskip 50pt
    {
        \STfangsong\xiaochu\bfseries 
        本科毕业设计（论文）
    }
    \vskip 60pt
    \includegraphics[width=4.82cm, height=4.82cm]{logo}
    \vskip 40pt

    {
        \songti
        \sihao
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
        \heiti\xiaoer
        上海电力大学 \\
        本科毕业设计（论文）原创性声明
    \end{center}
    \vskip 6.35mm

    \songti\sihao
    \linespread{2}
    本人郑重申明：本人所呈交的毕业论文，是在指导老师的指导下独立进行研究所取得的成果。
    论文中凡引用他人已经发布或未发表的成果、数据、观点等，均已明确注明出处。
    论文中除已经注明引用的内容外，不包含任何其他个人或集体已经发表或撰写过的研究成果。
    对本文的研究成果做出重要贡献的个人和集体，均已在论文中以明确的方式标明。

    本声明的法律责任由本人承担。

    \vspace*{10ex}

    {\hfill{}论文作者签名：\hspace*{8em}日期：\hspace*{5em}}
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
        \heiti\xiaoer
        上海电力大学 \\
        本科毕业设计（论文）使用授权声明
    \end{center}
    \vskip 6.35mm

    \songti\sihao
    \linespread{2}
    本人在指导老师的指导下所完成的论文及相关的资料，知识产权归属上海电力大学。
    本人完全了解上海电力大学有关保存、使用毕业论文的规定，同意学校保存或向国家有关部门或机构送交论文的纸质版或电子版，允许论文被查阅或借阅。
    本人授权上海电力大学可以将本毕业论文的全部或部分内容编入有关数据库进行检索，可以采用任何复制手段保存或编汇本毕业论文。
    如果发表相关成果，一定征得指导教师同意，且第一署名单位为上海电力大学。本人毕业后使用毕业论文或与该论文直接相关的学术论文或成果时，第一署名单位仍然为上海电力大学。

    \vspace*{10ex}

    {\hfill{}论文作者签名：\hspace*{8em}日期：\hspace*{5em}}

    \vspace*{5ex}

    {\hfill{}指导老师签名：\hspace*{8em}日期：\hspace*{5em}}
}

% ==============================================================================
% 设置标题
% ==============================================================================

% 一级标题格式：第*章  后空一格（全角）黑体　小三号字　居中 1.5倍行距 段前0行 段后0.5行
\ctexset{
  chapter = {
    format = \heiti \xiaosan \linespread{1.5} \centering,
    titleformat = {},
    nameformat = {},
    name = {第 ,章},
    aftername = \hspace{\ccwd},
    beforeskip = {0pt},
    afterskip = {0.5ex},
    pagestyle = fancy,
  }
}
% 二级标题格式： 1.1（半角）  后空一格(全角) 黑体四号字 居左 1.5倍行距 段前0.5行 段后0行
\ctexset{
  section = {
    format = \heiti \sihao \linespread{1.5} \raggedright,
    nameformat = {},
    titleformat = {},
    aftername = \hspace{\ccwd},
    beforeskip = {0.5ex},
    afterskip = {0pt},
  }
}

% 三级标题格式： 1.1.1（半角）前空两格、后空一格（全角） 黑体小四号字 居左 1.5倍行距 段前0.5行 段后0行
\ctexset {
  subsection = {
    format = \heiti \xiaosi \linespread{1.5},
    nameformat = {},
    titleformat = {},
    indent = {2\ccwd},
    aftername = \hspace{\ccwd},
    beforeskip = {0.5ex},
    afterskip = {0pt},
  },
}

% \ctexset{
%   paragraph = {
%     runin = false,
%     hang = true,
%     indent = 2\ccwd,
%     beforeskip = {0pt},
%     afterskip = {0pt},
%   },
%   subparagraph = {
%     runin = false,
%     hang = true,
%     indent = 2\ccwd,
%     beforeskip = {0pt},
%     afterskip = {0pt},
%   }
% }




\pagestyle{fancy}
\fancyhead[C]{\songti \xiaowu \suep@title}
\fancyhead[LR]{}
\fancyfoot[C]{\zihao{-5}-\ \thepage\ -}


\linespread{1.25}

% ==============================================================================
% 目录格式
% ==============================================================================

\renewcommand{\contentsname}{\heiti \xiaosan 目录 }

\titlecontents{chapter}[4em]
	{\xiaosi \linespread{1.4} \bfseries}
	{\contentslabel{4em}}
	{ }
	{~\titlerule*[0.6pc]{$\cdot$}~\contentspage}

\titlecontents{section}[3em]
	{ \xiaosi \linespread{1.4} }
	{ \contentslabel{2em} }
	{ }
	{ ~\titlerule*[0.6pc]{$\cdot$}~\contentspage }

\titlecontents{subsection}[4em]
	{ \xiaosi \linespread{1.4} } 
	{ \contentslabel{2.5em} }
	{ }
	{ ~\titlerule*[0.6pc]{$\cdot$}~\contentspage }

% \titlecontents{chapter*}[0em]
% 	{\xiaosi \linespread{1.4} \bfseries}
% 	{\contentslabel{4em}}
% 	{ }
% 	{~\titlerule*[0.6pc]{$\cdot$}~\contentspage}


% ------------------------------------------------------------------------------
%   Abstract
% ------------------------------------------------------------------------------
\newcommand{\suep@abstract@name}{摘\hspace{0.5\ccwd}要}
\newcommand{\suep@abstract@name@en}{Abstract}

\newenvironment{abstract}{
  % \let\cleardoublepage\clearpage
  \vspace*{\baselineskip}
  \ctexset{
    chapter/format += \heiti \xiaosan \bfseries, 
    chapter/beforeskip = 0.5ex
  }
  % 黑体小三号，居中，1.5倍 行距，段前0、段后0.5
  \chapter*{\suep@abstract@name}
  \songti\xiaosi
}{
  \vspace*{\baselineskip}
  \par\noindent{\heiti \bfseries 关键词：} \suep@keywords
  \vfill
  \fancyfoot{}
  \newpage
}

\newenvironment{abstract*}{
  \let\clearpage\relax
  \vspace*{\baselineskip}
  \begin{center}
    {\xiaoer \bfseries \suep@title@en}
  \end{center}
  % \vspace*{\baselineskip}%
  \ctexset{
    chapter/format += \xiaosan \bfseries, 
    chapter/beforeskip = 0pt
  }
  \chapter*{\suep@abstract@name@en}
}{
  \vspace*{\baselineskip}
  \par\noindent{\sihao \bfseries Key Words: } \suep@keywords@en
  \vfill
  \fancyfoot{}
  \newpage
  \setcounter{page}{1}
}


\renewcommand{\thanks}{
  \addcontentsline{toc}{chapter}{致谢}
  \chaptermark{致谢}
  \chapter*{致谢}
}


\newcommand{\reference}{

  \addcontentsline{toc}{chapter}{参考文献}
  \chaptermark{参考文献 Thanks}
  \chapter*\centerline{参考文献}
}