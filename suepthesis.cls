%%
%% This is file `suepthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% suepthesis.dtx  (with options: `cls,thesis')
%% 
%%     Copyright (C) 2023 HaiwenZhang
%% 
%% ------------------------------------------------------------------------------
%% 
%%     This work may be distributed and/or modified under the
%%     conditions of the LaTeX Project Public License, either
%%     version 1.3c of this license or (at your option) any later
%%     version. This version of this license is in
%%        http://www.latex-project.org/lppl/lppl-1-3c.txt
%%     and the latest version of this license is in
%%        http://www.latex-project.org/lppl.txt
%%     and version 1.3 or later is part of all distributions of
%%     LaTeX version 2020/11/27 or later.
%% 
%%     This work has the LPPL maintenance status `maintained'.
%% 
%%     The Current Maintainer of this work is Feng Kaiyu.
%% ------------------------------------------------------------------------------
%% 
\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{suepthesis}
{2023-03-05}{3.4.2}{SUEP Thesis Templates}
\int_new:N \g__suepthesis_thesis_type_int
\int_new:N \g__suepthesis_head_zihao_int
\bool_new:N \g__suepthesis_twoside_bool
\bool_new:N \g__suepthesis_thesis_type_english_bool
\bool_new:N \g__suepthesis_blind_mode_bool
\bool_new:N \g__suepthesis_quirks_mode_bool
\tl_new:N \g__suepthesis_label_divide_char_tl
\seq_new:N \l__suepthesis_right_seq
\seq_new:N \l__suepthesis_left_seq
\cs_generate_variant:Nn \tl_if_empty:nTF {x}
\cs_generate_variant:Nn \seq_set_split:Nnn {Nnx}
\cs_new:Npn \__suepthesis_same_page: {
  \let\clearpage\relax
  \let\cleardoublepage\relax
}
\cs_new:Npn \__suepthesis_if_graduate:TF #1#2 {
    \int_compare:nNnTF {3} < {\g__suepthesis_thesis_type_int}
      {#1}
      {#2}
  }

\cs_new:Npn \__suepthesis_if_thesis_int_type:nTF #1#2#3 {\int_compare:nNnTF {\g__suepthesis_thesis_type_int} = {#1} {#2} {#3}}
\cs_new:Npn \__suepthesis_if_thesis_int_type:nT #1#2 {\__suepthesis_if_thesis_int_type:nTF {#1} {#2} {}}

\cs_new:Npn \__suepthesis_if_thesis_english:TF #1#2 {\bool_if:nTF {\g__suepthesis_thesis_type_english_bool} {#1} {#2}}
\cs_new:Npn \__suepthesis_if_thesis_english:T #1 {\__suepthesis_if_thesis_english:TF {#1}{}}
\cs_new:Npn \__suepthesis_if_bachelor_thesis:TF #1#2 {\int_compare:nNnTF {\g__suepthesis_thesis_type_int} < {4} {#1} {#2}}
\cs_new:Npn \__suepthesis_if_bachelor_thesis:T #1 {\__suepthesis_if_bachelor_thesis:TF {#1} {}}
\cs_new:Npn \__suepthesis_if_master_thesis:TF #1#2 {\int_compare:nNnTF {\g__suepthesis_thesis_type_int} = {4} {#1} {#2}}
\cs_new:Npn \__suepthesis_if_doctor_thesis:TF #1#2 {\int_compare:nNnTF {\g__suepthesis_thesis_type_int} = {5} {#1} {#2}}
\clist_const:Nn \c__suepthesis_thesis_type_clist
    { bachelor, bachelor_translation, bachelor_english, master, doctor}
\clist_const:Nn \c__suepthesis_publication_modes_clist
    { biblatex, custom }
\cs_new_protected:Npn \__suepthesis_define_label:nn #1#2
  { \tl_const:cn { c__suepthesis_label_ #1 _tl } {#2} }

\cs_new_protected:Npn \__suepthesis_define_label_by_thesis_type:nnn #1#2#3
  {
    \tl_const:cn { c__suepthesis_ #1 _label_ #2 _tl } {#3}
  }

\cs_new_protected:Npn \__suepthesis_define_label:nnn #1#2#3
  {
    \tl_const:cn { c__suepthesis_label_ #1    _tl } {#2}
    \tl_const:cn { c__suepthesis_label_ #1 _en_tl } {#3}
  }

\cs_new_protected:Npn \__suepthesis_define_label_by_thesis_type:nnnn #1#2#3#4
  {
    \tl_const:cn { c__suepthesis_ #1 _label_ #2 _tl } {#3}
    \tl_const:cn { c__suepthesis_ #1 _label_ #2 _en_tl } {#4}
  }
\cs_new:Npn \smallgap: {
  \hspace{0.45ex}
}
\cs_new:Npn \label_space: {
  \__suepthesis_if_bachelor_thesis:T {
    \quad
  }
}
\clist_map_inline:nn
  {
    {code} {代码},
    {udc} {UDC分类号：},
    {classification} {中国分类号：},
    {classified_level} {密级},
    {type} {种类},
  }
  {\__suepthesis_define_label:nn #1}
\clist_map_inline:nn
  {
    {originality} {本科生毕业设计（论文）原创性声明},
    {originality_clause} {
      本人郑重申明：本人所呈交的毕业论文，是在指导老师的指导下独立进行研究所取得的成果。
      论文中凡引用他人已经发布或未发表的成果、数据、观点等，均已明确注明出处。
      论文中除已经注明引用的内容外，不包含任何其他个人或集体已经发表或撰写过的研究成果。
      对本文的研究成果做出重要贡献的个人和集体，均已在论文中以明确的方式标明。 \par
      本声明的法律责任由本人承担。
    },
    {authorization} {本科毕业设计（论文）使用授权声明},
    {authorization_clause} {
      本人在指导老师的指导下所完成的论文及相关的资料，
      知识产权归属上海电力大学。
      本人完全了解上海电力大学有关保存、使用毕业论文的规定，
      同意学校保存或向国家有关部门或机构送交论文的纸质版或电子版，
      允许论文被查阅或借阅。
      本人授权上海电力大学可以将本毕业论文的全部或部分内容编入有关数据库进行检索，
      可以采用任何复制手段保存或编汇本毕业论文。
      如果发表相关成果，一定征得指导教师同意，
      且第一署名单位为上海电力大学。
      本人毕业后使用毕业论文或与该论文直接相关的学术论文或成果时，
      第一署名单位仍然为上海电力大学。
    },
    {originality_author_signature}
      {论文作者签名：\hspace{40mm}日\hspace{2.5mm}期：\hspace{30mm}\quad},
    {originality_supervisor_signature}
      {指导老师签名：\hspace{40mm}日\hspace{2.5mm}期：\hspace{30mm}\quad},
  } 
  {\__suepthesis_define_label_by_thesis_type:nnn {bachelor} #1}

\clist_map_inline:nn
  {
    {school} {学\qquad 院} {School},
    {major} {专\qquad 业} {Degree},
    {class} {班\qquad{}级} {Class},
    {author} {学生姓名} {Author},
    {student_id} {学\qquad 号} {Student~ID},
    {supervisor} {指导教师} {Supervisor},
    {co_supervisor} {校外指导教师} {Co-Supervisor},
    {keywords} {关键词：} {Key~Words:~},
    {toc} {目\label_space: 录} {Table~of~Contents},
    {abstract} {摘\label_space: 要} {Abstract},
    {conclusion} {结\label_space: 论} {Conclusions},
    {appendix} {附\label_space: 录} {Appendices},
    {ack} {致\label_space: 谢} {Acknowledgement},
    {figure} {插\quad 图} {Illustrations},
    {table} {表\quad 格} {Tables},
    {appendix_prefix} {附录} {Appendix},
    {reference} {参考文献} {References},
    {university} {北京理工大学} {Beijing~Institute~of~Technology},
    {publications} {攻读学位期间发表论文与研究成果清单}
      {Publications~During~Studies},
    % TODO: Not so sure about the translation.
    {resume} {作者简介} {},
    {symbols} {主要符号对照表} {},
  }
  {\__suepthesis_define_label:nnn #1}

\clist_const:Nn \c__suepthesis_bachelor_thesis_header_clist
  {
    北京理工大学本科生毕业设计（论文）,
    北京理工大学本科生毕业设计（论文）外文翻译,
    Beijing~Institute~of~Technology~Bachelor's~Thesis
  }

\clist_const:Nn \c__suepthesis_bachelor_thesis_cover_title_clist
  {
    本科生毕业设计（论文）,
    本科生毕业设计（论文）外文翻译,
    Beijing\nobreak{~}Institute\nobreak{~}of\nobreak{~}Technology~Bachelor's~Thesis,
  }
\keys_define:nn { suepthesis }
{
  info .meta:nn = { suepthesis / info } {#1},
  misc .meta:nn = { suepthesis / misc } {#1},
  cover .meta:nn = { suepthesis / cover } {#1},
  style .meta:nn = { suepthesis / style } {#1},
  option .meta:nn = { suepthesis / option } {#1},
  TOC .meta:nn = { suepthesis / TOC } {#1},
  appendices .meta:nn = { suepthesis / appendices } {#1},
  publications .meta:nn = { suepthesis / publications } {#1},
}
\keys_define:nn { suepthesis / option }
{
  type .choice:,
  type .value_required:n = true,
  type .choices:Vn =
    \c__suepthesis_thesis_type_clist
    {
      \int_set_eq:NN \g__suepthesis_thesis_type_int \l_keys_choice_int
      \int_case:nn {\l_keys_choice_int} {
        % 本科全英文也是英文模板。
        {3} {\bool_set_true:N \g__suepthesis_thesis_type_english_bool}
      }
    },
  type .initial:n = bachelor,
  twoside .bool_gset:N = \g__suepthesis_twoside_bool,
  blindPeerReview .bool_gset:N = \g__suepthesis_blind_mode_bool,
  ctex .tl_set:N = \l__suepthesis_options_to_ctex_tl,
  quirks .bool_gset:N = \g__suepthesis_quirks_mode_bool,
}
\keys_define:nn { suepthesis / cover }
  {
    date .tl_set:N = \l__suepthesis_cover_date_tl,
    headerImage .tl_set:N = \l_bit_coverheaderimage_tl,
    xiheiFont .tl_set:N = \l__suepthesis_cover_xihei_font_path_tl,
    xiheiFont .default:n = {STXihei},
    %% cover entry
    dilimiter .tl_set:N = \l__suepthesis_cover_dilimiter_tl,
    labelAlign .tl_set:N = \l__suepthesis_cover_label_align_tl,
    labelAlign .initial:n = {r},
    valueAlign .tl_set:N = \l__suepthesis_cover_value_align_tl,
    valueAlign .initial:n = {c},
    labelMaxWidth .dim_set:N = \l__suepthesis_cover_label_max_width_dim,
    valueMaxWidth .dim_set:N = \l__suepthesis_cover_value_max_width_dim,
    autoWidthPadding .dim_set:N = \l__suepthesis_cover_auto_width_padding_dim,
    autoWidthPadding .initial:n = {0.25em},
    autoWidth .bool_set:N = \l__suepthesis_cover_auto_width_bool,
    autoWidth .initial:n = {true},
    underlineThickness .dim_set:N = \l__suepthesis_cover_underline_thickness_dim,
    underlineThickness .initial:n = {1pt},
    underlineOffset .dim_set:N = \l__suepthesis_cover_underline_offset_dim,
    underlineOffset .initial:n = { -10pt },
  }
\keys_define:nn { suepthesis / info }
  {
    title .tl_set:N = \l__suepthesis_value_title_tl,
    title .initial:n = {形状记忆聚氨酯的合成及其在织物中的应用（示例）},
    subtitle .tl_set:N = \l__suepthesis_value_subtitle_tl,
    subtitle .initial:n = {},
    titleEn .tl_set:N = \l__suepthesis_value_title_en_tl,
    titleEn .initial:n = {Synthesis~and~Application~on~Texttiles~of~the~Shape~Memory~Polyurethane~(example)},

    institution .tl_set:N = \l__suepthesis_value_institution_tl,
    institution .initial:n = {数理学院数学系},

    % 因为是覆盖选项，所以不需要设置初始值。
    verticalTitle .tl_set:N = \l__suepthesis_value_vertical_title_tl,
    school .tl_set:N = \l__suepthesis_value_school_tl,
    school .initial:n = {上海电力大学},

    major .tl_set:N = \l__suepthesis_value_major_tl,
    major .initial:n = {信息与计算科学专业},
    class .tl_set:N = \l__suepthesis_value_class_tl,
    class .initial:n = {2018级},

    author .tl_set:N = \l__suepthesis_value_author_tl,
    author .initial:n = {某同学},
    studentId .tl_set:N = \l__suepthesis_value_student_id_tl,
    studentId .initial:n = {2018****},
    supervisor .tl_set:N = \l__suepthesis_value_supervisor_tl,
    supervisor .initial:n = {某老师},
    % 因为默认不显示，所以不需要设置初始值。
    externalSupervisor .tl_set:N = \l__suepthesis_value_external_supervisor_tl,
    keywords .tl_set:N = \l__suepthesis_value_keywords_tl,
    keywords .initial:n = {聚氨酯,形状记忆,织物（示例）},
    keywordsEn .tl_set:N = \l__suepthesis_value_keywords_en_tl,
    keywordsEn .initial:n = {Polyurethane,Shape Memory,Textiles (example)},
    translationTitle .tl_set:N = \l__suepthesis_value_trans_title_tl,
    translationOriginTitle .tl_set:N = \l__suepthesis_value_trans_origin_title_tl,
    % 中国分类号，研究生学位论文使用
    classification .tl_set:N = \l__suepthesis_value_classification_tl,
    classification .initial:n = {TQ~028.1（示例）},
    % UDC 分类号，研究生学位论文使用
    UDC .tl_set:N = \l__suepthesis_value_udc_tl,
    UDC .initial:n = {540（示例）},
    chairman .tl_set:N = \l__suepthesis_value_chairman_tl,
    chairman .initial:n = {王五教授（示例）},
    degree .tl_set:N = \l__suepthesis_value_degree_tl,
    degree .initial:n = {工学博士（示例）},
    degreeEn .tl_set:N = \l__suepthesis_value_degree_en_tl,
    degreeEn .initial:n = {Doctor~of~Engineering~(example)},
    institute .tl_set:N = \l__suepthesis_value_institute_tl,
    institute .initial:n = {\c__suepthesis_label_university_tl},
    defenseDate .tl_set:N = \l__suepthesis_value_defense_date_tl,
    defenseDate .initial:n = {2019年6月（示例）},
    authorEn .tl_set:N = \l__suepthesis_value_author_en_tl,
    authorEn .initial:n = {San~Zhang~(example)},
    schoolEn .tl_set:N = \l__suepthesis_value_school_en_tl,
    schoolEn .initial:n = {School~of~Network~Space~Security\\(example)},
    supervisorEn .tl_set:N = \l__suepthesis_value_supervisor_en_tl,
    supervisorEn .initial:n = {Prof.~Si~Li~(example)},
    chairmanEn .tl_set:N = \l__suepthesis_value_chairman_en_tl,
    chairmanEn .initial:n = {Prof.~Wu~Wang~(example)},
    majorEn .tl_set:N = \l__suepthesis_value_major_en_tl,
    majorEn .initial:n = {Cyberspace~Security~and~Technology\\(example)},
    instituteEn .tl_set:N = \l__suepthesis_value_institute_en_tl,
    instituteEn .initial:n = {\c__suepthesis_label_university_en_tl},
    defenseDateEn .tl_set:N = \l__suepthesis_value_defense_date_en_tl,
    defenseDateEn .initial:n = {June,~2019~(example)},
    % 因为默认不显示，所以不需要设置初始值。
    classifiedLevel .tl_set:N = \l__suepthesis_value_classified_level_tl,
  }
\keys_define:nn { suepthesis / misc }
  {
    arialFont .tl_set:N = \l__suepthesis_misc_arial_font_path_tl,
  }

\keys_define:nn { suepthesis / style }
{
  head .tl_set:N = \l__suepthesis_style_head_tl,
  head .initial:n = {
    % \int_case:nn {\g__suepthesis_thesis_type_int}
    % {
    %   {1} {北京理工大学本科生毕业设计（论文）}
    %   {2} {北京理工大学本科生毕业设计（论文）外文翻译}
    %   {3} {Beijing~Institute~of~Technology~Bachelor's~Thesis}
    %   {4} {北京理工大学硕士学位论文}
    %   {5} {北京理工大学博士学位论文}
    % } 
  },
  bibliographyIndent .bool_set:N = \l__suepthesis_style_bibliography_indent_bool,
  bibliographyIndent .initial:n = {true},
}
\keys_define:nn { suepthesis / TOC }
{
  abstract .bool_set:N = \l__suepthesis_add_abstract_to_toc_bool,
  abstract .initial:n = {true},
  abstractEn .bool_set:N = \l__suepthesis_add_abstract_en_to_toc_bool,
  abstractEn .initial:n = {true},
  symbols .bool_set:N = \l__suepthesis_add_symbols_to_toc_bool,
  symbols .initial:n = {true},
}
\keys_define:nn { suepthesis / appendices }
{
  chapterLevel .bool_set:N = \l__suepthesis_appendices_chapter_level_bool,
  title .tl_set:N = \l__suepthesis_appendices_title_tl,
  TOCTitle .tl_set:N = \l__suepthesis_appendix_toc_title_tl,
}
\keys_define:nn { suepthesis / publications }
{
  % mode .choice:,
  % mode .value_required:n = true,
  % mode .choices:Vn =
  %   \c__suepthesis_publication_modes_clist
  %   {
  %     \int_new:N \l__suepthesis_publication_mode_int
  %     \int_set:Nn \l__suepthesis_publication_mode_int \l_keys_choice_int
  %   },
  % mode .initial:n = biblatex,
  sorting .bool_set:N = \l__suepthesis_publications_sorting_bool,
  sorting .initial:n = {true},
  omit .bool_set:N = \l__suepthesis_publications_omit_bool,
  omit .initial:n = {false},
  maxbibnames .int_set:N = \l__suepthesis_publications_maxbibnames_int,
  maxbibnames .initial:n = {3},
  minbibnames .int_set:N = \l__suepthesis_publications_minbibnames_int,
  minbibnames .initial:n = {1},
}
\ProcessKeysOptions { suepthesis / option }


\__suepthesis_if_thesis_english:T {
  \PassOptionsToClass{scheme=plain}{ctexbook}
}
\bool_if:NTF \g__suepthesis_twoside_bool {} {
  \PassOptionsToClass{oneside}{ctexbook}
}
\PassOptionsToClass{openany}{ctexbook}
\DeclareOption*{
  \PassOptionsToClass{\l__suepthesis_options_to_ctex_tl}{ctexbook}
}
\PassOptionsToPackage{quiet}{xeCJK}
\ProcessOptions\relax
\LoadClass[zihao=-4,]{ctexbook}
\RequirePackage{geometry}
\RequirePackage{xeCJK}
\RequirePackage{titletoc}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{pdfpages}
\RequirePackage{setspace}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{tikz}
\RequirePackage{etoolbox}
\RequirePackage[hidelinks,bookmarksnumbered]{hyperref}
\RequirePackage{xcolor}
\RequirePackage{caption}
\RequirePackage{array}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{pifont}
\RequirePackage{amsthm}
\RequirePackage{unicode-math}
\RequirePackage{pdfpages}
\RequirePackage{listings}
\RequirePackage{enumitem}
\RequirePackage{fmtcount}
\RequirePackage[most,minted]{tcolorbox}
\RequirePackage{minted}
\RequirePackage{ulem}
\RequirePackage{tabularray}


% 关于图片 graphicx
 % 如果图片没有指定后缀, 依次按下列顺序搜索
 \DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png,.tif}
 % 设置图表搜索路径, 可以给图表文件夹取如下名字
\graphicspath{{figures/}{figure/}{pictures/}%
  {picture/}{pic/}{pics/}{image/}{images/}}


% ==============================================================================
% 字体设置
% ==============================================================================

% 英文默认为Times New Roman
\setmainfont[Path=./fonts/, BoldFont={*Bold}, ItalicFont={*Italic}, BoldItalicFont={*BoldItalic}]{TimesNewRoman}

% 伪粗体等级
% \xeCJKsetup{EmboldenFactor=3} 
% 宋体
\renewcommand{\songti}{\CJKfontspec[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold={3.17}]{simsun.ttc}}
% 中文默认为宋体,小四在\documentclass处设置
\setCJKmainfont[Path=fonts/,FallBack=simsunb.ttf,AutoFakeBold={3.17}]{simsun.ttc} 
% \newcommand{\宋体}{\songti}

% 黑体
\renewcommand{\heiti}{\CJKfontspec[Path=fonts/,AutoFakeBold={3.17}]{simhei.ttf}}
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


\pdfstringdefDisableCommands{%
  \let\quad\empty
}

\__suepthesis_if_graduate:TF {
  \int_set:Nn \g__suepthesis_head_zihao_int {5}
  \geometry{
    a4paper,
    left=2.7cm,
    bottom=2.5cm + 7bp,
    top=3.5cm + 7bp,
    right=2.7cm,
    % `headsep' is affected by `top' option.
    headsep = 3.5cm + 7bp - 2.5cm - 15bp,
    headheight = 15 bp,
    % `footskip' is affected by `bottom' option.
    footskip = 2.5cm + 7bp - 1.8cm,
  }
} {
  \int_set:Nn \g__suepthesis_head_zihao_int {4}
  \geometry{
    a4paper,
    left=3cm,
    bottom=2.6cm + 7bp,
    top=3.5cm + 7bp,
    right=2.6cm,
    % `headsep' is affected by `top' option.
    headsep = 3.5cm + 7bp - 2.4cm - 20bp,
    headheight = 20 bp,
    % `footskip' is affected by `bottom' option.
    footskip = 2.6cm + 7bp - 2cm,
  }
}
\__suepthesis_if_bachelor_thesis:T {
  \setlength{\intextsep}{2\baselineskip plus 0.2\baselineskip minus 0.2\baselineskip}
}
\setmainfont{Times~New~Roman}
\setromanfont{Times~New~Roman}
\ctex_at_end_preamble:n {
  \__suepthesis_if_thesis_english:TF {
    \__suepthesis_if_thesis_int_type:nT {3} {
      % 对于本科全英文专业模板
      % Font Arial is needed.
      \newfontfamily\arialfamily{Arial}
    }

  } {
    % 对于其他的中文模板，
    % 需要加载细黑体。
    \tl_if_blank:VTF \l__suepthesis_cover_xihei_font_path_tl {}
    {
      \setCJKfamilyfont{xihei}[AutoFakeBold,AutoFakeSlant]
        {\l__suepthesis_cover_xihei_font_path_tl}
    }
  }

  % 对于本科全英文专业模板，需要自定义日期格式。
  \__suepthesis_if_thesis_int_type:nT {3} {
    \RequirePackage[en-US]{datetime2}
    \RequirePackage{indentfirst}
    \DTMlangsetup[en-US]{dayyearsep={\space}}
  }

  % Define biblatex category if it was imported.
  % 这部分是给研究生模板中的
  % 「攻读学位期间发表论文与研究成果清单」使用的。
  \cs_if_exist:NT \DeclareBibliographyCategory {
    \DeclareBibliographyCategory{mypub}
  }

  % 修改 biblatex 中「专利」（patent）部分的著录格式。
  % 主要根据北理工自定义的规范，参考 biblatex 和
  % biblatex-gb7714-2015 的实现修改而成。
  %
  % 默认不开启，因为此修改可能会产生其他边界问题。
  \bool_if:NT \g__suepthesis_quirks_mode_bool {
    \cs_if_exist:NT \DeclareBibliographyDriver {
      %
      %   重设专利title的输出，将文献类型标识符输出出去
      %
      \newbibmacro*{patenttitle}{%原输出来自biblatex.def文件
        \ifboolexpr{%
          test{\iffieldundef{title}}%
          and%
          test{\iffieldundef{subtitle}}%
        }%
          {}%
          {\printtext[title]{\bibtitlefont%
             \printfield[titlecase]{title}%
             \ifboolexpr{test {\iffieldundef{subtitle}}}%这里增加了对子标题的判断，解决不判断多一个点的问题
             {}{\setunit{\subtitlepunct}%
             \printfield[titlecase]{subtitle}}%
              \iftoggle{bbx:gbtype}{\printfield[gbtypeflag]{usera}}{}%
             \iffieldundef{titleaddon}{}%判断一下titleaddon，否则直接加可能多一个空格
              {\setunit{\subtitlepunct}\printfield{titleaddon}}%
              % ：地区
              \setunit{\subtitlepunct}\iflistundef{location}
                {}
                {\setunit*{\subtitlepunct}%
                 \printtext{%[parens]
                   \printlist[][-\value{listtotal}]{location}}}%
              % ，专利号
              \setunit{\addcomma\addspace}\printfield{number}%写专利号
              \setunit{\addcomma\addspace}
              \usebibmacro{newsdate}%
           }%
        }%
      }

      %
      %   重定义专利文献驱动
      %
        \DeclareBibliographyDriver{patent}{%源来自standard.BBX
        \usebibmacro{bibindex}%
        \usebibmacro{begentry}%
        \usebibmacro{author}%
        \ifnameundef{author}{}{\setunit{\labelnamepunct}\newblock}%这一段用于去除作者不存在时多出的标点
        \usebibmacro{patenttitle}%给出专利专用的标题输出
        \iftoggle{bbx:gbstrict}{}{%
          \newunit%
          \printlist{language}%
          \newunit\newblock
          \usebibmacro{byauthor}
        }%
        \newunit\newblock
        \printfield{type}%
        \setunit*{\addspace}%
        \newunit\newblock
        \usebibmacro{byholder}%
        \newunit\newblock
        \printfield{note}%
        \newunit\newblock
        \usebibmacro{doi+eprint+url}%
        \newunit\newblock
        \usebibmacro{addendum+pubstate}%
        \setunit{\bibpagerefpunct}\newblock
        \usebibmacro{pageref}%
        \newunit\newblock
        \iftoggle{bbx:related}
          {\usebibmacro{related:init}%
           \usebibmacro{related}}
          {}%
        \usebibmacro{annotation}\usebibmacro{finentry}}
    }
  }
}
\cs_new:Npn \xihei:n #1 {
  \xeCJK_family_if_exist:nTF {xihei} {
    \CJKfamily{xihei} #1
  }{
    \heiti #1
  }
}
\cs_new:Npn \l__suepthesis_title_font_cs:n #1 {
  \int_compare:nNnTF {\g__suepthesis_thesis_type_int} = {3}
  {
    \arialfamily #1
  } {
    \heiti #1
  }
}
\cs_new:Npn \l__suepthesis_unnumchapter_style_cs:n #1 {
  % 本科全英文、研究生学位论文需要加粗
  \int_compare:nNnTF {\g__suepthesis_thesis_type_int} > {2}
  {
    \bfseries #1
  } {
    \mdseries #1
  }
}
\cs_set:Npn \arabicHeiti #1 {#1}

