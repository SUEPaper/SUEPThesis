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
\LoadClass[UTF8,a4paper]{ctexart}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage[most,minted]{tcolorbox}
\RequirePackage{minted}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{multirow}
\RequirePackage{listofitems}

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
\newcommand{\STfangsong}{\CJKfontspec[Path=fonts/,AutoFakeBold]{STfangsong.ttf}}
% \newcommand{\仿宋}{\fangsong}

% 楷体
\newcommand{\kaiti}{\CJKfontspec[Path=fonts/,AutoFakeBold]{simkai.ttf}}


% 其他
% \newcommand{\隶书}{\lishu}
% \newcommand{\幼圆}{\youyuan}
% \newcommand{\雅黑}{\yahei}
% \newcommand{\苹方}{\pingfang}

% 字体效果汉化设置
% \newcommand{\粗体}{\bfseries}
% \newcommand{\斜体}{\itshape}


% 题目
\newcommand\SUEPTitle[1]{\def\@SUEPTitle{#1}}
% 院系
\newcommand\SUEPDepartment[1]{\def\@SUEPDepartment{#1}}
% 专业年级
\newcommand\SUEPMajor[1]{\def\@SUEPMajor{#1}}
% 学生姓名
\newcommand\SUEPStudentName[1]{\def\@SUEPStudentName{#1}}
% 学号
\newcommand\SUEPStudentID[1]{\def\@SUEPStudentID{#1}}
% 指导老师
\newcommand\SUEPTeacherName[1]{\def\@SUEPTeacherName{#1}}
% 日期
\newcommand\SUEPDate[1]{\def\@SUEPDate{#1}}


% 页眉
\pagestyle{fancy}
\chead{\songti\zihao{-5}\@SUEPTitle}

% 页脚
\cfoot{\zihao{-5}-\ \thepage\ -}


% 封面
\newcommand{\makecover}{
    \thispagestyle{empty}
    \begin{center}
        {\kaiti\zihao{0}\bfseries 上海电力大学}
        \vskip 12.653mm
        {\STfangsong\zihao{-0}\bfseries 本科毕业设计（论文）}
        \vskip 14.76mm
        \includegraphics[width=4.82cm, height=4.82cm]{logo}
        \vskip 4.920mm


        {\songti\zihao{4} \@SUEPDate }
    \end{center}
    \clearpage

}


% 原创性声明 
\newcommand{\makepromise}{
    \linespread{1.5}
    \thispagestyle{empty}
    \begin{center}
        \heiti\zihao{-2}
        上海电力大学 \\
        本科毕业设计（论文）原创性声明
    \end{center}
    \vskip 6.326mm

    \songti\zihao{4}
    \linespread{1.75}
    本人郑重申明：本人所呈交的毕业论文，是在指导老师的指导下独立进行研究所取得的成果。
    论文中凡引用他人已经发布或未发表的成果、数据、观点等，均已明确注明出处。
    论文中除已经注明引用的内容外，不包含任何其他个人或集体已经发表或撰写过的研究成果。
    对本文的研究成果做出重要贡献的个人和集体，均已在论文中以明确的方式标明。

    本声明的法律责任由本人承担。
    \clearpage


    \clearpage
}

% 使用授权声明
\newcommand{\makeauthorize}{
    \linespread{1.5}
    \thispagestyle{empty}
    \begin{center}
        \heiti\zihao{-2}
        上海电力大学 \\
        本科毕业设计（论文）使用授权声明
    \end{center}
    \vskip 6.326mm

    \songti\zihao{4}
    \linespread{1.75}
    本人在指导老师的指导下所完成的论文及相关的资料，知识产权归属上海电力大学。
    本人完全了解上海电力大学有关保存、使用毕业论文的规定，同意学校保存或向国家有关部门或机构送交论文的纸质版或电子版，允许论文被查阅或借阅。
    本人授权上海电力大学可以将本毕业论文的全部或部分内容编入有关数据库进行检索，可以采用任何复制手段保存或编汇本毕业论文。
    如果发表相关成果，一定征得指导教师同意，且第一署名单位为上海电力大学。本人毕业后使用毕业论文或与该论文直接相关的学术论文或成果时，第一署名单位仍然为上海电力大学。
    \clearpage


    \clearpage
}


% \newenvironment{abstractcn}[1]%
%   {
%     \setsepchar{；}
%     \readlist\args{#1}
%     \begin{spacing}{1.45}
%       \noindent\黑体\三号[摘要]：
%       \宋体\四号}%
%     {\vfill
%       \noindent\黑体\三号 [关键词]：
%       \宋体\四号
%       \foreachitem\word\in\args{
%         \word
%         \ifthenelse{
%           \wordcnt < \argslen}
%           {；}{}
%       }
%     \end{spacing}
%     \vfill
%     \clearpage
% }
% \newenvironment{abstracten}[1]%
% {\setsepchar{{, }}\readlist\args{#1}
% \begin{spacing}{1.45}
%     \noindent\三号 [\textbf{ABSTRACT}]:
%     \四号}%
% {\vfill
%     \noindent\三号 [\textbf{Key words}]:
%     \四号
%     \foreachitem\word\in\args{
%     \word
%     \ifthenelse{
%         \wordcnt < \argslen}
%         {,}{}
%     }
% \end{spacing}
% \vfill\clearpage}