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

% 包依赖
\LoadClass[UTF8]{ctexart}
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
% \xeCJKsetup{EmboldenFactor=3} 
% 宋体
\renewcommand{\songti}{\CJKfontspec[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold]{simsun.ttc}}
% 中文默认为宋体,小四在\documentclass处设置
\setCJKmainfont[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold]{simsun.ttc} 
% \newcommand{\宋体}{\songti}

% 黑体
\renewcommand{\heiti}{\CJKfontspec[Path=fonts/]{simhei.ttf}}
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

% 设置章节
\ctexset{
  % 需要使用ctexart文类，否则报错键不存在
  section = {
        % format用于设置章节标题全局格式，作用域为标题和编号
		% 字号为小三，字体为黑体，居中
		% +号表示在原有格式下附加格式命令
		format+ = \zihao{-3} \heiti \centering,
		% name用于设置章节编号前后的词语
		% 前、后词语用英文状态下,分开
		% 如果没有前或后词语可以不填
		name = {第 ,章},
		% number用于设置章节编号数字输出格式
		% 输出section编号为中文
		number = \chinese{section},
		% beforeskip用于设置章节标题前的垂直间距
		% ex为当前字号下字母x的高度
		% 基础高度为1.0ex，可以伸展到1.2ex，也可以收缩到0.8ex
		beforeskip = 1.0ex plus 0.2ex minus .2ex,
		% afterskip用于设置章节标题后的垂直间距
		afterskip = 1.0ex plus 0.2ex minus .2ex,
		% aftername用于控制编号和标题之间的格式
		% \hspace用于增加水平间距
		aftername = \hspace{pt}
  }
}


% 设置一级标题


% 设置二级标题


% 设置三级标题

\let\subsection\section
\let\subsubsection\subsection


% 页眉
\pagestyle{fancy}
\chead{\songti\zihao{-5}\suep@title \suep@sub@title}

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
%   \makebox[#1][c]{\hspace*{-#2} #3 }%
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
\newenvironment{abstract}[1][\sht@null@arg]{%
  \cleardoublepage%
  \ifthenelse{\equal{#1}{flattitle}}{%
    \def\sht@abs@title{\sht@flat@title}%
  }{%
    \def\sht@abs@title{\sht@title}%
  }%
  \ifsht@undergraduate
    \let\clearpage\relax%
    \vspace*{\baselineskip}%
    \begin{center}%
      \zihao{3}\bfseries\sffamily\sht@abs@title%
    \end{center}%
    \vspace*{\baselineskip}%
    \ctexset{chapter/format += \zihao{4}, chapter/beforeskip = 0pt}%
    \ifsht@comfort%
      \def\sht@abstract@name{摘\hspace{1\ccwd}要}
    \else%
      \def\sht@abstract@name{摘要}
    \fi
  \else%
    \def\sht@abstract@name{摘\hspace{1\ccwd}要}
  \fi
  \intobmk\chapter*{\sht@abstract@name}%
}{%
  \vspace{\baselineskip}%
  \ifsht@undergraduate%
    \ifsht@comfort%
      \par\noindent{\bfseries\sffamily 关键词：} \sht@keywords%
    \else%
      \par\noindent{\zihao{-4}\bfseries\sffamily 关键词：} \sht@keywords%
    \fi%
  \else%
    \par\noindent{\bfseries 关键词：} \sht@keywords%
  \fi%
}
\newenvironment{abstract*}[1][\sht@null@arg]{%
  \cleardoublepage%
  \ifthenelse{\equal{#1}{flattitle}}{%
    \def\sht@abs@title@en{\sht@flat@title@upper@en}%
  }{%
    \def\sht@abs@title@en{\sht@title@en}%
  }%
  \ifsht@undergraduate
    \let\clearpage\relax%
    \vspace*{\baselineskip}%
    \begin{center}%
      \zihao{3}\bfseries\sht@abs@title@en%
    \end{center}%
    \vspace*{\baselineskip}%
    \ctexset{chapter/format += \zihao{4}\rmfamily, chapter/beforeskip = 0pt}%
    \intobmk\chapter*{ABSTRACT}%
  \else
    \intobmk\chapter*{Abstract}%
  \fi
}{%
  \vspace{\baselineskip}%
  \ifsht@undergraduate%
    \ifsht@comfort%
      \par\noindent{\bfseries Key words:} \sht@keywords@en%
    \else%
      \par\noindent{\zihao{-4}\bfseries Key words:} \sht@keywords@en%
    \fi%
  \else%
    \par\noindent{\bfseries Key Words:} \sht@keywords@en%
  \fi%
}