\fancypagestyle{suepthesis}{
  \fancyhf{}
  % 定义页眉、页码
  \fancyhead[C]{
    \xiaowu
    \ziju{0.08}
    \songti{\tl_use:N \l__suepthesis_value_title_tl \l__suepthesis_value_subtitle_tl}
  }
  \fancyfoot[C]{\songti\zihao{5} -\ \thepage\ -}
  % 页眉分割线稍微粗一些
  \RenewDocumentCommand \headrulewidth {} {0.6pt}
}

% 一级标题格式：第*章  后空一格（全角）黑体　小三号字　居中 1.5倍行距 段前0行 段后0.5行
\ctexset{chapter={
    % number = {\arabicHeiti{ \arabic{chapter} }},
    % number = {chapter},
    format = { \xiaosan \heiti \centering },
    nameformat = {},
    titleformat = {},
    % aftername = \hspace{9bp},
    aftername = \quad,
    pagestyle = suepthesis,
    beforeskip = 8bp,
    afterskip = 32bp,
    fixskip = true,
  }
}

% 二级标题格式： 1.1（半角）  后空一格(全角) 黑体四号字 居左 1.5倍行距 段前0.5行 段后0行
\ctexset{section={
    % number = {\arabicHeiti{\thechapter.\hspace{1bp}\arabic{section}}},
    number = {
      \thechapter.\hspace{1bp}
      \arabic{section}
    },
    format = {\sihao \heiti \raggedright},
    nameformat = {},
    titleformat = {},
    aftername = \quad,
    beforeskip = 20bp plus 1ex minus .2ex,
    afterskip = 18bp plus .2ex,
    fixskip = true,
  }
}

