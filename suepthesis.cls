%%
%% This is file `suepthesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% suepthesis.dtx  (with options: `cls')
%% Copyright (C) 2026 SUEPThesis contributors.
%% Distributed under the LaTeX Project Public License 1.3c or later.
%% See LICENSE for license information.

\RequirePackage{expl3,l3keys2e}
\ProvidesExplClass{suepthesis}{2026-10-07}{0.1.0}{SUEP degree thesis class}
\msg_new:nnn {suepthesis}{engine}{Use~XeLaTeX~or~LuaLaTeX.}
\msg_new:nnn {suepthesis}{translation}{Doctoral~heading~'#1'~needs~an~English~translation.}
\msg_new:nnn {suepthesis}{caption}{Doctoral~figures/tables~need~\string\SUEPCaption\{Chinese
  \}\{
  English\}.}
\msg_new:nnn {suepthesis}{continued-caption}{Use~\string\SUEPContinuedCaption~only~inside~
  longtable.
  }
\msg_new:nnn {suepthesis}{font}{
  Font~'#1'~unavailable;~using~a~substitute.~Check~Selected~font~messages~in~the~log.}
\msg_new:nnn {suepthesis}{required}{Required~information~'#1'~is~empty.}
\msg_new:nnn {suepthesis}{keywords}{Expected~#1~keywords,~received~#2.}
\msg_new:nnn {suepthesis}{keyword-pair}{Chinese~and~English~keyword~counts~differ.}
\msg_new:nnn {suepthesis}{profile-locked}{Option~'#1'~must~be~set~before~begin\{document\}.}
\msg_new:nnn {suepthesis}{cover-title-overflow}
  {The~thesis~title~exceeds~the~available~cover~area.~Shorten~the~title~or~adjust~its~
  wording.}
\msg_new:nnn {suepthesis}{cover-field-overflow}
  {Cover~field~'#1'~exceeds~its~single-line~area.~Use~a~shorter~official~form.}
\msg_new:nnn {suepthesis}{spine-overflow}
  {The~spine~text~exceeds~23cm.~Shorten~the~thesis~title~before~printing.}
\sys_if_engine_pdftex:T {\msg_fatal:nn {suepthesis}{engine}}
\tl_new:N \g__suep_type_tl
\tl_new:N \g__suep_degree_type_tl
\tl_new:N \g__suep_sides_tl
\bool_new:N \g__suep_profile_dirty_bool
\bool_new:N \g__suep_profile_locked_bool
\bool_new:N \g__suep_abstract_toc_explicit_bool
\bool_new:N \g__suep_abstract_en_toc_explicit_bool
\bool_new:N \g__suep_bibliography_requested_bool
\bool_new:N \g__suep_twoside_bool
\bool_new:N \g__suep_blind_bool
\bool_new:N \g__suep_main_bool
\bool_new:N \g__suep_appendix_bool
\bool_new:N \l__suep_bicaption_bool
\bool_new:N \l__suep_display_tag_bool
\bool_new:N \l__suep_cover_bool
\tl_new:N \l__suep_cover_data_offset_tl
\tl_new:N \l__suep_cover_value_offset_tl
\bool_new:N \g__suep_cover_blank_bool
\bool_new:N \g__suep_abstract_toc_bool
\bool_new:N \g__suep_abstract_en_toc_bool
\prop_new:N \g__suep_info_prop
\tl_new:N \g__suep_date_tl
\tl_new:N \g__suep_logo_tl
\tl_new:N \l__suep_logo_file_tl
\bool_new:N \l__suep_vector_logo_bool
\tl_new:N \g__suep_cjk_fontset_tl
\tl_new:N \g__suep_latin_fontset_tl
\tl_new:N \g__suep_song_font_tl
\tl_new:N \g__suep_hei_font_tl
\tl_new:N \g__suep_kai_font_tl
\tl_new:N \g__suep_fang_font_tl
\tl_new:N \g__suep_cover_font_tl
\tl_new:N \g__suep_latin_font_tl
\keys_define:nn {suepthesis/option}
  {
    cjk-font .choices:nn = {auto,windows,mac,fandol}
      {\tl_gset:NV \g__suep_cjk_fontset_tl \l_keys_choice_str},
    cjk-font .initial:n = auto,
    font .choices:nn = {auto,times,termes}
      {\tl_gset:NV \g__suep_latin_fontset_tl \l_keys_choice_str},
    font .initial:n = auto,
    type .choices:nn = {bachelor,master,doctor}
      {\tl_gset:NV \g__suep_type_tl \l_keys_choice_str},
    type .initial:n = master,
    degreeType .choices:nn = {academic,professional}
      {\tl_gset:NV \g__suep_degree_type_tl \l_keys_choice_str},
    degreeType .initial:n = academic,
    degree .meta:n = {degreeType=#1},
    twoside .choices:nn = {auto,true,false}
      {\tl_gset:NV \g__suep_sides_tl \l_keys_choice_str},
    twoside .initial:n = auto, twoside .default:n = true,
    blindPeerReview .bool_gset:N = \g__suep_blind_bool,
    blindPeerReview .initial:n = false,
  }
\ProcessKeysOptions{suepthesis/option}
\prg_new_conditional:Npnn \__suep_if_bachelor: {p,T,F,TF}
  {\str_if_eq:eeTF {\g__suep_type_tl}{bachelor}{\prg_return_true:}{\prg_return_false:}}
\prg_new_conditional:Npnn \__suep_if_doctor: {T,TF}
  {\str_if_eq:eeTF {\g__suep_type_tl}{doctor}{\prg_return_true:}{\prg_return_false:}}
\str_if_eq:VnTF \g__suep_sides_tl {auto}
  {\__suep_if_bachelor:F {\bool_gset_true:N \g__suep_twoside_bool}}
  {\str_if_eq:VnT \g__suep_sides_tl {true}{\bool_gset_true:N \g__suep_twoside_bool}}
\bool_if:NTF \g__suep_twoside_bool
  {\PassOptionsToClass{twoside,openright}{ctexbook}}
  {\PassOptionsToClass{oneside,openany}{ctexbook}}
\LoadClass[a4paper,zihao=-4,fontset=none,linespread=1]{ctexbook}
\RequirePackage{geometry,fancyhdr,titletoc,graphicx,booktabs,array,longtable
  }
\RequirePackage{caption,setspace,xcolor}
\ExplSyntaxOff
\RequirePackage{sueplogo}
\ExplSyntaxOn
\RequirePackage[unicode,bookmarksnumbered,hidelinks]{hyperref}
\hypersetup{hypertexnames=false}
\pdfstringdefDisableCommands{\cs_set:Npn \quad {~}}
\msg_new:nnn {suepthesis}{font-required}
  {Font~'#1'~is~required~by~the~selected~font~preset.~Install~it~or~choose~
  auto/fandol/termes.}
\msg_new:nnn {suepthesis}{font-selected}{Selected~#1~font:~#2.}
\msg_new:nnn {suepthesis}{logo-missing}
  {
  Cover~logo~'#1'~not~found.~Use~cover/headerImage=auto~for~the~vector~logo,~
  an~existing~PDF/PNG/JPEG~file,~or~
  empty~to~omit~it.
  }
\cs_new_protected:Npn \__suep_first_font:Nn #1#2
  {\tl_gclear:N #1
   \clist_map_inline:nn {#2}
     {\IfFontExistsTF{##1}
        {\tl_gset:Nn #1 {##1}\clist_map_break:}{}}}
\cs_new_protected:Npn \__suep_select_cjk:Nnnn #1#2#3#4
  {\str_case:Vn \g__suep_cjk_fontset_tl
     {{auto}{\tl_set:Nn \l_tmpa_tl {#2,#3,#4}
        \__suep_first_font:Nn #1 {#2,#3,#4}
        \tl_if_eq:NnF #1 {#2}{\msg_warning:nnn {suepthesis}{font}{#2}}}
      {windows}{\tl_set:Nn \l_tmpa_tl {#2}\__suep_first_font:Nn #1 {#2}}
      {mac}{\tl_set:Nn \l_tmpa_tl {#3}\__suep_first_font:Nn #1 {#3}}
      {fandol}{\tl_set:Nn \l_tmpa_tl {#4}\__suep_first_font:Nn #1 {#4}}}
   \tl_if_empty:NT #1
     {\msg_fatal:nne {suepthesis}{font-required}{\tl_use:N \l_tmpa_tl}}}
\__suep_select_cjk:Nnnn \g__suep_song_font_tl
  {SimSun}{Songti~SC~Light,STSongti-SC-Light,Songti~SC}{FandolSong-Regular.otf}
\__suep_select_cjk:Nnnn \g__suep_hei_font_tl
  {SimHei}{Heiti~SC~Medium,STHeitiSC-Medium,Heiti~SC,PingFang~SC}{FandolHei-Regular.otf}
\__suep_select_cjk:Nnnn \g__suep_kai_font_tl
  {KaiTi}{Kaiti~SC,STKaitiSC-Regular}{FandolKai-Regular.otf}
\__suep_select_cjk:Nnnn \g__suep_fang_font_tl
  {FangSong}{STFangsong}{FandolFang-Regular.otf}
\str_if_eq:VnTF \g__suep_cjk_fontset_tl {fandol}
  {\tl_gset_eq:NN \g__suep_cover_font_tl \g__suep_fang_font_tl}
  {\__suep_first_font:Nn \g__suep_cover_font_tl {STFangsong}
   \tl_if_empty:NT \g__suep_cover_font_tl
     {\tl_gset_eq:NN \g__suep_cover_font_tl \g__suep_fang_font_tl
      \msg_warning:nnn {suepthesis}{font}{STFangsong}}}
\tl_if_eq:NnTF \g__suep_song_font_tl {FandolSong-Regular.otf}
  {\setCJKmainfont{FandolSong-Regular.otf}
     [BoldFont=FandolSong-Bold.otf,ItalicFont=FandolSong-Regular.otf,
      BoldItalicFont=FandolSong-Bold.otf]
   \setCJKfamilyfont{zhsong}{FandolSong-Regular.otf}
     [BoldFont=FandolSong-Bold.otf,ItalicFont=FandolSong-Regular.otf,
      BoldItalicFont=FandolSong-Bold.otf]
   \setCJKfamilyfont{suepgradbold}{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]
   \setCJKfamilyfont{suepgradsubbold}{FandolSong-Regular.otf}[BoldFont=FandolSong-Bold.otf]}
  {\setCJKmainfont{\g__suep_song_font_tl}[AutoFakeBold=2.5]
   \setCJKfamilyfont{zhsong}{\g__suep_song_font_tl}[AutoFakeBold=2.5]
   \setCJKfamilyfont{suepgradbold}{\g__suep_song_font_tl}[AutoFakeBold=2.849316]
   \setCJKfamilyfont{suepgradsubbold}{\g__suep_song_font_tl}[AutoFakeBold=2.859493]}
\tl_if_eq:NnTF \g__suep_hei_font_tl {FandolHei-Regular.otf}
  {\setCJKsansfont{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
   \setCJKfamilyfont{zhhei}{FandolHei-Regular.otf}[BoldFont=FandolHei-Bold.otf]
   \cs_new_eq:NN \__suep_heading_latin: \rmfamily}
  {\sys_if_engine_luatex:TF
     {\setCJKsansfont{\g__suep_hei_font_tl}[BoldFont=\g__suep_hei_font_tl]
      \setCJKfamilyfont{zhhei}{\g__suep_hei_font_tl}[BoldFont=\g__suep_hei_font_tl]}
     {\setCJKsansfont{\g__suep_hei_font_tl}\setCJKfamilyfont{zhhei}{\g__suep_hei_font_tl}}
   \newfontfamily\__suep_heading_latin:{\g__suep_hei_font_tl}}
\setCJKfamilyfont{zhkai}{\g__suep_kai_font_tl}[AutoFakeBold=2.5]
\setCJKfamilyfont{zhfs}{\g__suep_fang_font_tl}
\setCJKmonofont{\g__suep_fang_font_tl}
\setCJKfamilyfont{suepcover}{\g__suep_cover_font_tl}[AutoFakeBold=2.5]
\NewDocumentCommand \songti {}{\CJKfamily{zhsong}}
\NewDocumentCommand \heiti {}{\CJKfamily{zhhei}}
\NewDocumentCommand \kaiti {}{\CJKfamily{zhkai}}
\NewDocumentCommand \fangsong {}{\CJKfamily{zhfs}}
\cs_new_protected:Npn \__suep_graduate_song_bold:
  {\bfseries\CJKfamily{suepgradbold}}
\cs_new_protected:Npn \__suep_graduate_subsection_font:
  {\bfseries\CJKfamily{suepgradsubbold}}
\cs_new_protected:Npn \__suep_word_heiti:n #1
  {\heiti\sys_if_engine_xetex:T
     {\exp_args:Ne \addCJKfontfeatures
        {FakeBold=\fp_eval:n {100 * #1 / \use:c {f@size}}}}}
\cs_new_protected:Npn \__suep_bachelor_abstract_heiti:
  {\heiti\sys_if_engine_xetex:T {\addCJKfontfeatures{FakeBold=2.84647}}}
\str_case:Vn \g__suep_latin_fontset_tl
  {{auto}{\__suep_first_font:Nn \g__suep_latin_font_tl {Times~New~Roman,TeX~Gyre~Termes}
     \tl_if_eq:NnF \g__suep_latin_font_tl {Times~New~Roman}
       {\msg_warning:nnn {suepthesis}{font}{Times~New~Roman}}}
   {times}{\__suep_first_font:Nn \g__suep_latin_font_tl {Times~New~Roman}}
   {termes}{\tl_gset:Nn \g__suep_latin_font_tl {TeX~Gyre~Termes}}}
\tl_if_empty:NT \g__suep_latin_font_tl
  {\msg_fatal:nnn {suepthesis}{font-required}{Times~New~Roman}}
\setmainfont{\g__suep_latin_font_tl}
\RequirePackage{unicode-math}
\setmathfont{TeX~Gyre~Termes~Math}
\setmathfont[range={"002B,"003D}]{\g__suep_latin_font_tl}
\DeclareMathSizes{12.045}{11.944625}{6.966025}{4.977}
\setsansfont{TeX~Gyre~Heros}\setmonofont{Latin~Modern~Mono}
\clist_map_inline:nn {song,hei,kai,fang,cover,latin}
  {\msg_info:nnee {suepthesis}{font-selected}{#1}{\tl_use:c {g__suep_#1_font_tl}}}
\sys_if_engine_xetex:T
  {\xeCJKDeclarePunctStyle{suepword}{fixed-punct-width=.666667em}
   \clist_map_inline:nn {9.36,11.64,12.84,13.92}
     {\xeCJKDeclarePunctStyle{suepstatement#1}
       {fixed-punct-width=#1bp,mixed-punct-width=#1bp,
        bound-punct-width=14.04bp,enabled-global-setting=false,
        enabled-hanging=false,enabled-kerning=false,margin-minimum=0bp}}}
\cs_new_protected:Npn \__suep_punct_style:n #1
  {\sys_if_engine_xetex:T {\punctstyle{#1}}
   \sys_if_engine_luatex:T {\ctexset{punct=#1}}}
\sys_if_engine_luatex:T
  {\ltjdefcharrange{10}{"2019}\ltjdefcharrange{11}{"00B7}
   \ltjsetparameter{jacharrange={+10,+11}}}
\cs_new_protected:Npn \__suep_latin_char:n #1
  {\sys_if_engine_xetex:T {\xeCJKDeclareCharClass{Default}{#1}}
   \sys_if_engine_luatex:T
     {\str_case:nn {#1}
        {{"2019}{\ltjsetparameter{jacharrange={-10}}}
         {"00B7}{\ltjsetparameter{jacharrange={-11}}}}}}
\cs_new_protected:Npn \__suep_symbol_font: {\fontspec{\g__suep_song_font_tl}}
\clist_map_inline:nn
  {title,subtitle,titleEn,author,studentId,supervisor,externalSupervisor,
   institution,institute,major,grade,degree,classification,classifiedLevel,finalizationDate,
  keywords,keywordsEn
  }
  {\keys_define:nn {suepthesis/info}
    {#1 .code:n = {\prop_gput:Nnn \g__suep_info_prop {#1}{##1}},#1 .initial:n = {}}}
\prop_gput:Nnn \g__suep_info_prop {classifiedLevel}{公开}
\keys_define:nn {suepthesis/cover}
  {
    date .tl_gset:N = \g__suep_date_tl,
    date .initial:n = {\int_use:N \c_sys_year_int 年\int_use:N \c_sys_month_int 月},
    headerImage .tl_gset:N = \g__suep_logo_tl,
    headerImage .initial:n = auto,
    blankFields .bool_gset:N = \g__suep_cover_blank_bool,
    blankFields .initial:n = false,
  }
\keys_define:nn {suepthesis/TOC}
  {abstract .choices:nn = {true,false}
     {\bool_gset_true:N \g__suep_abstract_toc_explicit_bool
      \str_if_eq:VnTF \l_keys_choice_str {true}
        {\bool_gset_true:N \g__suep_abstract_toc_bool}{\bool_gset_false:N
  \g__suep_abstract_toc_bool
  }},
   abstractEn .choices:nn = {true,false}
     {\bool_gset_true:N \g__suep_abstract_en_toc_explicit_bool
      \str_if_eq:VnTF \l_keys_choice_str {true}
        {\bool_gset_true:N \g__suep_abstract_en_toc_bool}{\bool_gset_false:N
  \g__suep_abstract_en_toc_bool}}}
\cs_new_protected:Npn \__suep_setup_option:nn #1#2
  {\bool_if:NTF \g__suep_profile_locked_bool
     {\msg_error:nnn {suepthesis}{profile-locked}{#1}}
     {\keys_set:nn {suepthesis/option}{#1=#2}\bool_gset_true:N \g__suep_profile_dirty_bool}}
\keys_define:nn {suepthesis}
  {twoside .code:n = {\__suep_setup_option:nn {twoside}{#1}},twoside .default:n = true,
   blindPeerReview .code:n = {\__suep_setup_option:nn {blindPeerReview}{#1}},
   blindPeerReview .default:n = true,
   info .meta:nn = {suepthesis/info}{#1},cover .meta:nn = {suepthesis/cover}{#1},
   TOC .meta:nn = {suepthesis/TOC}{#1}}
\NewDocumentCommand \SUEPSetup {m}
  {\keys_set:nn {suepthesis}{#1}
   \bool_if:NT \g__suep_profile_dirty_bool {\__suep_apply_profile:}}
\cs_new:Npn \__suep_info:n #1 {\prop_item:Nn \g__suep_info_prop {#1}}
\cs_new:Npn \__suep_identity:n #1
  {\bool_if:NTF \g__suep_blind_bool {匿名}{\__suep_info:n {#1}}}
\NewDocumentCommand \SecretInfo {m o}
  {\bool_if:NTF \g__suep_blind_bool {\IfNoValueTF{#2}{匿名}{#2}}{#1}}
\NewDocumentEnvironment {blindPeerReview}{+b}{\bool_if:NF \g__suep_blind_bool {#1}}{}
\cs_new:Npn \__suep_degree_name: {\__suep_if_doctor:TF {博士}{硕士}}
\cs_new:Npn \__suep_degree_en: {\__suep_if_doctor:TF {Doctor}{Master}}
\cs_new:Npn \__suep_full_title: {\__suep_info:n {title}\__suep_info:n {subtitle}}
\cs_new:Npn \__suep_university_header: {上海电力大学\__suep_degree_name: 学位论文}
\cs_new_protected:Npn \__suep_body_font:
  {\normalfont\songti\zihao{-4}
   \__suep_if_bachelor:T {\__suep_punct_style:n {plain}}
   \setstretch{1.3541667}
   \dim_set:Nn \parindent {2\ccwd}\skip_set:Nn \parskip {0pt}}
\cs_new_protected:Npn \__suep_bachelor_header:
  {\fancyhead[L]{\hspace{115.632bp}\raisebox{-4.36bp}{\songti\zihao{-5}\__suep_full_title:}}
   \cs_set:Npn \headrule
     {\vskip4.027bp\hrule height .75bp width 432bp\vskip-4.777bp}}
\fancypagestyle{suepthesis}
  {\fancyhf{}
   \__suep_if_bachelor:TF
     {\__suep_bachelor_header:
      \fancyfoot[C]{\hspace*{-19.08bp}\raisebox{4.381bp}
        {\normalfont\zihao{-5}-\hspace{4.56bp}\thepage\hspace{4.5bp}-}}
      \cs_set:Npn \headrulewidth {0.6pt}}
     {\fancyhead[C]{\raisebox{\int_if_odd:nTF {\value{page}}{.094bp}{1.57bp}}{\songti
  \int_if_odd:nTF
   {\value{page}}
          {\zihao{5}\leftmark}{\zihao{-5}\__suep_university_header:}}}
      \fancyfoot[C]{\normalfont\zihao{5}\thepage}
      \cs_set:Npn \headrule {\hrule height 1bp width \headwidth\vskip 1bp
        \hrule height 1bp width \headwidth\vskip -3bp}}}
\fancypagestyle{suepfront}
  {\fancyhf{}\__suep_if_bachelor:TF {\__suep_bachelor_header:}
     {\fancyhead[C]{\songti\zihao{-5}\__suep_full_title:}\cs_set:Npn \headrulewidth {0.6pt}}
  }
\fancypagestyle{suepabstract}[suepthesis]
  {\fancyhfoffset[L]{14.12bp}\fancyhfoffset[R]{14.28bp}}
\cs_set_protected:Npn \chaptermark #1
  {\markboth{\bool_if:NT \g__suep_main_bool
      {\bool_if:NTF \g__suep_appendix_bool {附录~\thechapter}{第~\thechapter~章}\hspace{.5em
  }}#1}{}}
\RenewDocumentCommand \cleardoublepage {}
  {\clearpage\bool_if:NT \g__suep_twoside_bool
    {\int_if_odd:nF {\value{page}}{\hbox:n {}\__suep_if_bachelor:T {\thispagestyle{empty}}
  \newpage}}
  }
\tl_if_eq:NnTF \g__suep_song_font_tl {SimSun}
  {\newfontfamily\__suep_toc_latin:{SimSun}[AutoFakeBold=2.5]}
  {\cs_new_eq:NN \__suep_toc_latin: \rmfamily}
\cs_new_protected:Npn \__suep_sectioning:
  {
\ctexset
  {chapter={name={第,章},number=\arabic{chapter},numberformat=\bfseries,aftername=\quad,
     format=\zihao{3}\__suep_word_heiti:n {.45617}\centering
  ,beforeskip=70.416bp,afterskip=41.86bp,fixskip=true,pagestyle=suepthesis,afterindent=true}
  ,
   section={format=\__suep_graduate_song_bold:\zihao{-3}\raggedright,
     aftername=\quad,beforeskip=19.5bp,afterskip=17.57bp,fixskip=true,afterindent=true},
   subsection={format=\__suep_graduate_subsection_font:\zihao{4}\raggedright,indent=2\ccwd,
     aftername=\quad,beforeskip=9.75bp,afterskip=0bp,fixskip=false,afterindent=true}
  ,secnumdepth=2,tocdepth=2}
\__suep_if_bachelor:T
  {\ctexset{chapter={number=\chinese{chapter},numberformat={},format=\setstretch{1.625}
  \heiti\zihao{
  -3}\centering
       \skip_set:Nn \rightskip {4bp~plus~1fil},
       aftername=\hspace{7.56bp},beforeskip=8.6bp,afterskip=20.57bp},
     section={format=\setstretch{1.625}\__suep_heading_latin:\heiti\fontsize{14.04bp}{
  16.848bp}
  \selectfont\raggedright,
       aftername=\hspace{7.02bp},beforeskip=11.7bp,afterskip=0pt,fixskip=false},
     subsection={format=\setstretch{1.625}\__suep_heading_latin:\heiti\zihao{-4}\raggedright
  ,
       indent=20.04bp,aftername=\hspace{6bp},beforeskip=11.7bp,afterskip=0pt,fixskip=false}}
  }
\titlecontents{chapter}[24.16bp]{\songti\zihao{-4}}{\thecontentslabel\quad}{}{\titlerule
  *[4.02bp]{·}
  \contentspage}
\titlecontents{section}[33.04bp]{\songti\zihao{-4}}{\thecontentslabel\quad}{}{\titlerule
  *[4.02bp]{·}
  \contentspage}
\titlecontents{subsection}[42.04bp]{\songti\zihao{-4}}{\thecontentslabel\quad}{}{\titlerule
  *[4.02bp]
  {·}\contentspage}
\__suep_if_bachelor:T
  {\titlecontents{chapter}[0bp]
     {\addvspace{6bp}\setstretch{1.516667}\__suep_toc_latin:\songti\bfseries\zihao{-4}}
     {\thecontentslabel\quad}{}{\titlerule*[6bp]{.}\contentspage}
   \titlecontents{section}[10.56bp]
     {\setstretch{1.516667}\__suep_toc_latin:\songti\zihao{-4}}
     {\thecontentslabel\quad}{}{\titlerule*[6bp]{.}\contentspage}
   \titlecontents{subsection}[21bp]
     {\setstretch{1.516667}\__suep_toc_latin:\songti\zihao{-4}}
     {\thecontentslabel\quad}{}{\titlerule*[6bp]{.}\contentspage}}
\__suep_if_bachelor:TF
  {\cs_set:Npn \contentsname {目\quad\quad 录}}
  {\cs_set:Npn \contentsname {目\quad 录}}
\clist_map_inline:nn {chapter,section,subsection}
  {\cs_set_eq:cc {ttll@suep##1}{ttll@##1}
   \cs_set_eq:cc {toclevel@suep##1}{toclevel@##1}}
\titlecontents{suepchapter}[0bp]{\rmfamily\zihao{-4}}
  {\thecontentslabel\quad}{}{\titlerule*[6bp]{.}\contentspage}
\titlecontents{suepsection}[12bp]{\rmfamily\zihao{-4}}
  {\thecontentslabel\quad}{}{\titlerule*[6bp]{.}\contentspage}
\titlecontents{suepsubsection}[24bp]{\rmfamily\zihao{-4}}
  {\thecontentslabel\quad}{}{\titlerule*[6bp]{.}\contentspage}
\__suep_if_bachelor:T {\cs_set:Npn \contentsname {目录}}
  }
\cs_set:Npn \thefigure {\thechapter-\arabic{figure}}
\cs_set:Npn \thetable {\thechapter-\arabic{table}}
\cs_set:Npn \theequation {\thechapter-\arabic{equation}}
\dim_new:N \l__suep_equation_symbol_width_dim
\NewDocumentEnvironment {equationnotes}{O{2em}}
  {\par\nobreak\__suep_body_font:
   \dim_set:Nn \l__suep_equation_symbol_width_dim {#1}
   \noindent\skip_horizontal:n {2\ccwd}式中：\par\nobreak
   \list{}
     {\dim_set:Nn \labelwidth {\l__suep_equation_symbol_width_dim+2\ccwd}
      \dim_set:Nn \labelsep {0pt}
      \dim_set:Nn \leftmargin {2\ccwd+\labelwidth}
      \dim_set:Nn \rightmargin {0pt}
      \dim_set:Nn \itemindent {0pt}\dim_set:Nn \listparindent {0pt}
      \skip_set:Nn \topsep {0pt}\skip_set:Nn \partopsep {0pt}
      \skip_set:Nn \itemsep {0pt}\skip_set:Nn \parsep {0pt}
      \int_set:cn {@beginparpenalty}{10000}
      \cs_set_protected:Npn \makelabel ##1
        {\hbox_to_wd:nn {\l__suep_equation_symbol_width_dim}
           {##1\skip_horizontal:n {0pt~plus~1fil}}——}}}
  {\endlist\use:c {@endpefalse}}
\cs_set_protected:cpn {maketag@@@} #1
  {\hbox:n {\use:c {m@th}\normalfont\zihao{5}#1}}
\__suep_if_bachelor:F
  {\cs_set_protected:cpn {tagform@} #1
     {\use:c {maketag@@@}{\songti （\ignorespaces #1\unskip\use:c {@@italiccorr}）
        \bool_if:NT \l__suep_display_tag_bool {\skip_horizontal:n {-5.173bp}}}}
   \AddToHook{cmd/make@display@tag/before}{\bool_set_true:N \l__suep_display_tag_bool}
   \AddToHook{cmd/make@display@tag/after}{\bool_set_false:N \l__suep_display_tag_bool}
   \AddToHook{cmd/endmathdisplay@a/before}{\bool_set_true:N \l__suep_display_tag_bool}
   \AddToHook{cmd/endmathdisplay@a/after}{\bool_set_false:N \l__suep_display_tag_bool}}
\DeclareCaptionFont{suep}{\setstretch{1.3541667}\songti
  \__suep_if_bachelor:TF {\__suep_toc_latin:\fontsize{10.56bp}{12.672bp}\selectfont}{\zihao{
  5}}}
\DeclareCaptionLabelSeparator{suep}{\quad}
\captionsetup{font=suep,labelsep=suep,justification=centering,singlelinecheck=false,
  skip=9.75bp}
\captionsetup[table]{position=top}\captionsetup[figure]{position=bottom}
\__suep_if_bachelor:F {\captionsetup[table]{skip=0bp}}
\__suep_if_bachelor:F {\captionsetup[figure]{skip=10.9092bp}}
\cs_new_protected:Npn \__suep_table_style:
  {\__suep_if_bachelor:TF {\songti\zihao{5}}
     {\setstretch{1}\songti\fontsize{10.45bp}{18.72bp}\selectfont
      \dim_set:Nn \heavyrulewidth {.48bp}\dim_set:Nn \lightrulewidth {.48bp}
      \dim_set:Nn \aboverulesep {0bp}\dim_set:Nn \belowrulesep {0bp}}}
\AddToHook{env/tabular/begin}{\bool_if:NF \l__suep_cover_bool {\__suep_table_style:}}
\AddToHook{env/longtable/begin}{\__suep_table_style:}
\cs_new_protected:Npn \__suep_apply_profile:
  {\bool_gset_false:N \g__suep_twoside_bool
   \str_if_eq:VnTF \g__suep_sides_tl {auto}
     {\__suep_if_bachelor:F {\bool_gset_true:N \g__suep_twoside_bool}}
     {\str_if_eq:VnT \g__suep_sides_tl {true}{\bool_gset_true:N \g__suep_twoside_bool}}
   \bool_if:NTF \g__suep_twoside_bool
     {\geometry{twoside=true}\use:c {@openrighttrue}}
     {\geometry{twoside=false}\use:c {@openrightfalse}}
\__suep_if_bachelor:TF
  {\geometry{
  left=3.17cm,right=2.5cm,top=2.54cm,bottom=2.54cm,headheight=15.5pt,headsep=19.5pt,
  footskip=25pt}}
  {\geometry{left=3cm,right=3cm,top=3cm,bottom=2.5cm,
     headheight=15bp,headsep={\dim_eval:n {1cm-15bp}},footskip=0.5cm}
   \skip_set:Nn \topskip {18.7986bp}}
   \bool_if:NF \g__suep_abstract_toc_explicit_bool
     {\bool_gset:Nn \g__suep_abstract_toc_bool {!\__suep_if_bachelor_p:}}
   \bool_if:NF \g__suep_abstract_en_toc_explicit_bool
     {\bool_gset:Nn \g__suep_abstract_en_toc_bool {!\__suep_if_bachelor_p:}}
   \__suep_sectioning:
   \__suep_if_bachelor:TF
     {\skip_set:Nn \intextsep {19.5bp}\skip_set:Nn \textfloatsep {19.5bp}}
     {\skip_set:Nn \intextsep {9.75bp}\skip_set:Nn \textfloatsep {9.75bp}}
   \bool_gset_false:N \g__suep_profile_dirty_bool}
\cs_new_eq:NN \__suep_caption: \caption
\AddToHook{begindocument/end}
  {\cs_set_eq:NN \__suep_caption: \caption
   \RenewDocumentCommand \caption {s o m}
     {\__suep_if_doctor:T
        {\exp_args:Nnv \clist_if_in:nnT {figure,table}{@captype}
           {\bool_if:NF \l__suep_bicaption_bool {\msg_error:nn {suepthesis}{caption}}}}
      \IfBooleanTF{#1}{\__suep_caption:*{#3}}
        {\IfNoValueTF{#2}{\__suep_caption:{#3}}{\__suep_caption:[#2]{#3}}}}}
\NewDocumentCommand \SUEPCaption {m m}
  {\__suep_if_doctor:T {\tl_if_blank:nT {#2}{\msg_error:nnn {suepthesis}{required}{English~
  caption}}
  }
   \bool_set_true:N \l__suep_bicaption_bool
   \__suep_if_doctor:TF
     {\str_if_eq:eeTF {\use:c {@captype}}{algocf}
        {\caption[#1]{#1\protect\\Algorithm~\thealgocf\quad #2}}
        {\caption[#1]{#1\protect\\[1.63bp]\str_if_eq:eeTF {\use:c {@captype}}{figure}
           {Fig.~\thefigure}{Tab.~\thetable}\quad #2}}}
     {\caption{#1}}
   \bool_set_false:N \l__suep_bicaption_bool}
\NewDocumentCommand \SUEPContinuedCaption {m m}
  {\msg_error:nn {suepthesis}{continued-caption}}
\cs_new:Npn \__suep_longtable_caption:nnnn #1#2#3#4
  {\noalign{\__suep_if_doctor:T
     {\tl_if_blank:nT {#3}{\msg_error:nnn {suepthesis}{required}{English~caption}}}}
   \__suep_lt_caption:[#1]{#2\__suep_if_doctor:T
     {\protect\\[1.63bp]Tab.~\thetable\quad #3#4}}}
\AddToHook{env/longtable/begin}
  {\cs_set_eq:Nc \__suep_lt_caption: {LT@caption}
   \cs_set:cpn {LT@caption}
     {\noalign{\__suep_if_doctor:T {\msg_error:nn {suepthesis}{caption}}}
      \__suep_lt_caption:}
   \cs_set:Npn \SUEPCaption #1#2
     {\__suep_longtable_caption:nnnn {#1}{#1}{#2}{}}
   \cs_set:Npn \SUEPContinuedCaption #1#2
     {\__suep_longtable_caption:nnnn {}{#1（续）}{#2}{~(continued)}}}
\clist_map_inline:nn {chapter,section,subsection}
  {\cs_new_eq:cc {__suep_original_#1}{#1}
   \exp_args:Nc \RenewDocumentCommand {#1}{s o m o}
     {\bool_if:nTF {\g__suep_appendix_bool && \__suep_if_bachelor_p: && \str_if_eq_p:nn {#1}
  {chapter
  } && ! ##1}
        {\int_compare:nNnT {\value{chapter}}>{0}{\clearpage}
         \refstepcounter{chapter}\__suep_original_section*{附录~\arabic{chapter}：##3}
         \phantomsection
         \IfNoValueTF{##2}
           {\addcontentsline{toc}{chapter}{<附录~\arabic{chapter}\protect\quad ##3>}}
           {\addcontentsline{toc}{chapter}{<附录~\arabic{chapter}\protect\quad ##2>}}}
        {\IfBooleanTF{##1}{\use:c {__suep_original_#1}*{##3}}
        {\IfNoValueTF{##2}{\use:c {__suep_original_#1}{##3}}{\use:c {__suep_original_#1}
  [##2]{##3}}}
      \__suep_if_doctor:T
        {\IfNoValueTF{##4}
           {\IfBooleanF{##1}{\msg_error:nnn {suepthesis}{translation}{##3}}}
           {\tl_if_blank:nT {##4}{\msg_error:nnn {suepthesis}{translation}{##3}}
            \bool_if:nTF {##1 || ( ! \g__suep_main_bool && \str_if_eq_p:nn {#1}{chapter} )}
             {\addcontentsline{toe}{suep#1}{##4}}
             {\addcontentsline{toe}{suep#1}{\protect\numberline
               {\str_if_eq:nnT {#1}{chapter}
                  {\bool_if:NTF \g__suep_appendix_bool {Appendix~}{Chapter~}}
                \use:c {the#1}}##4}}}}}}}
\cs_new_protected:Npn \__suep_unnumbered:nn #1#2
  {\group_begin:\__suep_if_bachelor:F
     {\ctexset{chapter={beforeskip=39.39bp,afterskip=41.15bp,
        format=\setstretch{1}\fontsize{16bp}{26bp}\selectfont\__suep_word_heiti:n {.45617}
  \centering
  }}
      \str_if_eq:nnT {#2}{References} {\ctexset{chapter/afterskip=43.756bp}}
      \clist_if_in:nnT {Publications,Research~Projects}{#2}
        {\ctexset{chapter/beforeskip=37.283bp}}}
   \__suep_original_chapter*{#1}\group_end:
   \__suep_if_bachelor:F {\use:c {@afterindenttrue}\use:c {@afterheading}}
   \markboth{#1}{}\phantomsection\addcontentsline{toc}{chapter}{#1}
   \__suep_if_doctor:T {\addcontentsline{toe}{suepchapter}{#2}}}
\RenewDocumentCommand \frontmatter {}
  {\cleardoublepage\bool_gset_false:N \g__suep_main_bool\use:c {@mainmatterfalse}
   \pagenumbering{Roman}\__suep_body_font:
   \__suep_if_bachelor:TF {\pagestyle{suepfront}\ctexset{chapter/pagestyle=suepfront}}{
  \pagestyle{
  suepthesis}}}
\RenewDocumentCommand \mainmatter {}
  {\cleardoublepage\bool_gset_true:N \g__suep_main_bool\use:c {@mainmattertrue}
   \pagenumbering{arabic}\pagestyle{suepthesis}\ctexset{chapter/pagestyle=suepthesis}
  \__suep_body_font:}
\RenewDocumentCommand \backmatter {}
  {\cleardoublepage\bool_gset_false:N \g__suep_main_bool\use:c {@mainmatterfalse}}
\cs_new_protected:Npn \__suep_single_side_end:
  {\clearpage\bool_if:NT \g__suep_twoside_bool
     {\int_if_odd:nF {\value{page}}{\hbox:n {}\thispagestyle{empty}\newpage}}}
\cs_new_protected:Npn \__suep_graduate_cover:n #1
  {\clearpage\thispagestyle{empty}
   \AddToHookNext{shipout/foreground}
     {\group_begin:\dim_set:Nn \unitlength {1bp}
      \int_compare:nNnTF {#1}={1}
        {\__suep_graduate_cover_top:nnn {84.24}{101.558}{12}
         \str_if_eq:VnTF \g__suep_degree_type_tl {professional}
           {\__suep_graduate_cover_heading:nnnn {265.87}{26.04}{1}{专业学位
  \__suep_degree_name: 学位论文}
            \__suep_graduate_cover_english:nnn {302.45}{15}{\text_uppercase:n {
  \__suep_degree_en:
  \c_space_tl Thesis~for~Professional~Degree}}
            \__suep_graduate_cover_logo:n {108.24}
            \__suep_graduate_cover_title:nnnn {370.34}{485.18}{338.5}{0}
            \__suep_graduate_cover_fields:nnnnn {144.84}{515.18}{253.1}{230.75}{14.04}
            \__suep_graduate_cover_date:n {684.46}}
           {\__suep_graduate_cover_heading:nnnn {285.96}{36}{1}
              {\makebox[306bp][s]{\exp_args:Ne \tl_map_inline:nn
                 {\__suep_degree_name: 学位论文}{##1\hfil}\unskip}}
            \__suep_graduate_cover_english:nnn {321.29}{21.96}{Dissertation~for~
  \__suep_degree_en:
  's~Degree}
            \__suep_graduate_cover_logo:n {73.68}
            \__suep_graduate_cover_title:nnnn {419.30}{517.82}{365}{0}
            \__suep_graduate_cover_fields:nnnnn {124.2}{547.82}{242.8}{233.7}{14.04}
            \__suep_graduate_cover_date:n {751.24}}}
        {\str_if_eq:VnTF \g__suep_degree_type_tl {professional}
           {\__suep_graduate_cover_top:nnn {81.36}{111.284}{10.44}
            \__suep_graduate_cover_heading:nnnn {204.026}{24}{0}{上海电力大学}
            \__suep_graduate_cover_heading:nnnn {235.226}{24}{0}{专业学位
  \__suep_degree_name: 学位论文}
            \__suep_graduate_cover_title:nnnn {360.50}{484.07}{280}{1}
            \__suep_graduate_cover_fields:nnnnn {137.4}{514.07}{253.65}{223.4}{12}}
           {\__suep_graduate_cover_top:nnn {85.68}{117.878}{12}
            \__suep_graduate_cover_heading:nnnn {224.45}{24}{2}{上海电力大学
  \__suep_degree_name: 学位论文}
            \__suep_graduate_cover_title:nnnn {354.02}{534.11}{280}{0}
            \__suep_graduate_cover_fields:nnnnn {148.44}{564.11}{250.2}{202}{12}}}
      \group_end:}
   \hbox:n {}\__suep_single_side_end:}
\cs_new_protected:Npn \__suep_graduate_cover_heading:nnnn #1#2#3#4
  {\__suep_declaration_box:nnnnn {0bp}{#1bp}{\paperwidth}
     {\fontsize{#2bp}{40bp}\selectfont
      \int_case:nn {#3}
        {{0}{\__suep_graduate_song_bold:}
         {1}{\heiti}
         {2}{\__suep_word_heiti:n {.6864}}}
      \__suep_punct_style:n {plain}\centering}{#4}}
\cs_new_protected:Npn \__suep_graduate_cover_english:nnn #1#2#3
  {\__suep_declaration_box:nnnnn
     {\str_if_eq:VnTF \g__suep_degree_type_tl {professional}{47.38bp}{40bp}}
     {#1bp}{\paperwidth-80bp}
     {\rmfamily\bfseries\fontsize{#2bp}{28bp}\selectfont\centering}{#3}}
\cs_new_protected:Npn \__suep_resolve_logo:
  {\tl_clear:N \l__suep_logo_file_tl
   \bool_set_false:N \l__suep_vector_logo_bool
   \tl_if_blank:VF \g__suep_logo_tl
     {\str_if_eq:VnTF \g__suep_logo_tl {auto}
        {\bool_set_true:N \l__suep_vector_logo_bool}
        {\file_if_exist:VT \g__suep_logo_tl
           {\tl_set_eq:NN \l__suep_logo_file_tl \g__suep_logo_tl}
         \tl_if_empty:NT \l__suep_logo_file_tl
           {\msg_fatal:nne {suepthesis}{logo-missing}{\tl_use:N \g__suep_logo_tl}}}}}
\cs_new_protected:Npn \__suep_graduate_cover_logo:n #1
  {\bool_if:NTF \l__suep_vector_logo_bool
     {\put(#1,-209.4){\suepname[width=154.8bp]}}
     {\tl_if_empty:NF \l__suep_logo_file_tl
        {\put(#1,-209.4){\includegraphics[width=154.8bp,height=36.84bp,keepaspectratio]{
  \l__suep_logo_file_tl}}}}}
\box_new:N \l__suep_cover_title_box
\dim_new:N \l__suep_cover_title_y_dim
\cs_new_protected:Npn \__suep_cover_title_content:
  {\__suep_full_title:\par
   \rmfamily\bfseries\__suep_info:n {titleEn}\par}
\cs_new_protected:Npn \__suep_graduate_cover_title:nnnn #1#2#3#4
  {\hbox_set:Nn \l__suep_cover_title_box
     {\parbox[t]{447.9bp}{\setstretch{1}\songti\zihao{-4}
        \dim_set:Nn \parindent {0bp}\skip_set:Nn \parskip {0pt}
        \fontsize{21.96bp}{\int_compare:nNnTF {#4}={1}{28.56bp}{32.64bp}}\selectfont
        \heiti\centering
        \__suep_cover_title_content:}}
   \dim_set:Nn \l__suep_cover_title_y_dim
     {\dim_min:nn {#1bp}{#2bp-\box_dp:N \l__suep_cover_title_box}}
   \dim_compare:nNnT {\l__suep_cover_title_y_dim}<{#3bp}
     {\msg_fatal:nn {suepthesis}{cover-title-overflow}}
   \put(56.19,-\dim_to_decimal_in_bp:n {\l__suep_cover_title_y_dim})
     {\box_use_drop:N \l__suep_cover_title_box}}
\cs_new_protected:Npn \__suep_graduate_cover_date:n #1
  {\__suep_declaration_box:nnnnn
     {\str_if_eq:VnTF \g__suep_degree_type_tl {professional}{261.14bp}{242.8bp}}{#1bp}{158bp
  }
     {\fontsize{14.04bp}{20bp}\selectfont\centering}{\g__suep_date_tl}}
\cs_new_protected:Npn \__suep_graduate_cover_top:nnn #1#2#3
  {\fp_compare:nNnTF {#3}<{12}
     {\tl_set:Nn \l_tmpa_tl {22.87}\tl_set:Nn \l_tmpb_tl {251.28}
      \tl_set:Nn \l__suep_cover_data_offset_tl {47.24}\tl_set:Nn
  \l__suep_cover_value_offset_tl {
  278.24}}
     {\tl_set:Nn \l_tmpa_tl {24.48}\tl_set:Nn \l_tmpb_tl {274.92}
      \tl_set:Nn \l__suep_cover_data_offset_tl {54}\tl_set:Nn \l__suep_cover_value_offset_tl
   {304.92
  }}
   \__suep_declaration_box:nnnnn {#1bp}{#2bp}{60bp}
     {\fontsize{#3bp}{\l_tmpa_tl bp}\selectfont}
     {分\hspace{.5em}类\hspace{.5em}号\par 单位代号}
   \__suep_declaration_box:nnnnn {\fp_eval:n {#1+\l_tmpb_tl}bp}{#2bp}{60bp}
     {\fontsize{#3bp}{\l_tmpa_tl bp}\selectfont}
     {密\hspace{.5em}级\par 学\hspace{.5em}号}
   \__suep_declaration_box:nnnnn {\fp_eval:n {#1+\l__suep_cover_data_offset_tl}bp}{#2bp}{
  96bp}
     {\fontsize{12bp}{\l_tmpa_tl bp}\selectfont\centering}
     {\__suep_cover_check_lines:nnn {classification}{96bp}{\__suep_info:n {classification}}
      \mode_leave_vertical:\hbox:n {}\__suep_info:n {classification}\par 10256}
   \__suep_declaration_box:nnnnn {\fp_eval:n {#1+\l__suep_cover_value_offset_tl}bp}{#2bp}{
  96bp}
     {\fontsize{12bp}{\l_tmpa_tl bp}\selectfont\centering}
     {\__suep_cover_check_lines:nnn {classifiedLevel}{96bp}{\__suep_info:n {classifiedLevel}
  }
      \__suep_cover_check_lines:nnn {studentId}{96bp}{\__suep_identity:n {studentId}}
      \mode_leave_vertical:\hbox:n {}\__suep_info:n {classifiedLevel}\par
      \mode_leave_vertical:\hbox:n {}\__suep_identity:n {studentId}}
   \clist_map_inline:nn {0,1}
     {\put(\fp_eval:n {#1+\l__suep_cover_data_offset_tl},-\fp_eval:n {#2+1.392+##1*
  \l_tmpa_tl}){
  \rule{96bp}{.6bp}}
      \put(\fp_eval:n {#1+\l__suep_cover_value_offset_tl},-\fp_eval:n {#2+1.392+##1*
  \l_tmpa_tl}){
  \rule{96bp}{.6bp}}}}
\cs_new_protected:Npn \__suep_graduate_cover_fields:nnnnn #1#2#3#4#5
  {\__suep_graduate_cover_field:nnnnnnn {#1}{#2}{#3}{#4}{#5}{学位申请人}{\__suep_identity:n
  {author}}
   \__suep_graduate_cover_field:nnnnnnn {#1}{\fp_eval:n {#2+28.5}}{#3}{#4}{#5}{指导教师}{
  \__suep_identity:n {supervisor}}
   \__suep_graduate_cover_field:nnnnnnn {#1}{\fp_eval:n {#2+57}}{#3}{#4}{#5}
     {\str_if_eq:VnTF \g__suep_degree_type_tl {professional}{专业名称}{学科专业}}{
  \__suep_info:n {major}}
   \__suep_graduate_cover_field:nnnnnnn {#1}
     {\fp_eval:n {#2+\str_if_eq:VnTF \g__suep_degree_type_tl {professional}{85.5}{114}}}{#3}
  {#4}{#5}
  {学位类别}{\__suep_info:n {degree}}
   \__suep_graduate_cover_field:nnnnnnn
     {\fp_compare:nNnTF {#5}={12}
        {\str_if_eq:VnTF \g__suep_degree_type_tl {professional}{123.6}{#1}}{#1}}
     {\fp_eval:n {#2+\str_if_eq:VnTF \g__suep_degree_type_tl {professional}{114}{142.5}
        -\fp_compare:nNnTF {#5}={12}
        {\str_if_eq:VnTF \g__suep_degree_type_tl {professional}{.54}{0}}{0}}}{#3}{#4}{#5}
     {\fp_compare:nNnTF {#5}>{12}{所属院系}{论文定稿日期}}
     {\fp_compare:nNnTF {#5}>{12}{\__suep_info:n {institute}}{\__suep_info:n {
  finalizationDate}}}
   \str_if_eq:VnF \g__suep_degree_type_tl {professional}
     {\put(#3,-\fp_eval:n {#2+85.5+5.82}){\rule{#4bp}{.48bp}}}}
\seq_new:N \l__suep_cover_field_lines_seq
\cs_new_protected:Npn \__suep_cover_check_lines:nnn #1#2#3
  {\tl_set:Ne \l_tmpa_tl {#3}
   \seq_set_split:NnV \l__suep_cover_field_lines_seq {\\}\l_tmpa_tl
   \int_set:Nn \l_tmpa_int {1}
   \str_if_eq:eeT {#1}{学科专业}{\int_set:Nn \l_tmpa_int {2}}
   \int_compare:nNnT {\seq_count:N \l__suep_cover_field_lines_seq}>{\l_tmpa_int}
     {\msg_fatal:nne {suepthesis}{cover-field-overflow}{#1}}
   \seq_map_inline:Nn \l__suep_cover_field_lines_seq
     {\hbox_set:Nn \l_tmpa_box {##1}
      \dim_compare:nNnT {\box_wd:N \l_tmpa_box}>{#2}
        {\msg_fatal:nne {suepthesis}{cover-field-overflow}{#1}}}}
\cs_new_protected:Npn \__suep_graduate_cover_field:nnnnnnn #1#2#3#4#5#6#7
  {\tl_set:Nn \l_tmpb_tl {5.4}
   \fp_compare:nNnT {#5}={12}
     {\str_if_eq:VnT \g__suep_degree_type_tl {professional}{\tl_set:Nn \l_tmpb_tl {9.93}}}
   \__suep_declaration_box:nnnnn {#1bp}{#2bp}{\fp_eval:n {#3-#1-\l_tmpb_tl}bp}
     {\heiti\fontsize{#5bp}{28.5bp}\selectfont\__suep_punct_style:n {plain}}
     {\tl_set:Ne \l_tmpa_tl {#6：}
      \makebox[\fp_eval:n {#3-#1-\l_tmpb_tl}bp][s]
        {\exp_args:NV \tl_map_inline:nn \l_tmpa_tl {##1\hfil}\unskip}}
   \__suep_declaration_box:nnnnn {#3bp}{#2bp}{#4bp}
     {\fontsize{#5bp}{28.5bp}\selectfont\centering}
     {\__suep_cover_check_lines:nnn {#6}{#4bp}{#7}#7}
   \put(#3,-\fp_eval:n {#2+5.82+\str_if_eq:eeTF {#6}{所属院系}
        {\str_if_eq:VnTF \g__suep_degree_type_tl {professional}{1.04}{0}}{0}}){\rule{#4bp}{
  .48bp}}}
\cs_new_protected:Npn \__suep_bachelor_cover:
  {\clearpage\thispagestyle{empty}
   \AddToHookNext{shipout/foreground}
     {\group_begin:\dim_set:Nn \unitlength {1bp}
      \__suep_declaration_box:nnnnn {171.14bp}{134.9bp}{300bp}
        {\kaiti\bfseries\fontsize{42bp}{50bp}\selectfont}{上海电力大学}
      \__suep_declaration_box:nnnnn {135.26bp}{218.9bp}{360bp}
        {\CJKfamily{suepcover}\bfseries\fontsize{36bp}{43bp}\selectfont\__suep_punct_style:n
   {plain}
  }{本科毕业设计（论文）}
      \bool_if:NTF \l__suep_vector_logo_bool
        {\put(226.55,-428.3){\suepemblem[width=136.7bp]}}
        {\tl_if_empty:NF \l__suep_logo_file_tl
           {\put(226.55,-428.3){\includegraphics[width=136.7bp,height=136.7bp,keepaspectratio]{
  \l__suep_logo_file_tl}}}}
      \__suep_bachelor_cover_field:nnnnn {486.92}{146.06}{216.17}{195.86}{题\hspace{28.08bp}
  目：}
      \__suep_bachelor_cover_value:nnnn {486.92}{216.17}{195.86}{title}
      \__suep_bachelor_cover_field:nnnnn {518.96}{146.06}{216.05}{195.98}{}
      \__suep_bachelor_cover_value:nnnn {518.96}{216.05}{195.98}{subtitle}
      \__suep_bachelor_cover_field:nnnnn {551}{146.06}{223.13}{195.98}
        {学院（部\skip_horizontal:n {-.12bp}）\skip_horizontal:n {-6.92bp}：}
      \__suep_bachelor_cover_value:nnnn {551}{223.13}{195.98}{institution}
      \__suep_bachelor_cover_field:nnnnn {582.92}{146.06}{216.05}{195.98}{专\hspace{28.08bp}
  业：}
      \__suep_bachelor_cover_value:nnnn {582.92}{216.05}{195.98}{major}
      \__suep_bachelor_cover_field:nnnnn {614.96}{146.06}{216.05}{195.98}{年\hspace{28.08bp}
  级：}
      \__suep_bachelor_cover_value:nnnn {614.96}{216.05}{195.98}{grade}
      \__suep_bachelor_cover_field:nnnnn {647.03}{146.06}{216.17}{84}{学生姓名：}
      \__suep_bachelor_cover_value:nnnn {647.03}{216.17}{84}{author}
      \__suep_bachelor_cover_field:nnnnn {647.03}{300.17}{342.19}{69.84}{学号：}
      \__suep_bachelor_cover_value:nnnn {647.03}{342.19}{69.84}{studentId}
      \__suep_bachelor_cover_field:nnnnn {678.95}{146.06}{216.17}{195.86}{指导教师：}
      \__suep_bachelor_cover_value:nnnn {678.95}{216.17}{195.86}{supervisor}
      \__suep_declaration_box:nnnnn {216.17bp}{734.99bp}{195.86bp}
        {\fontsize{14.04bp}{20bp}\selectfont\raggedleft}
        {\bool_if:NTF \g__suep_cover_blank_bool {年\hspace{28.08bp}月\hspace{28.08bp}日}{
  \g__suep_date_tl}}
      \group_end:}
   \hbox:n {}\__suep_single_side_end:}
\cs_new_protected:Npn \__suep_bachelor_cover_field:nnnnn #1#2#3#4#5
  {\__suep_declaration_box:nnnnn {#2bp}{#1bp}{110bp}
     {\fontsize{14.04bp}{20bp}\selectfont\__suep_punct_style:n {plain}}{#5}
   \put(#3,-\fp_eval:n {#1+2.51}){\rule{#4bp}{.72bp}}}
\cs_new_protected:Npn \__suep_bachelor_cover_value:nnnn #1#2#3#4
  {\bool_if:NF \g__suep_cover_blank_bool
     {\__suep_declaration_box:nnnnn {#2bp}{#1bp}{#3bp}
        {\fontsize{14.04bp}{20bp}\selectfont\centering}
        {\__suep_cover_check_lines:nnn {#4}{#3bp}{\__suep_identity:n {#4}}
         \__suep_identity:n {#4}}}}
\NewDocumentCommand \MakeCover {}
  {\__suep_resolve_logo:
   \__suep_if_bachelor:TF {\__suep_bachelor_cover:}{\__suep_graduate_cover:n {1}
  \__suep_graduate_cover:n {2}}}
\cs_new_protected:Npn \__suep_declaration_box:nnnnn #1#2#3#4#5
  {\put(\dim_to_decimal_in_bp:n {#1},-\dim_to_decimal_in_bp:n {#2})
    {\parbox[t]{\dim_eval:n {#3}}{\setstretch{1}\songti\zihao{-4}
       \dim_set:Nn \parindent {0bp}\skip_set:Nn \parskip {0pt}#4#5}}}
\cs_new_protected:Npn \__suep_declaration_date:
  {\makebox[60bp][l]{日期：}年\hspace{18bp}月\hspace{18bp}日}
\cs_new_protected:Npn \__suep_graduate_declaration:nn #1#2
  {\clearpage\thispagestyle{empty}
   \AddToHookNext{shipout/foreground}
     {\group_begin:\dim_set:Nn \unitlength {1bp}
      \str_if_in:nnTF {#1}{原创性声明}
        {\__suep_declaration_box:nnnnn {0bp}{127.49bp}{\paperwidth}
           {\heiti\fontsize{16bp}{20bp}\selectfont\centering}{\leavevmode\color[gray]{0.4}#1
  }
         \__suep_declaration_box:nnnnn {70.92bp}{192.53bp}{453.48bp}
           {\fontsize{12bp}{31.12bp}\selectfont}{\noindent\hspace*{24bp}#2}
         \__suep_declaration_box:nnnnn {301.92bp}{441.53bp}{210bp}{}{学位论文作者签名：}
         \__suep_declaration_box:nnnnn {304.92bp}{472.61bp}{210bp}{}
           {\makebox[66bp][l]{日期：}年\hspace{18bp}月\hspace{18bp}日}}
        {\__suep_declaration_box:nnnnn {0bp}{115.37bp}{\paperwidth}
           {\heiti\fontsize{16bp}{20bp}\selectfont\centering}{\leavevmode\color[gray]{0.4}#1
  }
         \__suep_declaration_box:nnnnn {70.92bp}{157.01bp}{453.48bp}
           {\fontsize{12bp}{23.36bp}\selectfont}{\noindent\hspace*{24bp}#2}
         \__suep_declaration_box:nnnnn {186.36bp}{250.37bp}{300bp}{}
           {{\__suep_graduate_song_bold: 保密}\mbox{\__suep_symbol_font:□}，在\underline{
  \hspace{18bp}}
  年解密后适用本授权书。}
         \__suep_declaration_box:nnnnn {102.36bp}{265.97bp}{100bp}{}{本学位论文属于}
         \__suep_declaration_box:nnnnn {186.6bp}{281.57bp}{180bp}{}{{
  \__suep_graduate_song_bold: 不保密
  }\mbox{\__suep_symbol_font:□}。}
         \__suep_declaration_box:nnnnn {102.36bp}{304.85bp}{300bp}{\__suep_punct_style:n {
  plain}}
           {（请在以上方框内打“{\__suep_symbol_font:√}”）}
         \__suep_declaration_box:nnnnn {102.36bp}{437.09bp}{210bp}{}{学位论文作者签名：}
         \__suep_declaration_box:nnnnn {306.36bp}{437.09bp}{210bp}{}{指导教师签名：}
         \__suep_declaration_box:nnnnn {126.6bp}{483.89bp}{160bp}{}{
  \__suep_declaration_date:}
         \__suep_declaration_box:nnnnn {336.6bp}{483.89bp}{160bp}{}{
  \__suep_declaration_date:}}
      \group_end:}
   \hbox:n {}\__suep_single_side_end:}
\cs_new_protected:Npn \__suep_declaration:nn #1#2
  {\__suep_if_bachelor:TF
    {\clearpage\thispagestyle{empty}
     \AddToHookNext{shipout/foreground}
       {\group_begin:\dim_set:Nn \unitlength {1bp}
        \str_if_in:nnTF {#1}{使用授权声明}
          {\tl_set:Nn \l_tmpa_tl {31.2}}{\tl_set:Nn \l_tmpa_tl {0}}
        \__suep_declaration_box:nnnnn {0bp}{\fp_eval:n {94.11+\l_tmpa_tl}bp}{\paperwidth}
          {\heiti\fontsize{18bp}{31.2bp}\selectfont\centering}{#1}
        \__suep_declaration_box:nnnnn {90.02bp}{\fp_eval:n {186.27+\l_tmpa_tl}bp}{415.28bp}
          {\fontsize{14.04bp}{31.2bp}\selectfont\dim_set:Nn \parindent {28.08bp}
           \sys_if_engine_xetex:T {\punctstyle{suepword}
             \xeCJKsetup{CJKglue={\skip_horizontal:n {-.04bp~plus~.01bp~minus~.01bp}}}}}
          {\indent #2}
        \str_if_in:nnTF {#1}{使用授权声明}
          {\__suep_declaration_box:nnnnn {189.14bp}{560.72bp}{310bp}
             {\fontsize{14.04bp}{31.2bp}\selectfont}{论文作者签名：\hspace{76.98bp}日期：}
           \__suep_declaration_box:nnnnn {189.14bp}{623.15bp}{310bp}
             {\fontsize{14.04bp}{31.2bp}\selectfont}{指导教师签名：\hspace{76.98bp}日期：}}
          {\__suep_declaration_box:nnnnn {182.18bp}{467.12bp}{310bp}
             {\fontsize{14.04bp}{31.2bp}\selectfont}{论文作者签名：\hspace{91.08bp}日期：}}
        \group_end:}
     \hbox:n {}\__suep_single_side_end:}
    {\__suep_graduate_declaration:nn {#1}{#2}}}
\cs_new_protected:Npn \__suep_statement_row:nn #1#2
  {\group_begin:\sys_if_engine_xetex:T {\punctstyle{suepstatement#1}}
   #2\group_end:}
\cs_new_protected:Npn \__suep_statement_period:
  {\sys_if_engine_xetex:TF
     {\hbox_to_wd:nn {9.36bp}{\__suep_punct_style:n {plain}。\hss}}{。}}
\NewDocumentCommand \MakeOriginality {}
  {\bool_if:NF \g__suep_blind_bool
    {\__suep_if_bachelor:TF
      {\__suep_declaration:nn {上海电力大学\par 本科毕业设计（论文）原创性声明}
        {\__suep_statement_row:nn {11.64}{
  本人郑重申明：本人所呈交的毕业论文，是在指导老师的指导下}\\
         \__suep_statement_row:nn {9.36}{
  独立进行研究所取得的成果。论文中凡引用他人已经发布或未发表的}\\
         \__suep_statement_row:nn {12.84}{
  成果、数据、观点等，均已明确注明出处。论文中除已经注明引用的}\\
         \__suep_statement_row:nn {13.92}{
  内容外，不包含任何其他个人或集体已经发表或撰写过的研究成果\__suep_statement_period:}\\
         \__suep_statement_row:nn {9.36}{
  对本文的研究成果做出重要贡献的个人和集体，均已在论文中以明确}\\
         的方式标明。\par 本声明的法律责任由本人承担。}}
      {\__suep_declaration:nn {上海电力大学学位论文原创性声明}
        {
  本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得的成果。
         除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果。
         对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律结果由本人承担。
  }}
     \__suep_if_bachelor:TF
      {\__suep_declaration:nn {上海电力大学\par 本科毕业设计（论文）使用授权声明}
        {\__suep_statement_row:nn {9.36}{
  本人在指导老师的指导下所完成的论文及相关的资料，知识产权}\\
         \__suep_statement_row:nn {11.64}{
  归属上海电力大学。本人完全了解上海电力大学有关保存、使用毕业}\\
         \__suep_statement_row:nn {9.36}{
  论文的规定，同意学校保存或向国家有关部门或机构送交论文的纸质}\\
         \__suep_statement_row:nn {11.64}{
  版或电子版，允许论文被查阅或借阅。本人授权上海电力大学可以将}\\
         \__suep_statement_row:nn {9.36}{
  本毕业论文的全部或部分内容编入有关数据库进行检索，可以采用任}\\
         \__suep_statement_row:nn {11.64}{
  何复制手段保存或编汇本毕业论文。如果发表相关成果，一定征得指}\\
         \__suep_statement_row:nn {11.64}{
  导教师同意，且第一署名单位为上海电力大学。本人毕业后使用毕业}\\
         \__suep_statement_row:nn {9.36}{
  论文或与该论文直接相关的学术论文或成果时，第一署名单位仍然为}\\
         上海电力大学。}}
      {\__suep_declaration:nn {上海电力大学学位论文版权使用授权书}
        {本学位论文作者完全了解学校有关保留、使用学位论文的规定，
         同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。
         本人授权上海电力大学可以将本学位论文的全部或部分内容编入有关数据库进行检索，
         可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。}}}}
\cs_new_protected:Npn \__suep_abstract_begin:n #1
  {\clearpage\group_begin:\__suep_if_bachelor:TF
     {\thispagestyle{suepfront}\setstretch{1.625}\zihao{-4}}
     {\skip_set:Nn \topskip {12pt}
      \pagestyle{suepabstract}\thispagestyle{suepabstract}\setstretch{1.3541667}\zihao{4}}
   \str_if_eq:nnTF {#1}{zh}
     {\markboth{摘要}{}\bool_if:NT \g__suep_abstract_toc_bool
        {\phantomsection\addcontentsline{toc}{chapter}{摘\quad 要}
         \__suep_if_doctor:T {\addcontentsline{toe}{suepchapter}{Chinese~Abstract}}}
      \__suep_if_bachelor:F {\vspace*{15.71bp}\begin{center}\zihao{3}\__suep_word_heiti:n {
  .45617}
  \__suep_full_title:\end{center}\vspace{10.01bp}}
      \vspace*{\__suep_if_bachelor:TF {-1.936bp}{0bp}}
      \begin{center}\__suep_if_bachelor:TF
        {\__suep_bachelor_abstract_heiti:\zihao{-3}摘\hspace{7.68bp}要}
        {\zihao{3}\__suep_word_heiti:n {.45617}摘\quad 要}\end{center}
      \vspace{\__suep_if_bachelor:TF {-10.074bp}{12.04bp}}\songti
      \__suep_if_bachelor:F {\setstretch{1}\fontsize{14bp}{22.68bp}\selectfont}
      \dim_set:Nn \parindent {\__suep_if_bachelor:TF {24bp}{27.96bp}}}
     {\__suep_latin_char:n {"2019}
      \markboth{ABSTRACT}{}\bool_if:NT \g__suep_abstract_en_toc_bool
        {\phantomsection\addcontentsline{toc}{chapter}{ABSTRACT}
         \__suep_if_doctor:T {\addcontentsline{toe}{suepchapter}{Abstract}}}
      \__suep_if_bachelor:TF
        {\vspace*{-14.506bp}\begin{center}\rmfamily\bfseries\zihao{-2}\skip_set:Nn
  \spaceskip {2.5bp
  }\__suep_info:n {titleEn}\end{center}
         \vspace{-17.233bp}\begin{center}\bfseries\zihao{-3}Abstract\end{center}\vspace{
  .088bp}
         \setstretch{1}\fontsize{12bp}{25bp}\selectfont\frenchspacing
         \int_set:Nn \hyphenpenalty {10000}\int_set:Nn \exhyphenpenalty {10000}
         \dim_set:Nn \emergencystretch {3em}}
        {\vspace*{26.19bp}\begin{center}\rmfamily\bfseries\zihao{3}
         \begin{minipage}{\dim_eval:n {\linewidth-5em}}\centering
         \setstretch{1}\fontsize{15.96bp}{22.92bp}\selectfont
         \text_uppercase:n {\__suep_info:n {titleEn}}\end{minipage}\end{center}
         \vspace{137.86bp}\begin{center}\bfseries\zihao{3}ABSTRACT\end{center}\vspace{
  70.50bp}
         \setstretch{1}\fontsize{14.04bp}{20.16bp}\selectfont}
      \rmfamily\dim_set:Nn \parindent {\__suep_if_bachelor:TF {21.6bp}{27.96bp}}}
  \skip_set:Nn
  \parskip {0pt}
   \__suep_if_bachelor:F
     {\dim_add:Nn \hsize {14.28bp}\dim_set_eq:NN \linewidth \hsize
      \skip_set:Nn \leftskip {-14.12bp}}
   \use:c {@afterindenttrue}\use:c {@afterheading}\indent\ignorespaces}
\cs_new_protected:Npn \__suep_keywords:n #1
  {\prop_get:NnN \g__suep_info_prop {#1}\l_tmpa_tl\regex_replace_all:nnN {[；;,，]}{,}
  \l_tmpa_tl
   \clist_set:NV \l_tmpa_clist \l_tmpa_tl
   \__suep_if_bachelor:TF {\clist_use:Nn \l_tmpa_clist {；}}{\clist_use:Nn \l_tmpa_clist {，
  }}}
\cs_new_protected:Npn \__suep_keywords_en:
  {\prop_get:NnN \g__suep_info_prop {keywordsEn}\l_tmpa_tl\regex_replace_all:nnN {[；;,，]}{
  ,}
  \l_tmpa_tl
   \clist_set:NV \l_tmpa_clist \l_tmpa_tl
   \__suep_if_bachelor:TF {\clist_use:Nn \l_tmpa_clist {;~}}
     {\exp_args:Ne \text_lowercase:n {\clist_use:Nn \l_tmpa_clist {,~}}}}
\NewDocumentEnvironment {abstract}{}{\__suep_abstract_begin:n {zh}}
  {\par\vspace{\__suep_if_bachelor:TF {31.2bp}{12bp}}\noindent
   \__suep_if_bachelor:F {\hspace*{27.96bp}}
   \__suep_if_bachelor:TF {{\__suep_bachelor_abstract_heiti: 关键词}{\songti ：}}{{\heiti
  关键词：}}
   \__suep_keywords:n {keywords}\par\clearpage\group_end:}
\NewDocumentEnvironment {abstractEn}{}{\__suep_abstract_begin:n {en}}
  {\par\vspace{\baselineskip}\noindent
   \__suep_if_bachelor:TF {{\bfseries\zihao{-4}Key~Words:\nobreak\space\space}}
     {\hspace*{24bp}\textbf{KEY\hspace{2.814bp}WORDS}{\songti ：}\hspace{-1.204bp}}
   \__suep_keywords_en:\par\clearpage\group_end:}
\NewDocumentCommand \MakeTOC {}
  {\group_begin:\__suep_if_bachelor:TF
     {\ctexset{chapter={beforeskip=9.067bp,afterskip=8.805bp,
        format=\setstretch{1.625}\songti\bfseries\zihao{-3}\centering}}
      \__suep_original_chapter*{\contentsname}
      \dim_set:Nn \hsize {\textwidth-19.589bp}\dim_set_eq:NN \linewidth \hsize}
     {\__suep_latin_char:n {"00B7}
      \ctexset{chapter={beforeskip=40.21bp,afterskip=37.4bp}}
      \__suep_original_chapter*{\contentsname}\markboth{目录}{}
      \phantomsection\addcontentsline{toc}{chapter}{\contentsname}
      \__suep_if_doctor:T {\addcontentsline{toe}{suepchapter}{Contents}}
      \dim_set_eq:NN \hsize \textwidth\dim_set_eq:NN \linewidth \hsize}
   \use:c {@starttoc}{toc}\clearpage\group_end:
   \__suep_if_doctor:T
     {\group_begin:
      \ctexset{chapter={beforeskip=40.418bp,afterskip=39.14bp,
        format=\rmfamily\bfseries\zihao{3}\centering}}
      \__suep_original_chapter*{CONTENTS}\markboth{CONTENTS}{}
      \phantomsection\addcontentsline{toc}{chapter}{CONTENTS}\addcontentsline{toe}{
  suepchapter}{
  Contents~in~English}
      \use:c {@starttoc}{toe}\group_end:\clearpage}}
\NewDocumentEnvironment {conclusion}{}
  {\__suep_if_bachelor:TF {\__suep_unnumbered:nn {结论}{Conclusions}}
     {\ctexset{chapter={beforeskip=62.246bp,afterskip=41.746bp}}
      \ctexset{section/afterskip=17.868bp}
      \chapter{结论与展望}[Conclusions~and~Future~Work]}}{}
\NewDocumentEnvironment {acknowledgements}{+b}
  {\bool_if:NF \g__suep_blind_bool {\__suep_unnumbered:nn {致谢}{Acknowledgements}#1}}{}
\NewDocumentEnvironment {publications}{+b}
  {\__suep_if_bachelor:F {\bool_if:NF \g__suep_blind_bool
    {\__suep_unnumbered:nn {攻读\__suep_degree_name: 学位期间发表学术论文情况}{Publications}
  #1}}}{}
\int_new:N \l__suep_publication_int
\NewDocumentEnvironment {publicationlist}{}
  {\__suep_body_font:\int_zero:N \l__suep_publication_int
   \list{}{\dim_set:Nn \leftmargin {0pt}\dim_set:Nn \rightmargin {0pt}
     \dim_set:Nn \labelwidth {0pt}\dim_set:Nn \labelsep {0pt}
     \dim_set:Nn \itemindent {2\ccwd}\dim_set:Nn \listparindent {0pt}
     \skip_set:Nn \itemsep {0pt}\skip_set:Nn \parsep {0pt}
     \skip_set:Nn \topsep {0pt}\skip_set:Nn \partopsep {0pt}}
   \sloppy\cs_set_eq:NN \__suep_publication_item: \item
   \RenewDocumentCommand \item {}
     {\__suep_publication_item:\int_incr:N \l__suep_publication_int
      \mode_leave_vertical:\hbox:n {[\int_use:N \l__suep_publication_int]}\space}}
  {\endlist\use:c {@endpefalse}}
\NewDocumentEnvironment {research}{+b}
  {\__suep_if_doctor:T {\bool_if:NF \g__suep_blind_bool
    {\__suep_unnumbered:nn {攻读博士学位期间参加的科研工作}{Research~Projects}#1}}}{}
\NewDocumentEnvironment {symbols}{}{\__suep_unnumbered:nn {主要符号对照表}{Symbols}}{}
\NewDocumentEnvironment {appendices}{}
  {\clearpage\bool_gset_true:N \g__suep_main_bool\bool_gset_true:N \g__suep_appendix_bool
   \use:c {@mainmattertrue}\appendix
   \__suep_if_bachelor:TF
     {\__suep_original_chapter*{附录}\ctexset{appendix/number=\arabic{chapter}}
      \cs_set:Npn \thechapter {\arabic{chapter}}
      \setstretch{1}\fontsize{10.5bp}{19.5bp}\selectfont}
     {\ctexset{chapter={name={附录,},number=\Alph{chapter},
        beforeskip=39.39bp,afterskip=41.19bp,
        format=\setstretch{1}\fontsize{16bp}{26bp}\selectfont\__suep_word_heiti:n {.45617}
  \centering
  }}}}
  {\clearpage\bool_gset_false:N \g__suep_main_bool\bool_gset_false:N \g__suep_appendix_bool
  \use:c {
  @mainmatterfalse}}
\AddToHook{package/biblatex/after}
  {\cs_set:Npn \bibfont {\__suep_if_bachelor:TF
     {\setstretch{1}\fontsize{10.5bp}{19.5bp}\selectfont}{\zihao{-4}}}
   \cs_set_eq:NN \supercite \cite
   \ExecuteBibliographyOptions{sorting=none,maxbibnames=3,minbibnames=3}
   \cs_new_eq:NN \__suep_original_finentrypunct: \finentrypunct
   \cs_set:Npn \finentrypunct {\__suep_if_bachelor:T {\__suep_original_finentrypunct:}}}
\AddToHook{package/gbt7714/after}
  {\cs_set_eq:NN \supercite \cite
   \cs_set:Npn \bibfont {\setstretch{1}\songti
     \__suep_if_bachelor:TF {\fontsize{10.5bp}{19.5bp}\selectfont}{\fontsize{12bp}{19.5bp}
  \selectfont}}
   \skip_set:Nn \bibsep {0bp}
   \cs_set_protected:Npn \bibsection {\__suep_unnumbered:nn {参考文献}{References}}
   \cs_new_eq:Nc \__suep_original_bibsetnum:n {NAT@bibsetnum}
   \cs_set_protected:cpn {NAT@bibsetnum} #1
     {\__suep_if_bachelor:TF {\__suep_original_bibsetnum:n {#1}}
        {\dim_set:Nn \leftmargin {0bp}\dim_set:Nn \labelwidth {1.8em}
         \dim_set:Nn \labelsep {.4em}\dim_set:Nn \itemindent {2\ccwd+\labelwidth+\labelsep}
         \skip_set:Nn \itemsep {0bp}\skip_set:Nn \parsep {0bp}}}}
\cs_new_protected:Npn \__suep_bibliography_style:
  {\__suep_if_bachelor:TF
     {\file_if_exist:nTF {gbt7714-2015-numeric.bst}
        {\bibliographystyle{gbt7714-2015-numeric}}
        {\bibliographystyle{gbt7714-numerical}}}
     {\bibliographystyle{suepthesis-graduate}}
   \citestyle{super}}
\NewDocumentCommand \SUEPBibliographyStyle {}
  {\bool_if:NTF \g__suep_profile_locked_bool
     {\msg_error:nnn {suepthesis}{profile-locked}{SUEPBibliographyStyle}}
     {\bool_if:NF \g__suep_bibliography_requested_bool
        {\bool_gset_true:N \g__suep_bibliography_requested_bool
         \AddToHook{begindocument/before}{\__suep_bibliography_style:}}}}
\NewDocumentEnvironment {bibprint}{}
  {\__suep_unnumbered:nn {参考文献}{References}
   \cs_if_exist:cTF {NAT@parse}
     {\cs_set_protected:Npn \bibsection {}\skip_set:Nn \bibsep {0bp}}
     {\skip_set:Nn \bibitemsep {0pt}\skip_set:Nn \bibparsep {0pt}
   \__suep_if_bachelor:F {\defbibenvironment{bibliography}
     {\list{}{\dim_set:Nn \leftmargin {0pt}\dim_set:Nn \itemindent {2\ccwd}
        \dim_set:Nn \labelwidth {0pt}\dim_set:Nn \labelsep {0pt}\skip_set:Nn \itemsep {0pt}
  \skip_set:Nn \parsep {0pt}}}
     {\endlist}{\item\printtext[labelnumberwidth]{\printfield{labelnumber}}\space}}}}{}
\NewDocumentCommand \MakeSpine {}
  {\__suep_if_bachelor:F {\clearpage\group_begin:\thispagestyle{empty}
     \hbox_set:Nn \l_tmpa_box {\songti\zihao{4}\__suep_full_title:\quad
       \__suep_identity:n {author}\quad\__suep_identity:n {studentId}\quad 上海电力大学}
     \dim_compare:nNnT {\box_wd:N \l_tmpa_box}>{23cm}
       {\msg_fatal:nn {suepthesis}{spine-overflow}}
     \noindent\rotatebox{-90}{\parbox[c]{23cm}{\centering\songti\zihao{4}\__suep_full_title:
  \hfill
       \__suep_identity:n {author}\hfill\__suep_identity:n {studentId}\hfill 上海电力大学}}
     \par\clearpage\group_end:}}
\cs_new_protected:Npn \__suep_validate:
  {\clist_map_inline:nn {title,titleEn,major}
     {\prop_get:NnN \g__suep_info_prop {##1}\l_tmpa_tl
      \tl_if_blank:VT \l_tmpa_tl {\msg_error:nnn {suepthesis}{required}{##1}}}
   \clist_map_inline:nn {keywords,keywordsEn}
     {\prop_get:NnN \g__suep_info_prop {##1}\l_tmpa_tl
      \regex_replace_all:nnN {[；;,，]}{,}\l_tmpa_tl\clist_set:NV \l_tmpa_clist \l_tmpa_tl
      \int_set:Nn \l_tmpa_int {\clist_count:N \l_tmpa_clist}
      \__suep_if_bachelor:TF
        {\int_compare:nNnT {\l_tmpa_int}<{3}{\msg_warning:nnnn {suepthesis}{keywords}{3--5}{
  \int_use:N \l_tmpa_int}}
         \int_compare:nNnT {\l_tmpa_int}>{5}{\msg_warning:nnnn {suepthesis}{keywords}{3--5}{
  \int_use:N \l_tmpa_int}}}
        {\int_compare:nNnT {\l_tmpa_int}<{4}{\msg_warning:nnnn {suepthesis}{keywords}{4--6}{
  \int_use:N \l_tmpa_int}}
         \int_compare:nNnT {\l_tmpa_int}>{6}{\msg_warning:nnnn {suepthesis}{keywords}{4--6}{
  \int_use:N \l_tmpa_int}}}
      \str_if_eq:nnTF {##1}{keywords}{\int_set_eq:NN \l_tmpb_int \l_tmpa_int}
        {\int_compare:nNnF {\l_tmpa_int}={\l_tmpb_int}{\msg_warning:nn {suepthesis}{
  keyword-pair}}}}
   \hypersetup{pdftitle={\__suep_full_title:},pdfauthor={\__suep_identity:n {author}},
     pdfsubject={Shanghai~University~of~Electric~Power~Thesis}}}
\__suep_apply_profile:
\AddToHook{begindocument/before}{\bool_gset_true:N \g__suep_profile_locked_bool}
\AddToHook{begindocument}{\__suep_validate:\__suep_body_font:\pagestyle{suepthesis}}
\endinput
%%
%% End of file `suepthesis.cls'.
