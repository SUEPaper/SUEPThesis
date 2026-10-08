# 上海电力大学博士论文示例

从仓库根目录运行 `pwsh ./scripts/build.ps1 -Target doctor`，生成的 PDF 在本目录。
首次使用先运行 `xetex suepthesis.ins`，将生成的 `suepthesis.cls` 复制到本目录。
也可在本目录运行 `latexmk -xelatex main.tex`。

专业博士入口为 `main-professional.tex`，使用 `type=doctor,degreeType=professional`，输出 `main-professional.pdf`。可从根目录运行 `pwsh ./scripts/build.ps1 -Target doctor-professional`。两个入口共用摘要、正文和文献；专业学位名称及专业名称应按学院确认的信息填写。

封面和扉页按硕博参考 PDF 的学术型、专业型区域分别排版，默认由 `sueplogo.sty` 绘制横向矢量校标，独立复制项目时请与 `suepthesis.cls` 一起保留。原 `images/suep-logo.png` 可通过 `cover/headerImage` 显式选择。格式解释、批注框和教学箭头不进入论文输出。

修改 main.tex 中的学位和个人信息，abstract.tex 中的摘要，body.tex 中的正文以及 references.bib 中的文献。
学校要求、格式选择和完整命令见根目录 README.md、resources/README.md 与使用手册。
研究生专业学位使用 `degreeType=professional`。博士标题写法为 `\chapter{中文}[English]`，图表使用 `\SUEPCaption{中文}{English}`。
示例摘要和两条示例文献用于排版演示，正式提交时需满足学校规定的字数和文献数量。

独立复制项目时还须保留 `suepthesis-graduate.bst`。参考文献使用 `gbt7714` 与 BibTeX，`\SUEPBibliographyStyle` 同时固定顺序编码上标引用与学校要求的文献表样式。

学位标记设置在 `main.tex` 的 `\documentclass[...]`：本科 `type=bachelor`，硕士 `type=master`，博士 `type=doctor`；研究生另设 `degreeType=academic` 或 `professional`。请在正文开始前完成设置。

正文使用自然段落、自动目录、普通公式和浮动图表，不含 LaTeX3 实现、MathType 字距或原稿坐标补丁。通用字体与版式由文档类统一处理。`\label` 仅用于实际交叉引用，目录不需要额外的章节标记。