% 三级标题格式： 1.1.1（半角）前空两格、后空一格（全角） 黑体小四号字 居左 1.5倍行距 段前0.5行 段后0行
\ctexset{subsection={
    number = {
        \thechapter.\hspace{1bp}
        \arabic{section}.\hspace{1bp}
        \arabic{subsection}
    },
    format = {\xiaosi \heiti \raggedright},
    nameformat = {},
    titleformat = {},
    aftername = \quad,
    beforeskip = 17bp plus 1ex minus .2ex,
    afterskip = 14bp plus .2ex,
    fixskip = true,
  }
}

\ctexset{
  secnumdepth = 3,
  subsubsection={
    numbering = true,
    number = {
      \arabic{chapter}.\hspace{1bp}
      \arabic{section}.\hspace{1bp}
      \arabic{subsection}.\hspace{1bp}
      \arabic{subsubsection}
    },
    format={\xiaosi \heiti \raggedright},
    nameformat = {},
    titleformat = {},
    beforeskip=28bp plus 1ex minus .2ex,
    afterskip=24bp plus .2ex,
    fixskip=true,
  }
}
\addtocontents{toc}{\protect\hypersetup{hidelinks}}

\__suepthesis_if_graduate:TF {
  % 对于研究生模板，定义各章标题为宋体四号。
  \titlecontents{chapter}[0pt]{\songti \zihao{4}}
  {\thecontentslabel\hspace{\ccwd}}{}
  {\hspace{.5em}\titlerule*{.}\contentspage}
} {
  % 对于其他，定义各章标题为宋体小四号。
  \titlecontents{chapter}[0pt]{\songti \zihao{-4}}
  {\thecontentslabel\hspace{\ccwd}}{}
  {\hspace{.5em}\titlerule*{.}\contentspage}
}
\titlecontents{section}[1\ccwd]{\songti \zihao{-4}}
{\thecontentslabel\hspace{\ccwd}}{}
{\hspace{.5em}\titlerule*{.}\contentspage}
\titlecontents{subsection}[2\ccwd]{\songti \zihao{-4}}
{\thecontentslabel\hspace{\ccwd}}{}
{\hspace{.5em}\titlerule*{.}\contentspage}

