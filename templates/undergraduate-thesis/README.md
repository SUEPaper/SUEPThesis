# 上海电力大学本科论文示例

从仓库根目录运行 `pwsh ./scripts/build.ps1 -Target bachelor`，或在本目录运行 `latexmk -xelatex main.tex`。输出为 `main.pdf`。首次使用先从根目录运行 `xetex suepthesis.ins`，并将生成的 `suepthesis.cls` 复制到本目录。

填写 `main.tex` 中的姓名、学号、导师、学院、专业、年级、题目和关键词，修改 `abstract.tex` 中的中英文摘要。`body.tex` 按顺序载入 `chapters/` 中的引言、方法与结论；致谢、文献和附录也放在该目录。所有段落自然换行、分页，章节与公式自动编号，目录直接用 `\MakeTOC` 生成。

写章节只需 `\chapter{引言}` 和 `\section{研究背景}`。`\label` 用于需要引用的图表或公式，配合 `\ref`、`\eqref` 使用；它不是目录链接所需的补丁。示例不包含 LaTeX3 实现代码、Word 字距、原稿坐标或手工编号，通用字体、页眉、间距和版式统一由文档类处理。

参考文献使用 `gbt7714`、BibTeX 和 `\SUEPBibliographyStyle`，按 GB/T 7714—2015 顺序编码制编排，与硕士、博士共用国标样式，兼容新旧版本宏包。修改 `references.bib` 并在正文中使用 `\cite`。示例仅提供一条演示文献，正式论文应填写实际引用的完整记录，满足学校要求的数量与类型。

默认字体由文档类检测。无 Windows 字体的环境可使用 `\documentclass[type=bachelor,cjk-font=fandol,font=termes]{suepthesis}`。无需在正文中调用 `fontspec`；封面默认由 `sueplogo.sty` 绘制矢量校徽，独立复制时与 `suepthesis.cls` 一起保留。原 PNG 是可选资源，可通过 `cover/headerImage` 显式选择。

正文、历史界面截图和附录数据仅用于展示排版。正式写作时替换为自己的研究结果与图表。章、节、目录与编号由文档类自动处理。

学校要求与完整接口见根目录 README.md、resources/README.md 和使用手册。

默认优先读取项目字体，无需安装到系统。独立复制本目录时，可将仓库根目录的 fonts/ 一并复制到论文目录；也可通过文档类选项 font-path 指定其他字体目录。缺少项目字体时自动检测系统或 TeX Live 字体。
