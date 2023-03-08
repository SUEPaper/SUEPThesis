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

% 参考SJTU Thesis和WHU Thesis Latex模板进行重构。

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 基本信息
%
% 指定模板使用的 Latex 版本，标识输出模板名
% 提供报错信息
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{suepthesis}
[2023/02/08 v0.1 Shanghai University of Electric Power Graduation Thesis LaTeX Template]

% 加载xparse宏包，LaTeX3支持
\RequirePackage{xparse}

% 报错与警告
\newcommand\suep@error[1]{%
  \ClassError{suepthesis}{#1}{}%
}
\newcommand\suep@warning[1]{%
  \ClassWarning{suepthesis}{#1}%
}
\newcommand\suep@patch@error[1]{%
  \suep@error{Failed to patch command \protect#1}%
}

% 引擎执行判断宏包

\RequirePackage{iftex}
\ifXeTeX\else
  \suep@error{XeLaTeX is required to compile this document}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 选项定义
%
% 提供模板可使用的选项
% 提供报错信息
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\hyphenation{SUEP-Thesis}
\def\suepthesis{\textup{\sffamily suepthesis}}
\def\SUEPThesis{\textup{\sffamily SUEPThesis}}
\def\version{0.5.0}

% 定义一些命令用于写文档
% /cs 在ltxdoc 包中也提供，剩下是自定义的
% 借鉴自thuthesis和ustcthesis模板
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\file{\nolinkurl}
\DeclareRobustCommand\env{\textsf}
\DeclareRobustCommand\pkg{\textsf}
\DeclareRobustCommand\cls{\textsf}
\RequirePackage{hologo}
\newcommand{\XeTeX}{\hologo{XeTeX}}
\newcommand{\BibLaTeX}{\textsc{Bib}\LaTeX}

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



% % 定义致谢环境，盲审下隐藏致谢
\DeclareBoolOption[false]{review}
\DeclareBoolOption[false]{continuous}
% 注意openany和oneside参数，默认是无空白页不区分双面印。
\DeclareBoolOption[false]{openright}
\DeclareComplementaryOption{openany}{openright}
\DeclareBoolOption[true]{raggedbottom}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*
\ifsuep@openright
  \PassOptionsToClass{openright}{book}
\else
  \PassOptionsToClass{openany}{book}
\fi

% 使用 \XeTeX{} 引擎时，\pkg{fontspec} 宏包会被 \pkg{xeCJK} 自动调用。传递给
% \pkg{fontspec} 宏包 \opt{no-math} 选项，避免部分数学符号字体自动调整为 CMR。
% 并使用 \opt{quiet} 忽略警告。
\PassOptionsToPackage{no-math, quiet}{fontspec}
% 读取基类
\LoadClass[UTF8,a4paper,oneside,zihao=-4]{ctexbook}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 加载宏包
%
% 加载必要的宏包
% 部分宏包再前面由于需要已经加载（或顺序限制）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 支持中文的 ctex 宏包
\RequirePackage{ctex}
% 页面布局
\RequirePackage{geometry}
% 使用 \pkg{amsmath} 处理数学公式
\RequirePackage{amsmath}
% 下面的数学宏包和unicode-math 冲突
% \RequirePackage{amsfonts}
% \RequirePackage{amssymb}
% \RequirePackage{bm}
% 使用 \pkg{unicode-math} 处理数学字体
\RequirePackage{unicode-math}
% 算法排版宏包
\RequirePackage[chapter]{algorithm}
\RequirePackage{algorithmic}
\floatname{algorithm}{算法}

% 自定义关键词
\RequirePackage{pgfkeys}
% 设置目录
% v0.1.4 考虑到兼容性问题，不适用titletoc和titilesec
% \RequirePackage{titletoc}
% \RequirePackage{titlesec}
\RequirePackage[titles]{tocloft}
% 设置字体
\RequirePackage{fontenc}
% 设置颜色
\RequirePackage{xcolor}
% 设置页眉和页脚
\RequirePackage{fancyhdr}
% 代码高亮
% 注：该包依赖python环境Pygments语法高亮显示工具包
% 并且需要 -shell-escape参数
\RequirePackage{minted}

% 超链接 hyperref 的设置
% 提供书签与链接
\RequirePackage{hyperref}
% 插入图片
\RequirePackage{graphicx}
% 表格
\RequirePackage{array}
% 长表格
\RequirePackage{longtable}
% booktabs 提供了\toprule 等命令.
\RequirePackage{booktabs}
% multirow 支持在表格中跨行
\RequirePackage{multirow}
% 调整间隔, 让表格更好看些
\RequirePackage{bigstrut}
%在跨行表格中输入定界符
\RequirePackage{bigdelim}
% 保护脆弱命令
\RequirePackage{cprotect}


% jing: ccaption宏包不能出现在 caption 宏包之后
% 设置浮动体的标题
\RequirePackage[justification=centering]{caption}
\RequirePackage[justification=centering]{subcaption}
% 定制列表环境
\RequirePackage{enumitem}
% 提供\AtBeginEnvironment以方便全局调整一些结构的设置
\RequirePackage{etoolbox}
% 确定宏定义的位置
\RequirePackage{filehook}
% 枚举
\RequirePackage{enumitem}
% 末尾页
\RequirePackage{lastpage}
% 
% \RequirePackage{hypdoc}

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

% 使用 \pkg{unicode-math} 配置数学字体。
\unimathsetup{
  math-style = ISO,
  bold-style = ISO,
  nabla      = upright,
  partial    = upright,
}

\newcommand\suep@pdfbookmark[2]{}
% 定义通用的chapter命令
\NewDocumentCommand{\suep@chapter}{s m}{
  \if@openright\cleardoublepage\else\clearpage\fi
%   \addcontentsline{toc}{chapter}{#1}%
%   \suep@pdfbookmark{0}{#1}
  \IfBooleanTF{#1}{
      \suep@pdfbookmark{0}{#2}
  }{
      \phantomsection
      \addcontentsline{toc}{chapter}{#2}
  }
  \chapter*{#2}
}


\AtEndOfPackageFile*{hyperref}{
  \hypersetup{
    linktoc            = all,
    bookmarksdepth     = 2,
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1,
    unicode            = true,
    psdextra           = true,
    breaklinks         = true,
    plainpages         = false,
    pdfdisplaydoctitle = true,
    hidelinks,
  }
  \newcounter{suep@bookmark}
  \renewcommand\suep@pdfbookmark[2]{%
    \phantomsection
    \stepcounter{suep@bookmark}%
    \pdfbookmark[#1]{#2}{suepchapter.\thesuep@bookmark}%
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 页面布局
%
% 设置页边距以及版芯行间距设置
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 边距要求上2.5cm，下2.5cm，左3cm，右2cm
\geometry{top=2.5cm,bottom=2.5cm,left=3cm,right=2cm}
% 本科生从摘要开始就要有
% 设置页眉和页脚 %
\pagestyle{fancy}
% 本科学位论文底部样式
\newcommand{\suep@thepage@format@zh}[2]{第~{#1}~页 共~{#2}~页}
\newcommand{\suep@thepage@format@en}[1]{#1}
% 空白页清空页眉页脚
\patchcmd{\cleardoublepage}{\newpage}{\thispagestyle{empty}\newpage}{}{}
% 对章节首页的特殊page style清除页眉页脚
\patchcmd{\chapter}{\thispagestyle}{\@gobble}{}{}


\fancyhf[RH]{\songti \xiaowu \suep@title}

% frontmatter设置
\renewcommand{\frontmatter}{
    \cleardoublepage
    \@mainmatterfalse
    % 根据学校要求使用大罗马编号
    \pagenumbering{Roman}
    \def\suep@thepage{\thepage}
    \def\suep@lastpageref{\pageref{LastPage}}
    \fancyfoot[C]{\zihao{-5}  \suep@thepage@format@en{\suep@thepage}}
}
% mainmatter设置
\renewcommand{\mainmatter}{
    \cleardoublepage
    \@mainmattertrue
    % 正文部分启用阿拉伯数字编号
    \pagenumbering{arabic}
    \def\suep@thepage{\thepage}
    \def\suep@lastpageref{\pageref{LastPage}}
    \fancyfoot[C]{\zihao{-5} \songti \suep@thepage@format@zh{\suep@thepage}{\suep@lastpageref}}
}
% 给页眉留足空间（否则会有 \headheight is too small的warning）
\setlength{\headheight}{14.5pt}
% “磅”是衡量印刷字体大小的单位,约等于七十二分之一英寸。
% 而 1英寸＝25.4毫米，则1磅＝25.4/72≈0.353毫米。
% 磅和 LaTeX的 pt- points (大约 1/72 inch) 是一致的。
% 基本行间距设置
\renewcommand*{\baselinestretch}{1.3}   % 几倍行间距
\setlength{\baselineskip}{20pt}         % 基准行间距
% \setlength{\bibsep}{0.5ex} % 参考文献条目间距



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 字体设置
%
% 进行相关字体设置，定义必须的新字体
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: Times New Roman目前只能在Windows上使用，需要增加Linux系统字体
% \setmainfont{Times New Roman}
% \setmonofont{Courier New}
% \setsansfont{Arial}

% \renewcommand\normalsize{%
% 	\@setfontsize\normalsize{12.05}{14.45}%
% 	\abovedisplayskip 12\p@ \@plus3\p@ \@minus7\p@
% 	\abovedisplayshortskip \z@ \@plus3\p@
%     \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
% }

% ==============================================================================
% 字体设置
% ==============================================================================

% 英文默认为Times New Roman
\setmainfont[Path=./fonts/, BoldFont={*Bold}, ItalicFont={*Italic}, BoldItalicFont={*BoldItalic}]{TimesNewRoman}

% 伪粗体等级
% \xeCJKsetup{EmboldenFactor=3} 
% 宋体
\newcommand{\songti}{\CJKfontspec[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold={3.17}]{simsun.ttc}}
% 中文默认为宋体,小四在\documentclass处设置
\setCJKmainfont[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold={3.17}]{simsun.ttc} 
% \newcommand{\宋体}{\songti}

% 黑体
\newcommand{\heiti}{\CJKfontspec[Path=fonts/,AutoFakeBold={3.17}]{simhei.ttf}}
\setCJKsansfont[Path=fonts/]{simhei.ttf}
% \newcommand{\黑体}{\heiti}

% 华文仿宋
\newcommand{\STfangsong}{\CJKfontspec[Path=fonts/,AutoFakeBold={3.17}]{STfangsong.ttf}}
% \newcommand{\仿宋}{\fangsong}

% 楷体
\newcommand{\kaiti}{\CJKfontspec[Path=fonts/,AutoFakeBold={3.17}]{simkai.ttf}}


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

% 预定义名称
\newcommand*{\suep@name@cover}{扉页}
\newcommand*{\suep@name@abstract@zh}{中文摘要}
\newcommand*{\suep@name@abstract@en}{英文摘要}
\newcommand*{\suep@name@keywords}{关键字}
\newcommand*{\suep@name@contents}{目录}
\newcommand*{\suep@name@listfigure}{插图清单}
\newcommand*{\suep@name@listtable}{附表清单}
\newcommand*{\suep@name@index}{索引}
\newcommand*{\suep@name@figure}{图}
\newcommand*{\suep@name@table}{表}
\newcommand*{\suep@name@appendix}{附录}
\newcommand*{\suep@name@acknowledgements}{致谢}

%---------------------------------------------
%控制引用格式，选用上标引用
% \newcommand\supercite[2][]{%
    % \textsuperscript{\cite[#1]{#2}}}






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 封面扉页
%
% 提供本科毕业论文封面扉页设计
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 原创性声明 
% 
% 提供原创性声明样式
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 使用授权声明
% 
% 提供使用授权声明样式
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 摘要
% 
% 提供中英文摘要样式
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\suep@abstract@name}{摘\hspace{0.5\ccwd}要}
\newcommand{\suep@abstract@name@en}{Abstract}

\newenvironment{abstract}{
  % \let\cleardoublepage\clearpage
  \vspace*{\baselineskip}
  \ctexset{
    chapter/format += \heiti \xiaosan \bfseries, 
    chapter/beforeskip = 1ex,
  }

  % 黑体小三号，居中，1.5倍 行距，段前0、段后0.5
  \linespread{1.5}
  \chapter*{\suep@abstract@name}
  \songti\xiaosi
}{
  \vspace*{\baselineskip}
  % \begin{flushleft}
  %   \noindent {\xiaosi \bfseries \heiti 关键词：} {\xiaosi \songti \suep@keywords} \par % 关键词为小四号黑体加粗，内容为小四号宋体
  % \end{flushleft}
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. 目录 %
% -----------------------------------------------%
% 目录应列出论文的大标题、一级和二级节标题，逐项标明页码（具体见样例10）。各级标题应简明扼要、点出各部分主要内容。学位论文的页码编排为：正文和后置部分用阿拉伯数字编连续码，前置部分用罗马数字单独编连续码（封面除外）。
% “目录”两字居中（三号黑体），下空两行为章、节、小节及其开始页码（靠右顶格）。章、节、小节分别以阶梯式排列：1（第1章）、1.1、1.1.1依次标出。章、节、小节的题名与页码之间用“．．．．．．”连接。除“目录”两字外，其余字体均为小四号宋体。

%TODO: 本科和硕博目录格式要求不同
% \renewcommand{\contentsname}{\hfill \heiti \zihao{3} 目\quad 录\hfill}
% \renewcommand{\contentsname}{目录}
% 	\renewcommand*{\baselinestretch}{1.5}   % 行间距
%     \tableofcontents
% }
\renewcommand\tableofcontents{
    \chapter*{\suep@name@contents}
    \suep@pdfbookmark{0}{\suep@name@contents}
    \@starttoc{toc}
}
\newcommand\suep@toc@set@format{
    % 目录格式修复
    % bugfix: 修复章节加粗
    \renewcommand\cftchapfont{\songti\xiaosi}
    \renewcommand\cftchappagefont{\songti\xiaosi}
    \renewcommand{\cftdot}{$\cdot$}
    \renewcommand{\cftdotsep}{0.5}
    \setlength{\cftbeforechapskip}{4pt}
    \setlength{\cftbeforesecskip}{4pt}
    \setlength{\cftbeforesubsecskip}{4pt}
    % \setlength{\cftaftersecskip}{12pt}
    \renewcommand{\cftchapleader}{\cftdotfill{\cftchapdotsep}}
    \renewcommand{\cftchapdotsep}{\cftdotsep}
}
% bugfix: forget to call (v1.0.3-v1.0.4)
\suep@toc@set@format


% 6. 符号说明（必要时）%
% ---------------------------------------------------------%
% TODO:
%
% 如果论文中使用了大量的物理量符号、标志、缩略词、专门计量单位、自定义名词和术语等，应编写成注释说明汇集表，说明论文中所用符号所表示的意义及单位（或量纲）。若上述符号和缩略词使用数量不多，可以不设专门的注释说明汇集表，仅在论文中出现时加以说明。
% “符号说明”四字居中（三号黑体）。


% 7. 论文正文 %
% -------------------------------------------------------%
% 论文正文是主体，主体部分应从另页右页开始，每一章应另起页。一般由序号标题、文字叙述、图、表格和公式等五个部分构成。
% 写作形式可因研究内容的性质不同而变化，一般可包括绪论（或综述）、理论分析、计算方法、实验装置和测试方法、实验结果分析和讨论、研究成果、结论及意义等。
% 该部分由用户编写

% 图表等浮动环境设置 %
% ----------------------------------------------------------%
% TODO %
% 图、表、公式：文中的图、表、附注、公式一律采用阿拉伯数字分章（或连续）编号，如：图2-5，表3-2，公式（5-1）等。
% 图序及图名居中置于图的下方，如果图中含有几个不同部分，应将分图号标注在分图的左上角，并在图解下列出各部分内容。图中的术语、符号、单位等应与正文表述所用一致。
% 表序及表名置于表的上方，表中参数应标明量和单位的符号。表的编排应采用国际通用的三线表。续表均应重复表头，如表需转页接排，随后各页应重复表的编号，其后跟表题（可省略）和“续”置于表上方。
% 图序及图名、表序及表名采用五号楷体字。若图或表中有附注，采用英文小写字母顺序编号，附注写在图或表的下方。公式的编号用括号括起写在右边行末，其间不加虚线。
% 图、表、公式等与正文之间要有一定的行间距。
% \RequirePackage{caption}
% 默认情况下, \LaTeX{} 要求每页的文字至少占据 20%,否则该页就只单独放置一个浮动环境,
% 而这通常不是我们想要的, 我们将这个要求降低到 5%.
\renewcommand*{\textfraction}{0.05}
% 有时如果多个浮动环境连续放在一起, \LaTeX{}
% 会将它们分在几个不同页，即使它们可在同一页放
% 得下. 我们可以通过修改 |\topfraction| 和 |\bottomfraction| 分别设置顶端和底端的浮
% 动环境的最大比例.
 \renewcommand*{\topfraction}{0.9}
 \renewcommand*{\bottomfraction}{0.8}
% 有时\LaTeX{}会把一个浮动环境单独放在一页,
% 我们要求这个环境至少要占据 85% 才能单独放在一页.
% 注意:  |\floatpagefraction| 的数值必须小于 |\topfraction|.
 \renewcommand*{\floatpagefraction}{0.85}
% 关于图片 graphicx
 % 如果图片没有指定后缀, 依次按下列顺序搜索
\DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png,.tif}
 % 设置图表搜索路径, 可以给图表文件夹取如下名字
\graphicspath{{figures/}{figure/}{pictures/}%
  {picture/}{pic/}{pics/}{image/}{images/}}




% 插图格式
% ------------------------------------------------------%
% \captionsetup[subfigure]{labelfont=normalfont,textfont=normalfont,singlelinecheck=off,justification=raggedright}
% singlelinecheck=off 表示即使caption只有一行， justification 也生效
% justification=raggedright 使子图 caption 靠左对齐，而caption的上下位置由\caption标签的位置决定，以此实现了学校要求的子图标签在左上角显示。
% 这部分功能由 subcaption 这个包实现，而这个包不能和 subfigure 同时使用，所以子图的写法也与 subfigure 包的不大一样。
\captionsetup[subfigure]{singlelinecheck=off,justification=raggedright}

% 图下方描述的黑体
\DeclareCaptionFont{hei}{\heiti}
\DeclareCaptionFont{five}{\zihao{5}}
\renewcommand{\thefigure}{\arabic{section}-\arabic{figure}}
% \renewcommand{\thefigure} {\thesection-\arabic{figure}}

\captionsetup[figure]{
	format=plain,      % 标题从第二行开始是否缩进，plain无缩进，hang有缩进
	labelsep=quad,     % 分隔符是一个空格
	font={hei,five},
	position=bottom    % position=bottom, 不代表标题放在下面, 标题仍放在你放\caption的位置.
}
% 表格格式
% ------------------------------------------------------%
\renewcommand{\thetable}{\arabic{section}-\arabic{table}}
% \renewcommand {\thetable} {\thesection-\arabic{table}}
\captionsetup[table]{
	format=plain,      % 标题从第二行开始是否缩进，plain无缩进，hang有缩进
	labelsep=quad,     % 分隔符是一个空格
	font={hei,five},   % 表的字体, 宋体小四
	position=top
}



% 列表环境设置 %
% ------------------------------------------------------------------%
\setlist{%
	topsep=0.3em, % 列表顶端的垂直空白
	partopsep=0pt, % 列表环境前面紧接着一个空白行时其顶端的额外垂直空白
	itemsep=0ex plus 0.1ex, % 列表项之间的额外垂直空白
	parsep=0pt, % 列表项内的段落之间的垂直空白
	leftmargin=1.5em, % 环境的左边界和列表之间的水平距离
	rightmargin=0em, % 环境的右边界和列表之间的水平距离
	labelsep=0.5em, % 包含标签的盒子与列表项的第一行文本之间的间隔
	labelwidth=2em % 包含标签的盒子的正常宽度；若实际宽度更宽，则使用实际宽度。
}

% 表格 %
% ------------------------------------------------------%
% 修改tabular 环境, 设置表格中的行间距为正文行间距.
\let\suep@oldtabular\tabular
\let\suep@endoldtabular\endtabular
\renewenvironment{tabular} {
    \bgroup
	\renewcommand{\arraystretch}{1.38}
    \suep@oldtabular
} {
    \suep@endoldtabular\egroup
}

% 表格字号应比正文小，一般五号/10.5pt，但是暂时没法再cls里设置（不然会影响到封面等tabular环境）
% 所以目前只好在主文件里局部\AtBeginEnvironment

% 数学环境, 定理等设置 %
% -------------------------------------------------------%
\newtheorem{definition}{\suep@cap@definition}
\newtheorem{proposition}{\suep@cap@proposition}
\newtheorem{theorem}{\suep@cap@theorem}
\newtheorem{lemma}{\suep@cap@lemma}
\newtheorem{corollary}{\suep@cap@corollary}
\newtheorem{assumption}{\suep@cap@assumption}
\newtheorem{conjecture}{\suep@cap@conjecture}
\newtheorem{axiom}{\suep@cap@axiom}
\newtheorem{principle}{\suep@cap@principle}
\newtheorem{problem}{\suep@cap@problem}
\newtheorem{example}{\suep@cap@example}
\newtheorem{proof}{\suep@cap@proof}
\newtheorem{solution}{\suep@cap@solution}

% 数学定理相关的常量
\newcommand*{\suep@cap@definition}{定义}
\newcommand*{\suep@cap@proposition}{命题}
\newcommand*{\suep@cap@theorem}{定理}
\newcommand*{\suep@cap@lemma}{引理}
\newcommand*{\suep@cap@corollary}{推论}
\newcommand*{\suep@cap@assumption}{假设}
\newcommand*{\suep@cap@conjecture}{猜想}
\newcommand*{\suep@cap@axiom}{公理}
\newcommand*{\suep@cap@principle}{定律}
\newcommand*{\suep@cap@problem}{问题}
\newcommand*{\suep@cap@example}{例}
\newcommand*{\suep@cap@proof}{证明}
\newcommand*{\suep@cap@solution}{解}


% TODO 测试段落后间距
% 各级标题格式设置。
\ctexset{%
    % 一级标题格式：第*章  后空一格（全角）黑体　小三号字　居中 1.5倍行距 段前0行 段后0.5行
    chapter = {%
        format       = \xiaosan \heiti \centering,
        titleformat  = {},
        nameformat   = {},
        name         = {第 ,章},
        titleformat  = {},
        aftername    = \quad,
        afterindent  = true,
        fixskip      = true,
        beforeskip   = {0pt},
        afterskip    = {1ex},
        pagestyle    = fancy,
    },
    % 二级标题格式： 1.1（半角）  后空一格(全角) 黑体四号字 居左 1.5倍行距 段前0.5行 段后0行
    section = {%
        format       = \sihao \heiti \raggedright,
        afterindent  = true,
        % beforeskip 默认为 3.5ex plus 1ex minus .2ex 适当缩减
        % beforeskip   = {20pt},
        % beforeskip   = {\ifsuep@type@graduate 30pt \else 20pt\fi}
        % afterskip    = {2ex \@plus .2ex},
        % fixskip      = true,
        nameformat = {},
        titleformat = {},
        aftername = \quad,
        beforeskip = {0.5ex},
        afterskip = {0pt},
    },
    % 三级标题格式： 1.1.1（半角）前空两格、后空一格（全角） 黑体小四号字 居左 1.5倍行距 段前0.5行 段后0行
    subsection = {%
        format       = \heiti \xiaosi,
        % afterindent  = true,
        % afterskip    = {2ex \@plus .2ex},
        % fixskip      = true,
        nameformat = {},
        titleformat = {},
        indent = {2\ccwd},
        aftername = \quad,
        beforeskip = {0.5ex},
        afterskip = {0pt},
    },
}


% 全文首行缩进 2 字符， 标点符号用全角
% \ctexset{%
%   punct          = quanjiao,
%   space          = auto,
%   autoindent     = true,
% }

% % 编号分章节。如需要连续编号，注释\makeatletter下面对应内容即可。
% \renewcommand{\theequation}{\arabic{section}-\arabic{equation}}
% \makeatletter
% \@addtoreset{figure}{section}
% \@addtoreset{table}{section}
% \@addtoreset{equation}{section}
% \makeatother

% 8. 参考文献 %
% ------------------------------------------------------%
% TODO %
% 文后参考文献只列出作者直接阅读过、在正文中被引用过的文献资料，务必实事求是。参考文献一律列在正文的末尾，不得放在各章之后。人文社科类学位论文中不宜用文后参考文献列出的注释可采用页下注，包括对学位论文中某些关键词句、论点的详细说明。在引用别人的科研成果时，应在引用处加以说明，遵循学术道德规范，严禁论文抄袭、剽窃等学术不端行为。
% 参考文献可以采用顺序编码制组织，也可以按“著者-出版年”制组织。建议按顺序编码制，即按中文引用的顺序将参考文献附于文末。作者姓名写到第三位，余者写“，等”或“，et al.”。“参考文献”四字居中(三号黑体)，空一行左起按顺序依次列出参考文献，将序号置于方括号内(如[1])，用小四号宋体字，所有符号均用半角编排。
% 目前采用bgt7714-2005标准进行文献索引，详见gbt7714-2005.bst.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 附录
%
% 附录中主要列入正文内不便列出的过分冗长的公式推导，供查读方便所需的辅助性数学工具或表格、重复性数据图表、计算程序及说明等。
% 附录依次为附录1，附录2……等，“附录X”三字居中（三号黑体）。附录中的图表公式另编排序号，与正文分开。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义附录环境
% 在\appendix 后直接使用 chapter
% 暂不需要
% \newenvironment{appendixs}{
%     % \ifsuep@review\else
%     \suep@chapter{\suep@name@appendix}
%     % \fi
% }


% 10. 攻读学位期间主要研究成果 %
% --------------------------------------------------------%
% 分类按时间顺序列出作者在攻读学位期间取得的与学位论文相关的研究成果，含参加的研究项目、获奖情况、专利、专著、发表学术论文（含正式录用论文）等,书写格式参照参考文献格式。“攻读学位期间主要研究成果”字体居中（三号黑体）

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 致谢
%
% 作者对给予指导、各类资助和协助完成研究工作以及提供各种对论文工作有利条件的单位及个人表示感谢。“致谢”二字居中（三号黑体）。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定义致谢环境
\newenvironment{acknowledgements}{

    % Fix: 修复书签定位问题
    % \chapter*{\suep@name@acknowledgements}
    % \suep@pdfbookmark{0}{\suep@name@acknowledgements}
    % \phantomsection
    \suep@chapter{\suep@name@acknowledgements}
    % \suep@chapter{\suep@name@acknowledgements}
}