\RenewDocumentCommand \frontmatter {} {
  \int_compare:nNnTF {\g__suepthesis_thesis_type_int} = {3}
  {
    % 本科全英文专业论文，页码使用小罗马数字。
    \pagenumbering{roman}
  } {
    \pagenumbering{Roman}
  }
  % 这部分的章节标题不进行编号。
  \ctexset{
    chapter = {
      numbering = false,
    }
  }
  \pagestyle{suepthesis}
}

\RenewDocumentCommand \mainmatter {} {
  % 这部分的章节标题进行编号。
  \ctexset{
    chapter = {
      numbering = true,
    }
  }
  % 页码使用阿拉伯数字。
  \pagenumbering{arabic}
  \pagestyle{suepthesis}
  % 正文 22 磅的行距
  \setlength{\parskip}{0em}
  \setstretch{1.53}
  % 修复脚注出现跨页的问题
  \interfootnotelinepenalty=10000
}

\RenewDocumentCommand \backmatter {} {
  % 同样，所有的章节标题不进行编号。
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \setcounter{subsubsection}{0}
  \ctexset{
    chapter = {
      numbering = false,
      beforeskip = 18bp,
      format = {
        \l__suepthesis_title_font_cs:n \l__suepthesis_unnumchapter_style_cs:n \centering \zihao{3}
      },
      afterskip = 26bp,
    }
  }
}

\setlength{\abovecaptionskip}{11pt}
\setlength{\belowcaptionskip}{9pt}

\__suepthesis_if_graduate:TF {
  \tl_set:Nn \g__suepthesis_label_divide_char_tl {.}
} {
  \tl_set:Nn \g__suepthesis_label_divide_char_tl {-}
}
\cs_set:Npn \thefigure {\thechapter\g__suepthesis_label_divide_char_tl\arabic{figure}}
\captionsetup[figure]{font=small,labelsep=space}

\cs_set:Npn \thetable {\thechapter\g__suepthesis_label_divide_char_tl\arabic{table}}
\captionsetup[table]{font=small,labelsep=space,skip=2pt}

\cs_set:Npn \theequation {\thechapter\g__suepthesis_label_divide_char_tl\arabic{equation}}

\cs_set:Npn \thelstlisting {\thechapter\g__suepthesis_label_divide_char_tl\arabic{lstlisting}}
\cs_set:Npn \lstlistingname {\c__suepthesis_label_code_tl}
\tolerance=1
\emergencystretch=\maxdimen
\hyphenpenalty=10000
\hbadness=10000
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}
\lstdefinestyle{examplestyle}{
    backgroundcolor=\color{backcolour},
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2
}
\lstset{style=examplestyle}
\cs_set:Npn \listfigurename {\c__suepthesis_label_figure_tl}
\cs_set:Npn \listtablename {\c__suepthesis_label_table_tl}
\unimathsetup{
  math-style = ISO,
  bold-style = ISO,
}
\theoremstyle{plain}
  \newtheorem{algo}{算法}[chapter]
  \newtheorem{them}{定理}[chapter]
  \newtheorem{lem}[them]{引理}
  \newtheorem{prop}[them]{命题}
  \newtheorem{cor}[them]{推论}
  \newtheorem{axi}[them]{公理}
\theoremstyle{definition}
  \newtheorem{defn}{定义}[chapter]
  \newtheorem{conj}{猜想}[chapter]
  \newtheorem{exmp}{例}[chapter]
  \newtheorem{case}{情形}
\theoremstyle{remark}
  \newtheorem{rem}{注}
  \renewcommand{\qedsymbol}{\ensuremath{\QED}}
\cs_new:Npn \__suepthesis_dunderline:nnn #1#2#3 {
  {\setbox0=\hbox{#3}\ooalign{\copy0\cr\rule[\dimexpr#1-#2\relax]{\wd0}{#2}}}
}
\cs_new:Npn \__suepthesis_dunderline:nn #1#2 {
  \__suepthesis_dunderline:nnn {#1} {1pt} {#2}
}
\cs_new:Npn \__suepthesis_dunderline:n #1 {
  \__suepthesis_dunderline:nnn {-10pt} {1pt} {#1}
}
\newcommand\dunderline[3][-1pt]{{%
  \setbox0=\hbox{#3}
  \ooalign{\copy0\cr\rule[\dimexpr#1-#2\relax]{\wd0}{#2}}}}

\cs_new:Npn \__suepthesis_render_cover_entry:nn #1#2 {
  \makebox[\l__suepthesis_cover_label_max_width_dim][\l__suepthesis_cover_label_align_tl]{
    \tl_if_blank:VTF #1 {} {#1\l__suepthesis_cover_dilimiter_tl}
  }
  \hspace{1ex}
  \__suepthesis_dunderline:nnn{\l__suepthesis_cover_underline_offset_dim}
    {\l__suepthesis_cover_underline_thickness_dim}{
    \makebox[\l__suepthesis_cover_value_max_width_dim][\l__suepthesis_cover_value_align_tl]{#2}
  }\par
}

\cs_new:Npn \__suepthesis_get_text_width:Nn #1#2
  {
    \hbox_set:Nn \l_tmpa_box {#2}
    \dim_set:Nn #1 { \box_wd:N \l_tmpa_box }
  }
\cs_generate_variant:Nn \__suepthesis_get_text_width:Nn { NV }
\cs_new:Npn \__suepthesis_get_max_text_width:NN #1#2
  {
    \group_begin:
      \seq_set_eq:NN \l__suepthesis_tmpa_seq #2
      \dim_zero_new:N \l__suepthesis_tmpa_dim
      \bool_until_do:nn { \seq_if_empty_p:N \l__suepthesis_tmpa_seq }
        {
          \seq_pop_left:NN \l__suepthesis_tmpa_seq \l__suepthesis_tmpa_tl
          \__suepthesis_get_text_width:NV \l__suepthesis_tmpa_dim \l__suepthesis_tmpa_tl
          % 在两边加上空白，避免文本太靠边。
          \dim_gset:Nn #1 { \dim_max:nn {#1} { \l__suepthesis_tmpa_dim + \l__suepthesis_cover_auto_width_padding_dim * 2} }
        }
    \group_end:
  }
\cs_new:Npn \__suepthesis_parse_entry #1 #2 {
  \seq_set_split:Nnx \l__suepthesis_tmp_right_seq {\\} {#2}
  \seq_clear:N \l__suepthesis_tmp_left_seq
  \seq_map_inline:Nn \l__suepthesis_tmp_right_seq {
    \seq_put_right:Nn \l__suepthesis_tmp_left_seq {}
  }
  \seq_put_left:Nn \l__suepthesis_tmp_left_seq {#1}
  \seq_pop_right:NN \l__suepthesis_tmp_left_seq \g__suepthesis_trashcan_tl
}
\cs_new:Npn \__suepthesis_render_cover_entry:n #1 {
  % 左边是标签，右边是值。
  % 形如：
  % { {label_1} {value_1}, {label_2} {value 2} }
  % 首先转换成 seq 类型。
  \seq_set_from_clist:NN \l__suepthesis_input_seq #1
  \seq_map_inline:Nn \l__suepthesis_input_seq {
    % 然后对于每一对 label 和 value，首先查找
    % value 中是否含有 \\ 字符，如果有，则将其分割成多个
    % label - value 对。
    % 比如 {label_1} {value \\ 1} 会被转换成
    % { {label_1} {value}, {} {1} }
    \__suepthesis_parse_entry ##1
    % 然后将这些 label - value 对添加到 \l__suepthesis_right_seq
    % 或者 \l__suepthesis_left_sql 中。
    % left 就是 label，right 就是 value。
    \seq_concat:NNN \l__suepthesis_right_seq \l__suepthesis_right_seq \l__suepthesis_tmp_right_seq
    \seq_concat:NNN \l__suepthesis_left_seq \l__suepthesis_left_seq \l__suepthesis_tmp_left_seq
  }

  % 如果用户选择自动计算最大宽度，则计算最大宽度。
  \bool_if:NT \l__suepthesis_cover_auto_width_bool {
    \__suepthesis_get_max_text_width:NN \l__suepthesis_cover_label_max_width_dim \l__suepthesis_left_seq
    \__suepthesis_get_max_text_width:NN \l__suepthesis_cover_value_max_width_dim \l__suepthesis_right_seq
  }

  % 最后，根据宽度渲染 label 和 value 对。
  \group_begin:
    \bool_until_do:nn { \seq_if_empty_p:N \l__suepthesis_left_seq }
      {
        \seq_pop_left:NN \l__suepthesis_left_seq \l__suepthesis_tmpa_tl
        \seq_pop_left:NN \l__suepthesis_right_seq \l__suepthesis_tmpb_tl
        \tl_if_empty:xTF \l__suepthesis_tmpb_tl {} {
          \__suepthesis_render_cover_entry:nn {\l__suepthesis_tmpa_tl} {\l__suepthesis_tmpb_tl}
        }
      }
  \group_end:
}
% \cs_new:Npn \make_graduate_cover: {
%   \cleardoublepage
%   \begin{titlepage}
%     {
%       \heiti\zihao{5}
%       \tl_if_blank:VTF \l__suepthesis_value_classified_level_tl {} {
%         \flushright
%         \c__suepthesis_label_classified_level_tl：~
%         \l__suepthesis_value_classified_level_tl \par
%       }
%     }
%     \centering
%     \vspace*{65mm}
%     {\heiti\zihao{-2} \l__suepthesis_value_title_tl}
%     \vskip 60mm
%     % 黑体 小三
%     {\heiti \zihao{-3} \l__suepthesis_value_author_tl}
%     \vskip 10mm
%     % 黑体 小三
%     {\heiti \zihao{-3} \l__suepthesis_cover_date_tl}
%   \end{titlepage}
% }
% \cs_new:Npn \make_paper_back: {
%   \cleardoublepage
%   \begin{titlepage}
%    \vskip 5cm
%    \begin{center}
%     \setstretch{1.1}
%     \begin{minipage}[t][19.7cm]{2em}
%       \begin{center}
%         {
%           \heiti\zihao{3}
%           \tl_if_blank:VTF \l__suepthesis_value_vertical_title_tl
%             {\l__suepthesis_value_title_tl}{\l__suepthesis_value_vertical_title_tl}
%         }
%           \vfill
%         {\heiti\zihao{3}\l__suepthesis_value_author_tl}
%           \vfill
%         {\heiti\zihao{3}\c__suepthesis_label_university_tl}
%       \end{center}
%     \end{minipage}
%    \end{center}
%    % \vskip 5cm
%   \end{titlepage}
% }
% \cs_new:Npn \__suepthesis_make_chinese_title_page: {
%   \cleardoublepage
%   \begin{titlepage}
%       {
%         % 密级、分类号
%         {\heiti \zihao{5} \noindent \c__suepthesis_label_classification_tl}
%         \l__suepthesis_value_classification_tl\\
%         {\heiti \zihao{5} \c__suepthesis_label_udc_tl}  \l__suepthesis_value_udc_tl
%       }

%      \begin{center}

%       \vskip \stretch{1}

%          {\heiti\zihao{-2} \l__suepthesis_value_title_tl}

%       \vskip \stretch{1}

%       \def\tabcolsep{1pt}
%       \def\arraystretch{1.5}

%       {
%         \renewcommand{\baselinestretch}{2}

%         \tl_if_empty:NT \l__suepthesis_cover_dilimiter_tl {
%           \tl_set:Nn \l__suepthesis_cover_dilimiter_tl {\qquad}
%         }
%         \tl_set:Nn \l__suepthesis_cover_underline_offset_dim {-5pt}

%         % 如果不是自动计算宽度，且用户没有自定义宽度，
%         % 则尝试提供一个默认宽度。
%         \bool_if:NF \l__suepthesis_cover_auto_width_bool {
%           \dim_compare:nNnT {\l__suepthesis_cover_label_max_width_dim} = {0pt} {
%             \dim_set:Nn \l__suepthesis_cover_label_max_width_dim {55mm}
%           }
%           \dim_compare:nNnT {\l__suepthesis_cover_value_max_width_dim} = {0pt} {
%             \dim_set:Nn \l__suepthesis_cover_value_max_width_dim {70mm}
%           }
%         }

%         % 渲染信息。
%         \clist_set:Nn \l__suepthesis_input_clist {
%             {\c__suepthesis_graduate_label_author_tl} {\l__suepthesis_value_author_tl},
%             {\c__suepthesis_graduate_label_school_tl} {\l__suepthesis_value_school_tl},
%             {\c__suepthesis_graduate_label_supervisor_tl} {\l__suepthesis_value_supervisor_tl},
%             {\c__suepthesis_graduate_label_chairman_tl} {\l__suepthesis_value_chairman_tl},
%             {\c__suepthesis_graduate_label_degree_tl} {\l__suepthesis_value_degree_tl},
%             {\c__suepthesis_graduate_label_major_tl} {\l__suepthesis_value_major_tl},
%             {\c__suepthesis_graduate_label_institute_tl} {\l__suepthesis_value_institute_tl},
%             {\c__suepthesis_graduate_label_defense_date_tl} {\l__suepthesis_value_defense_date_tl},
%          }

%         \heiti\zihao{-3}
%         \__suepthesis_render_cover_entry:n \l__suepthesis_input_clist
%       }
%     \end{center}
%     \vskip \stretch{0.5}
%   \end{titlepage}
% }

% \cs_new:Npn \__suepthesis_make_english_title_page: {
%   \begin{titlepage}
%     \begin{center}

%     \vspace*{10em}

%     {
%       \zihao{-2}
%       \textbf{\l__suepthesis_value_title_en_tl}
%     }

%     \vskip \stretch{1}

%     {
%       \tl_if_empty:NT \l__suepthesis_cover_dilimiter_tl {
%         \tl_set:Nn \l__suepthesis_cover_dilimiter_tl {:~}
%       }

%       \tl_set:Nn \l__suepthesis_cover_label_align_tl {l}
%       \tl_set:Nn \l__suepthesis_cover_underline_offset_dim {-5pt}

%       % 如果不是自动计算宽度，且用户没有自定义宽度，
%       % 则尝试提供一个默认宽度。
%       \bool_if:NF \l__suepthesis_cover_auto_width_bool {
%         \dim_compare:nNnT {\l__suepthesis_cover_label_max_width_dim} = {0pt} {
%           \dim_set:Nn \l__suepthesis_cover_label_max_width_dim {55mm}
%         }
%         \dim_compare:nNnT {\l__suepthesis_cover_value_max_width_dim} = {0pt} {
%           \dim_set:Nn \l__suepthesis_cover_value_max_width_dim {85mm}
%         }
%       }

%       % 渲染信息。
%       \clist_set:Nn \l__suepthesis_input_clist {
%           {\c__suepthesis_graduate_label_author_en_tl} {\l__suepthesis_value_author_en_tl},
%           {\c__suepthesis_graduate_label_school_en_tl} {\l__suepthesis_value_school_en_tl},
%           {\c__suepthesis_graduate_label_supervisor_en_tl} {\l__suepthesis_value_supervisor_en_tl},
%           {\c__suepthesis_graduate_label_chairman_en_tl} {\l__suepthesis_value_chairman_en_tl},
%           {\c__suepthesis_graduate_label_degree_en_tl} {\l__suepthesis_value_degree_en_tl},
%           {\c__suepthesis_graduate_label_major_en_tl} {\l__suepthesis_value_major_en_tl},
%           {\c__suepthesis_graduate_label_institute_en_tl} {\l__suepthesis_value_institute_en_tl},
%           {\c__suepthesis_graduate_label_defense_date_en_tl} {\l__suepthesis_value_defense_date_en_tl},
%        }

%       \zihao{-3}
%       \__suepthesis_render_cover_entry:n \l__suepthesis_input_clist
%     }

%     \end{center}

%     \vskip \stretch{0.5}
%   \end{titlepage}
% }

\newcommand{\circled}[2][]{\tikz[baseline=(char.base)]
  {\node[shape = circle, draw, inner~sep = 1pt]
  (char) {\phantom{\ifblank{#1}{#2}{#1}}};
  \node at (char.center) {\makebox[0pt][c]{#2}};}}
\robustify{\circled}

\cs_new:Npn \__suepthesis_ungraduate_originality:
  {
    % 取消页眉页脚。
    \ctexset {
      chapter / pagestyle = plain,
    }

    \begin{titlepage}
      \newgeometry{%
      top=3.57cm,bottom=2.54cm,
      left=3.17cm,right=3.17cm
      }
      % 不计算页码。
      \pagenumbering{gobble}

      % 原创性声明部分
      \begin{center}
        \__suepthesis_same_page:
        \heiti\xiaoer
        \l__suepthesis_value_school_tl \par
        \c__suepthesis_bachelor_label_originality_tl
      \end{center}~\par

      \songti\sihao
      \linespread{2}
      \c__suepthesis_bachelor_label_originality_clause_tl

      \vspace{17mm}

      \begin{flushright}
        \c__suepthesis_bachelor_label_originality_author_signature_tl\par
      \end{flushright}
    \end{titlepage}

    \newpage
    
    \begin{titlepage}
      \newgeometry{%
      top=3.57cm,bottom=2.54cm,
      left=3.17cm,right=3.17cm
      }
      % 使用授权声明部分。
      \begin{center}
        \__suepthesis_same_page:
        \heiti\xiaoer
        \l__suepthesis_value_school_tl \par
        \c__suepthesis_bachelor_label_authorization_tl
      \end{center}~\par

      \songti\sihao
      \linespread{2}
      \c__suepthesis_bachelor_label_authorization_clause_tl

      \vspace*{15mm}

      \begin{flushright}
        \c__suepthesis_bachelor_label_originality_author_signature_tl\par
        \vspace*{5ex}
        \c__suepthesis_bachelor_label_originality_supervisor_signature_tl\par
      \end{flushright}
    \end{titlepage}
    \cleardoublepage
  }
\DeclareDocumentCommand \SUEPSetup { m }
  { \keys_set:nn { suepthesis } { #1 }}

\DeclareDocumentCommand \BigStar { }
  { \ding{72} }
  \NewDocumentEnvironment {blindPeerReview} {O{\c_true_bool} +b}
  {
    \bool_if:nTF {\g__suepthesis_blind_mode_bool && #1} {} {
      #2
    }
  } {}

% \begin{macro}{\cleardoublepage}
% 重定义 \tn{cleardoublepage}，使得偶数页面在没有内容时也不显示页眉页脚，见
% \url{https://tex.stackexchange.com/a/1683}。
%    \begin{macrocode}
\RenewDocumentCommand \cleardoublepage { }
  {
    \clearpage
    \bool_if:NT \g__suepthesis_twoside_bool
      {
        \int_if_odd:nF \c@page
          { \hbox:n { } \thispagestyle { empty } \newpage }
      }
  }

\def\ubox@right@shift{0.5\ccwd}
\def\cover@tab@entry@width{210pt}
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

\DeclareDocumentCommand \MakeCover {}
  {
    \begin{blindPeerReview}
    \group_begin:

    \int_case:nn {\g__suepthesis_thesis_type_int}
    {
      {1}
      {
        \begin{titlepage}
          % \vspace*{16mm}

          \centering

          % \tl_if_blank:VTF \l_bit_coverheaderimage_tl {} {
          %   \includegraphics[width=9.87cm]{\l_bit_coverheaderimage_tl}\\
          % }

          \chuhao\textbf{\kaiti{上海电力大学}} \par

          % \vspace*{-3mm}
          % \zihao{-0}\textbf{\ziju{0.12}\songti{\c__suepthesis_bachelor_label_title_tl}}\par

          \vspace{16mm}

          % \zihao{2}\textbf{\xihei:n \l__suepthesis_value_title_tl}\par

          % \vspace{3mm}

          % \begin{spacing}{1.2}
          %   \zihao{3}\selectfont{\textbf{\l__suepthesis_value_title_en_tl}}\par
          % \end{spacing}
          
          \xiaochu\textbf{\STfangsong{本科毕业设计（论文）}}\par


          \vspace{15mm}

          \includegraphics[width=4.82cm, height=4.82cm]{logo} \par

          \vspace{15mm}

          % \vskip 40pt
          {
            \songti
            \sihao
            % 调整列距
            \def\tabcolsep{0.5pt}
            % 调整行距
            \def\arraystretch{1.4}
            \begin{tabular}{rcrc}
              题 \qquad 目：& \multicolumn{3}{c}{
                  \suep@cover@uline{\suep@cover@bigbox{\l__suepthesis_value_title_tl}}
              }  \\
  
              & \multicolumn{3}{c}{
                  \suep@cover@uline{\suep@cover@bigbox{\l__suepthesis_value_subtitle_tl}}
              }   \\
  
              院 \qquad 系：& \multicolumn{3}{c}{
                  \suep@cover@uline{\suep@cover@bigbox{\l__suepthesis_value_institution_tl}}
              } \\
  
              专业年级：& \multicolumn{3}{c}{
                  \suep@cover@uline{\suep@cover@bigbox{\l__suepthesis_value_class_tl}} 
              } \\
  
              学生姓名：& \suep@cover@uline{\suep@cover@smallbox{\l__suepthesis_value_author_tl}}  
              & 学号： &  \suep@cover@uline{\suep@cover@smallbox{\l__suepthesis_value_student_id_tl}}  \\
  
              指导老师：& \multicolumn{3}{c}{
                  \suep@cover@uline{\suep@cover@bigbox{\l__suepthesis_value_supervisor_tl}}  
              } \\
            \end{tabular} 
          }

        
          % \begin{spacing}{1.8}
          %   \begin{center}

          %   \tl_if_empty:NT \l__suepthesis_cover_dilimiter_tl {
          %     \tl_set:Nn \l__suepthesis_cover_dilimiter_tl {：}
          %   }
          %   % if not auto width, try override width
          %   \bool_if:NF \l__suepthesis_cover_auto_width_bool {
          %     \dim_compare:nNnT {\l__suepthesis_cover_label_max_width_dim} = {0pt} {
          %       \dim_set:Nn \l__suepthesis_cover_label_max_width_dim {35mm}
          %     }
          %     \dim_compare:nNnT {\l__suepthesis_cover_value_max_width_dim} = {0pt} {
          %       \dim_set:Nn \l__suepthesis_cover_value_max_width_dim {78mm}
          %     }
          %   }

          %   \clist_set:Nn \l__suepthesis_input_clist {
          %     {\c__suepthesis_label_school_tl} {\l__suepthesis_value_school_tl},
          %     {\c__suepthesis_label_major_tl} {\l__suepthesis_value_major_tl},
          %     {\c__suepthesis_label_class_tl} {\l__suepthesis_value_class_tl},
          %     {\c__suepthesis_label_author_tl} {\l__suepthesis_value_author_tl},
          %     {\c__suepthesis_label_student_id_tl} {\l__suepthesis_value_student_id_tl},
          %     {\c__suepthesis_label_supervisor_tl} {\l__suepthesis_value_supervisor_tl},
          %     {\c__suepthesis_label_co_supervisor_tl} {\l__suepthesis_value_external_supervisor_tl},
          %   }

          %   \zihao{3}

          %   \__suepthesis_render_cover_entry:n \l__suepthesis_input_clist

          %   \end{center}
          % \end{spacing}
          \par

          \vspace*{\fill}

          \centering

          \sihao\ziju{0.5}\songti{
            \tl_if_empty:NTF \l__suepthesis_cover_date_tl {
              \today
            } {
              \l__suepthesis_cover_date_tl
            }
          }
        \end{titlepage}
      }
      % {2}
      % {
      %   \begin{titlepage}
      %     \centering

      %     \tl_if_blank:VTF \l_bit_coverheaderimage_tl {} {
      %       \includegraphics[width=6.87cm]{\l_bit_coverheaderimage_tl}\\
      %     }

      %     \vspace{1.2mm}

      %     \zihao{2}\textbf{\songti{本科生毕业设计（论文）外文翻译}}

      %     \vspace{10mm}

      %     {

      %     \begin{spacing}{1.8}

      %       \tl_set:Nn \l__suepthesis_cover_dilimiter_tl {\textbf{：}}
      %       \bool_set_false:N \l__suepthesis_cover_auto_width_bool
      %       \dim_set:Nn \l__suepthesis_cover_label_max_width_dim {35mm}
      %       \dim_set:Nn \l__suepthesis_cover_value_max_width_dim {115mm}

      %       \clist_set:Nn \l__suepthesis_input_clist {
      %         {\zihao{4}\textbf{外文原文题目}} {\l__suepthesis_value_trans_origin_title_tl},
      %         {\zihao{4}\textbf{中文翻译题目}} {\l__suepthesis_value_trans_title_tl},
      %       }

      %       \zihao{-3}
      %       \centering

      %       \__suepthesis_render_cover_entry:n \l__suepthesis_input_clist

      %     \end{spacing}

      %     }

      %     \vspace{19mm}

      %     \zihao{2}\textbf{\xihei:n \l__suepthesis_value_title_tl}\par

      %     \vspace{3mm}

      %     \begin{spacing}{1.2}
      %       \zihao{3}\selectfont{\textbf{\l__suepthesis_value_title_en_tl}}\par
      %     \end{spacing}

      %     \vspace{19mm}

      %     \begin{spacing}{1.8}
      %       \tl_if_empty:NT \l__suepthesis_cover_dilimiter_tl {
      %         \tl_set:Nn \l__suepthesis_cover_dilimiter_tl {：}
      %       }

      %       % 如果不是自动计算宽度，且用户没有自定义宽度，
      %       % 则尝试提供一个默认宽度。
      %       \bool_if:NF \l__suepthesis_cover_auto_width_bool {
      %         \dim_compare:nNnT {\l__suepthesis_cover_label_max_width_dim} = {0pt} {
      %           \dim_set:Nn \l__suepthesis_cover_label_max_width_dim {35mm}
      %         }
      %         \dim_compare:nNnT {\l__suepthesis_cover_value_max_width_dim} = {0pt} {
      %           \dim_set:Nn \l__suepthesis_cover_value_max_width_dim {78mm}
      %         }
      %       }

      %       \zihao{3}

      %   % 渲染信息。
      %       \clist_set:Nn \l__suepthesis_input_clist {
      %         {\c__suepthesis_label_school_tl} {\l__suepthesis_value_school_tl},
      %         {\c__suepthesis_label_major_tl} {\l__suepthesis_value_major_tl},
      %         {\c__suepthesis_label_class_tl} {\l__suepthesis_value_class_tl},
      %         {\c__suepthesis_label_author_tl} {\l__suepthesis_value_author_tl},
      %         {\c__suepthesis_label_student_id_tl} {\l__suepthesis_value_student_id_tl},
      %         {\c__suepthesis_label_supervisor_tl} {\l__suepthesis_value_supervisor_tl},
      %         {\c__suepthesis_label_co_supervisor_tl} {\l__suepthesis_value_external_supervisor_tl},
      %       }

      %       \__suepthesis_render_cover_entry:n \l__suepthesis_input_clist

      %     \end{spacing}

      %     \vspace*{\fill}
      %   \end{titlepage}
      % }
      % {3} {
      %   \begin{titlepage}
      %     \vspace*{16mm}

      %     \centering

      %     \tl_if_blank:VTF \l_bit_coverheaderimage_tl {} {
      %       \includegraphics[width=9.87cm]{\l_bit_coverheaderimage_tl}\\
      %     }

      %     \vspace*{-3mm}

      %     \zihao{1}\textbf{\ziju{0.12}Beijing\nobreak{~}Institute
      %     \nobreak{~}of\nobreak{~}Technology~Bachelor's~Thesis}\par

      %     \vspace{18mm}

      %     \zihao{2}\textbf{\xihei:n \l__suepthesis_value_title_en_tl}\par

      %     \vspace{10mm}

      %     \begin{spacing}{1.8}
      %       \begin{center}
      %       \tl_if_empty:NT \l__suepthesis_cover_dilimiter_tl {
      %         \tl_set:Nn \l__suepthesis_cover_dilimiter_tl {:}
      %       }

      %       % if not auto width, try override width
      %       \bool_if:NF \l__suepthesis_cover_auto_width_bool {
      %         \dim_compare:nNnT {\l__suepthesis_cover_label_max_width_dim} = {0pt} {
      %           \dim_set:Nn \l__suepthesis_cover_label_max_width_dim {20mm}
      %         }
      %         \dim_compare:nNnT {\l__suepthesis_cover_value_max_width_dim} = {0pt} {
      %           \dim_set:Nn \l__suepthesis_cover_value_max_width_dim {105mm}
      %         }
      %       }

      %       \zihao{4}

      %       \clist_set:Nn \l__suepthesis_input_clist {
      %         {\c__suepthesis_label_school_en_tl} {\l__suepthesis_value_school_tl},
      %         {\c__suepthesis_label_major_en_tl} {\l__suepthesis_value_major_tl},
      %         {\c__suepthesis_label_author_en_tl} {\l__suepthesis_value_author_tl},
      %         {\c__suepthesis_label_student_id_en_tl} {\l__suepthesis_value_student_id_tl},
      %         {\c__suepthesis_label_supervisor_en_tl} {\l__suepthesis_value_supervisor_tl},
      %         {\c__suepthesis_label_co_supervisor_en_tl} {\l__suepthesis_value_external_supervisor_tl},
      %       }

      %       \__suepthesis_render_cover_entry:n \l__suepthesis_input_clist

      %       \end{center}
      %     \end{spacing}

      %     \vspace*{\fill}
      %     \centering
      %     \zihao{3}\ziju{0.5}\songti{
      %       \tl_if_empty:NTF \l__suepthesis_cover_date_tl {
      %         \today
      %       } {
      %         \l__suepthesis_cover_date_tl
      %       }
      %     }
      %   \end{titlepage}
      % }
      % {4} {
      %   \make_graduate_cover:
      % }
      % {5} {
      %   \make_graduate_cover:
      % }
    }
    \group_end:
    \end{blindPeerReview}
  }
\NewDocumentCommand \MakeOriginality {}
  {
    \group_begin:
      \begin{blindPeerReview}
      \__suepthesis_ungraduate_originality:
      % 单独成页
      \clearpage
      \end{blindPeerReview}
    \group_end:
  }
\NewDocumentCommand \MakePaperBack {}
  {
    \begin{blindPeerReview}
      \make_paper_back:
    \end{blindPeerReview}
  }
% \NewDocumentCommand \MakeTitle {}
%   {
%     \begin{blindPeerReview}
%       \__suepthesis_make_chinese_title_page:
%       \__suepthesis_make_english_title_page:
%     \end{blindPeerReview}
%   }
\DeclareDocumentCommand \MakeTOC {}
  {
    {
      \__suepthesis_if_bachelor_thesis:TF {
        \renewcommand{\baselinestretch}{1.35}
      } {
        \renewcommand{\baselinestretch}{1.56}
      }

      \__suepthesis_if_thesis_english:TF {
        \tl_set:Nn \l__suepthesis_toc_title_tl {\c__suepthesis_label_toc_en_tl}
      } {
        \tl_set:Nn \l__suepthesis_toc_title_tl {\c__suepthesis_label_toc_tl}
      }

      % 自定义目录样式
      \cs_set:Npn \contentsname {
        \fontsize{16pt}{\baselineskip}
        \l__suepthesis_unnumchapter_style_cs:n
          \l__suepthesis_title_font_cs:n
            {\l__suepthesis_toc_title_tl}
        \vspace{-8pt}
      }

      % 制作目录
      \tableofcontents

      % 在本科生全英文模板中，添加「目录」本身到目录中。
      \__suepthesis_if_thesis_int_type:nT {3} {
        \addcontentsline{toc}{chapter}{\c__suepthesis_label_toc_en_tl}
      }

      % 单独成页
      \clearpage
    }
  }
\NewDocumentEnvironment {abstract} {}
  {

    \cleardoublepage
    \setstretch{1.53}

    \__suepthesis_if_bachelor_thesis:T {
      \begin{center}
        \vspace*{-17bp}
        \heiti\zihao{-2}\textbf{
          \int_case:nn {\g__suepthesis_thesis_type_int}
          {
            {1} {\l__suepthesis_value_title_tl}
            {2} {\l__suepthesis_value_trans_title_tl}
            {3} {\l__suepthesis_value_title_tl}
          }
        }
      \end{center}

      \vspace*{2mm}
    }

    \ctexset{
      chapter/numbering = false,
    }

    \__suepthesis_if_bachelor_thesis:T {
      \ctexset{
        chapter/titleformat = {\textmd}
      }
    }

    {
      \__suepthesis_same_page:
      \bool_if:NTF \l__suepthesis_add_abstract_to_toc_bool {
        \chapter{\c__suepthesis_label_abstract_tl}
      } {
        \chapter*{\c__suepthesis_label_abstract_tl}
        \currentpdfbookmark{\c__suepthesis_label_abstract_tl}{ch:abstract}
      }
    }
    \vspace*{1mm}
    \par
  }
  {
    \par
    \vspace{4ex}
    \noindent
    \__suepthesis_if_graduate:TF {
      % 研究生模板中，“关键词”宋体小四加粗
      % 关键词为宋体小四号字。
      \textbf{\c__suepthesis_label_keywords_tl}\l__suepthesis_value_keywords_tl\par
    } {
      % 本科生模板中，关键词为黑体加粗
      \textbf{\heiti \c__suepthesis_label_keywords_tl \l__suepthesis_value_keywords_tl}\par
    }
    \newpage
  }
\NewDocumentEnvironment {abstractEn} {}
  {
    \setstretch{1.53}

    \__suepthesis_if_bachelor_thesis:T {
      \begin{spacing}{0.95}
        \centering
        \vspace*{-2bp}

        \__suepthesis_if_thesis_int_type:nTF {3} {
          \arialfamily\zihao{-2}\textbf
          \l__suepthesis_value_title_en_tl\\
        } {
          \heiti\zihao{3}\textbf
          \l__suepthesis_value_title_en_tl\\
        }
      \end{spacing}
      \vspace*{10mm}
    }

    \ctexset{
      chapter/numbering = false,
    }

    \__suepthesis_if_bachelor_thesis:TF {
      \int_compare:nNnTF {\g__suepthesis_thesis_type_int} = {3}
      {
        \ctexset{
          chapter = {
            titleformat = {\heiti\zihao{3}\centering\textbf},
          }
        }
      } {
        \ctexset{
          chapter = {
            titleformat = {\heiti\zihao{-3}\centering\textmd},
          }
        }
      }
    } {
      \ctexset {
        chapter/titleformat = {\heiti\zihao{3}\centering\textbf}
      }
    }

    {
      \__suepthesis_same_page:
      \bool_if:nTF {\l__suepthesis_add_abstract_en_to_toc_bool} {
        \chapter{\c__suepthesis_label_abstract_en_tl}
      } {
        \chapter*{\c__suepthesis_label_abstract_en_tl}
        \currentpdfbookmark{\c__suepthesis_label_abstract_en_tl}{ch:abstract:en}
      }
    }
  }
  {
    \par\vspace{3ex}\noindent
    \__suepthesis_if_graduate:TF {
      % Times New Roman小四号字，行距22磅
      % “Key Words”
      % Times New Roman小四号字加粗
      \textbf{\c__suepthesis_label_keywords_en_tl} \l__suepthesis_value_keywords_en_tl
    } {
      \textbf{\c__suepthesis_label_keywords_en_tl \l__suepthesis_value_keywords_en_tl}
    }
    \newpage
  }

\NewDocumentEnvironment {conclusion} {}
  {
    \ctexset{
      section/number = \arabic{section}
    }

    \__suepthesis_if_thesis_english:TF {
      \chapter{\c__suepthesis_label_conclusion_en_tl}
    } {
      \chapter{\c__suepthesis_label_conclusion_tl}
    }
  }
  {}
\NewDocumentEnvironment {bibprint} {}
  {
    % 设置参考文献字号为 5 号
    \renewcommand*{\bibfont}{\zihao{5}}
    % 设置参考文献各个项目之间的垂直距离为 0
    \setlength{\bibitemsep}{0ex}
    \setlength{\bibnamesep}{0ex}
    \setlength{\bibinitsep}{0ex}
    \__suepthesis_if_graduate:TF {
    } {
      % 「本科生」设置单倍行距
      \renewcommand{\baselinestretch}{1.2}
    }
    % 设置参考文献顺序标签 `[1]` 与文献内容 `作者. 文献标题...` 的间距
    \setlength{\biblabelsep}{1.7mm}

    \bool_if:NF \l__suepthesis_style_bibliography_indent_bool {
      % 设置参考文献后文缩进为 0（与 Word 模板保持一致）
      % See: https://github.com/hushidong/biblatex-gb7714-2015
      %      如何修参考文献表的缩进？
      \cs_set:Npn \itemcmd {
        \settowidth{\lengthid}{\mkgbnumlabel{\printfield{labelnumber}}}
        %%这里是所做的调整，以下两句通过调整\lengthid来调整缩进
        \setlength{\lengthid}{0pt}
        \addtolength{\lengthid}{-\biblabelsep}
        \setlength{\lengthlw}{\textwidth}
        \addtolength{\lengthlw}{-\lengthid}
        \addvspace{\bibitemsep}%恢复\bibitemsep的作用
        \hangindent\lengthid
        \leavevmode\mkgbnumlabel{\printfield{labelnumber}}%
        \hspace{\biblabelsep}
      }
    }

    \__suepthesis_if_thesis_english:TF {
      \chapter{\c__suepthesis_label_reference_en_tl}
    } {
      \chapter{\c__suepthesis_label_reference_tl}
    }
  }
  {}
\NewDocumentEnvironment {appendices} {}
  {
    % Used in chapter, ToC.
    \tl_new:N \l__suepthesis_appendix_plain_label_tl
    % Used before reference label.
    \tl_new:N \l__suepthesis_appendix_default_title_tl

    \__suepthesis_if_thesis_english:TF {
      \tl_set:Nn \l__suepthesis_appendix_plain_label_tl {\c__suepthesis_label_appendix_prefix_en_tl}
      \tl_set:Nn \l__suepthesis_appendix_default_title_tl {\c__suepthesis_label_appendix_en_tl}
    } {
      \tl_set:Nn \l__suepthesis_appendix_plain_label_tl {\c__suepthesis_label_appendix_prefix_tl}
      \tl_set:Nn \l__suepthesis_appendix_default_title_tl {\c__suepthesis_label_appendix_tl}
    }

    \bool_if:NTF \l__suepthesis_appendices_chapter_level_bool {
      % 附录章节级别

      % 仅设置 \setcounter{chapter}{0} 时，pdf 目录会索引到正文章节。
      % 因此，需要使用 \appendix 重置计数器，并将附录后面的
      % 几个章节视为特殊的附录页。
      \appendix

      \ctexset{
        chapter/numbering = true,
        chapter/name = {},
        chapter/number = \l__suepthesis_appendix_plain_label_tl\hspace{1ex}\Alph{chapter},
        section/number = \Alph{chapter}. \arabic{section},
        subsection/number = \Alph{chapter}. \arabic{section}. \arabic{subsection},
      }

      \cs_set:Npn \thechapter {
        \Alph{chapter}
      }
    } {
      % 附录节（section）级别
      \ctexset{
        section/number = \l__suepthesis_appendix_plain_label_tl\hspace{1ex}\Alph{section},
        subsection/number = \Alph{section}. \arabic{subsection},
      }

      \cs_set:Npn \thechapter {
        \Alph{section}
      }

      \tl_if_blank:VTF \l__suepthesis_appendices_title_tl {
        \chapter{\l__suepthesis_appendix_default_title_tl}
      } {
        \chapter*{\l__suepthesis_appendices_title_tl}
        \stepcounter{chapter}
        \tl_if_blank:VTF \l__suepthesis_appendix_toc_title_tl {
          \addcontentsline{toc}{chapter}{\l__suepthesis_appendix_default_title_tl}
        } {
          \addcontentsline{toc}{chapter}{\l__suepthesis_appendix_toc_title_tl}
        }
      }
    }
  }
  {
  }
\NewDocumentEnvironment {acknowledgements} {+b}
  {
    \begin{blindPeerReview}
      % 将此章节视为特殊的附录页，关闭附录编号，重定义 section 编号。
      % 不知为何，需要手动重置 section 计数器。
      \setcounter{section}{0}
      \ctexset{
        appendix/numbering = false,
        section/number = \arabic{section},
        subsection/number = \arabic{section}. \arabic{subsection},
        subsubsection/number = \arabic{section}. \arabic{subsection}. \arabic{subsubsection},
      }

      \__suepthesis_if_thesis_english:TF {
        \chapter{\c__suepthesis_label_ack_en_tl}
      } {
        \chapter{\c__suepthesis_label_ack_tl}
      }
      \__suepthesis_if_graduate:TF {\fangsong}{}
      #1
    \end{blindPeerReview}
  } {}
\NewDocumentCommand \Author {O{1} o o}
  {
    \bool_if:NTF \g__suepthesis_blind_mode_bool {
      % 盲审模式
      \IfValueTF {#3} {
        #3
      } {
        第\zhnumber{#1}作者
      }
    } {
      % 普通模式
      \IfValueTF {#2} {
        % 覆盖默认的 \author 命令
        #2
      } {
        % 默认采用作者姓名
        \l__suepthesis_value_author_tl
      }
    }
  }

\NewDocumentCommand \AuthorEn {O{1} o o}
  {
    \bool_if:NTF \g__suepthesis_blind_mode_bool {
      % 盲审模式
      \IfValueTF {#3} {
        #3
      } {
        \Ordinalstringnum{#1}~Author
      }
    } {
      % 普通模式
      \IfValueTF {#2} {
        % 覆盖默认的 \author 命令
        #2
      } {
        % 默认采用作者姓名
        \l__suepthesis_value_author_en_tl
      }
    }
  }
\NewDocumentCommand \addpub {m} {
  \nocite{#1}
  \addtocategory{mypub}{#1}
}

\NewDocumentCommand \addpubs {m} {
  % apply a clist
  \clist_map_function:nN {#1} \addpub
}
\NewDocumentCommand \pubsection {m} {
  {
    % 自增计数器
    \par\stepcounter{pub}
    % 设置小标题，暂时没有考虑英文模式
    \noindent
    \textbf{
      \heiti{
        \zhnumber{\thepub}、#1
      }
    }\par
  }
}
\NewDocumentEnvironment {publications} {+b}
  {
    % 同时设置 omit 以及 blindPeerReview 才能跳过此章节生成。
    \begin{blindPeerReview}[\l__suepthesis_publications_omit_bool]
      % 将此章节视为特殊的附录页，关闭附录编号，重定义 section 编号。
      % 不知为何，需要手动重置 section 计数器。
      \setcounter{section}{0}
      \ctexset{
        appendix/numbering = false,
        section/number = \arabic{section},
        subsection/number = \arabic{section}. \arabic{subsection},
        subsubsection/number = \arabic{section}. \arabic{subsection}. \arabic{subsubsection},
      }
      % 设置参考文献字号为 5 号
      \renewcommand*{\bibfont}{\zihao{5}}
      % 设置参考文献各个项目之间的垂直距离为 0
      \setlength{\bibitemsep}{0ex}
      \setlength{\bibnamesep}{0ex}
      \setlength{\bibinitsep}{0ex}
      % 设置参考文献顺序标签 `[1]` 与文献内容 `作者. 文献标题...` 的间距
      \setlength{\biblabelsep}{1.7mm}

      \bool_if:NF \l__suepthesis_style_bibliography_indent_bool {
        % 设置参考文献后文缩进为 0（与 Word 模板保持一致）
        % See: https://github.com/hushidong/biblatex-gb7714-2015
        %      如何修参考文献表的缩进？
        \cs_set:Npn \itemcmd {
          \settowidth{\lengthid}{\mkgbnumlabel{\printfield{labelnumber}}}
          %%这里是所做的调整，以下两句通过调整\lengthid来调整缩进
          \setlength{\lengthid}{0pt}
          \addtolength{\lengthid}{-\biblabelsep}
          \setlength{\lengthlw}{\textwidth}
          \addtolength{\lengthlw}{-\lengthid}
          \addvspace{\bibitemsep}%恢复\bibitemsep的作用
          \hangindent\lengthid
          \leavevmode\mkgbnumlabel{\printfield{labelnumber}}%
          \hspace{\biblabelsep}
        }
      }

      % If in blindPeerReview mode, omit delimiters in author field.
      \bool_if:NT \g__suepthesis_blind_mode_bool {
        % 如果有多个作者，不修改此项的话，作者与标题之间会有逗号。
        \DeclareDelimFormat[bib,biblist]{finalnamedelim}{}
        % 如果自己不是第一个作者，不修改此项的话，会在最开始有逗号。
        \DeclareDelimFormat{multinamedelim}{}
      }

      % ===== 上方定义与「参考文献」部分相同

      % 中文姓名下，此部分不参与输出。
      \cs_set:Npn \mkbibnamegiven ##1 {
        \haspartannotation{myself}{
          \bool_if:NTF \g__suepthesis_blind_mode_bool {
            % 盲审模式，不输出内容
          } {
            % 普通模式
            \textbf{##1}
          }
        }{
          \bool_if:NTF \g__suepthesis_blind_mode_bool {
            % 盲审模式，不输出内容
          } {
            % 普通模式
            ##1
          }
        }
      }

      \cs_set:Npn \mkbibnamefamily ##1 {
        \haspartannotation{myself}{
          % 作者为自己
          \bool_if:NTF \g__suepthesis_blind_mode_bool {
            % 盲审模式
            \getpartannotation{myself}
          } {
            % 普通模式
            \textbf{##1}
          }
        }{
          % 作者不是自己
          \bool_if:NTF \g__suepthesis_blind_mode_bool {
            % 盲审模式，不输出
          } {
            % 普通模式
            ##1
          }
        }
      }

      \if_cs_exist:N \c@pub {
        % 重置计数器
        \setcounter{pub}{0}
      } \else: {
        % 设置计数器
        \newcounter{pub}
      } \fi:

      % 设置参考文献的排序
      \bool_if:NTF \l__suepthesis_publications_sorting_bool {
        % Sorting by year, name, type.
        \newrefcontext[sorting=ynt]
      } {
        % Do not sort.
        \newrefcontext
      }

      % 根据 maxbibnames 的设置，覆盖 \blx@maxbibnames 选项，保证所有作者都能显示。
      \cs_set:Npn \blx@maxbibnames {
        \l__suepthesis_publications_maxbibnames_int
      }

      % 根据 minbibnames 的设置，覆盖 \blx@minbibnames 选项，保证所有作者都能显示。
      \cs_set:Npn \blx@minbibnames {
        \l__suepthesis_publications_minbibnames_int
      }

      \chapter{\c__suepthesis_label_publications_tl}
      #1
    \end{blindPeerReview}
  }
  {}
\NewDocumentEnvironment {resume} {+b}
  {
    \begin{blindPeerReview}
      % 将此章节视为特殊的附录页，关闭附录编号，重定义 section 编号。
      % 不知为何，需要手动重置 section 计数器。
      \setcounter{section}{0}
      \ctexset{
        appendix/numbering = false,
        section/number = \arabic{section},
        subsection/number = \arabic{section}. \arabic{subsection},
        subsubsection/number = \arabic{section}. \arabic{subsection}. \arabic{subsubsection},
      }
      \chapter{\c__suepthesis_label_resume_tl}
      #1
    \end{blindPeerReview}
  }
  {
  }

\NewDocumentEnvironment {symbols} {}
  {
    \bool_if:NTF \l__suepthesis_add_symbols_to_toc_bool {
      \chapter{\c__suepthesis_label_symbols_tl}
    } {
      \chapter*{\c__suepthesis_label_symbols_tl}
      \currentpdfbookmark{\c__suepthesis_label_symbols_tl}{ch:symbols}
    }
    \zihao{-4}
    \begin{itemize}[
      labelwidth=2.5cm,
      labelsep=0.5cm,
      leftmargin=3cm,
      itemindent=0cm,
      itemsep=0cm
    ]
    \cs_set:Npn \makelabel ##1 {##1\hfil}
  }
  {
    \end{itemize}

    % 单独一页
    \clearpage
  }
\endinput
%%
%% End of file `suepthesis.cls'.
