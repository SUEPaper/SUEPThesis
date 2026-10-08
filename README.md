# SUEPThesis · 上海电力大学学位论文 LaTeX 模板

SUEPThesis 是面向上海电力大学本科毕业论文、硕士学位论文和博士学位论文的 LaTeX 模板，采用 LaTeX3 开发，通过统一的文档类与配置接口管理论文信息和排版样式。

本项目以仓库提供的学校撰写规范及示范文档为排版依据，支持学术型与专业型研究生论文。开始使用前，建议先编译对应示例，再阅读[使用手册](suepthesis-doc.pdf)并替换为自己的论文内容。手册可通过下文的构建命令生成。

当前规范来源为 [resources/](resources/README.md) 中的四份原始 Word 文档；旧 PDF 的测量结果保留为历史记录。

## 特性

- 支持本科、学术硕士、专业硕士、学术博士和专业博士五种论文类型。
- 内容与样式分离，使用 `\SUEPSetup` 集中填写封面、作者信息、关键词和目录选项。
- 提供封面、声明、中英文摘要、目录、正文、参考文献、附录与致谢等论文结构。
- 博士论文支持独立英文目录，以及中英文图题、表题。
- 使用 `gbt7714` 与 BibTeX 处理参考文献，提供与学校要求配套的研究生文献表样式。
- 支持盲审信息隐藏、单双面排版和研究生书脊文字页。
- 提供字体选择、自动检测与回退机制，以及随示例附带的校徽或校名图片。
- 本科、硕士和博士公式统一使用 `unicode-math` 与 TeX Gyre Termes Math，正文数学字体和字号一致。
- 配套使用手册与可编译示例。

## 快速开始

### 1. 准备环境

使用  TeX Live 2026 或更新版本，推荐完整安装。源码统一采用 UTF-8 编码，推荐使用 **XeLaTeX + BibTeX**，由 `latexmk` 自动完成多轮编译。

LuaLaTeX 已通过五种论文示例的编译及内容检查；学校示范的版式校准以 XeLaTeX 为依据。PDFLaTeX 不适用于本模板。

### 2. 选择论文类型

| 论文类型 | 示例入口 | 文档类选项 |
| --- | --- | --- |
| 本科毕业论文 | [本科示例](templates/undergraduate-thesis/main.tex) | `type=bachelor` |
| 学术硕士论文 | [学术硕士示例](templates/graduate-thesis/main.tex) | `type=master,degreeType=academic` |
| 专业硕士论文 | [专业硕士示例](templates/graduate-thesis/main-professional.tex) | `type=master,degreeType=professional` |
| 学术博士论文 | [学术博士示例](templates/doctoral-thesis/main.tex) | `type=doctor,degreeType=academic` |
| 专业博士论文 | [专业博士示例](templates/doctoral-thesis/main-professional.tex) | `type=doctor,degreeType=professional` |

硕士、博士目录中的两个入口分别填写学位及封面信息，共用摘要、正文、文献与图片。专业学位名称须按学院确认的信息填写。

### 3. 编译示例

在 Windows PowerShell 中，从仓库根目录运行：

```powershell
./scripts/build.ps1 -Target bachelor             # 本科
./scripts/build.ps1 -Target master               # 学术硕士
./scripts/build.ps1 -Target master-professional  # 专业硕士
./scripts/build.ps1 -Target doctor               # 学术博士
./scripts/build.ps1 -Target doctor-professional  # 专业博士
./scripts/build.ps1 -Target doc                  # 使用手册
./scripts/build.ps1                              # 全部示例与手册
```

macOS 或 Linux 可在仓库根目录运行：

```sh
make all
```

构建脚本会提取文档类，并将文档类和研究生文献样式复制到示例目录。论文输出位于对应目录下的 `main.pdf` 或 `main-professional.pdf`；使用手册输出为根目录的 `suepthesis-doc.pdf`。

### 4. 建立自己的论文项目

将对应示例目录完整复制为自己的论文项目，保留其中的图片和编译配置。若从源码仓库开始，先在仓库根目录运行：

```sh
xetex -interaction=nonstopmode -halt-on-error suepthesis.ins
```

把生成的 `suepthesis.cls` 复制到自己的论文目录；研究生项目还需复制根目录的 `suepthesis-graduate.bst`。随后在含主文件的论文目录中运行：

```sh
latexmk -xelatex main.tex
```

专业学位入口改为 `main-professional.tex`。编辑器或在线环境同样应选择正确的主文件、XeLaTeX 引擎和 BibTeX 文献工具。

`templates/` 中的案例可直接用于写作：填写个人信息，替换摘要、正文和文献即可。章、节使用普通 LaTeX 命令，目录、编号、字体和版式由文档类统一处理。示例不包含 LaTeX3 实现代码、逐字字距、手工分页或原稿坐标补丁。

## 模板组成

| 文件或目录 | 用途 |
| --- | --- |
| `suepthesis.dtx` | 使用说明、实现说明与文档类源码的统一维护入口 |
| `suepthesis.ins` | 从 `.dtx` 提取文档类 |
| `suepthesis.cls` | 生成的文档类，复制到论文项目中使用 |
| `suepthesis-doc.tex` | 使用手册的排版入口 |
| `suepthesis-graduate.bst` | 研究生参考文献样式 |
| `templates/undergraduate-thesis/` | 本科写作示例与使用说明 |
| `templates/graduate-thesis/` | 学术硕士、专业硕士示例 |
| `templates/doctoral-thesis/` | 学术博士、专业博士示例 |
| `scripts/` | 构建、检查与发布脚本 |
| `resources/` | 学校提供的格式示范、封面及声明原始文档 |

论文项目中，通常修改 `main.tex` 或 `main-professional.tex` 的信息配置、`abstract.tex` 的摘要、`body.tex` 或 `chapters/` 的正文，以及 `references.bib` 的文献数据库。生成的 `.cls` 文件无需手工修改。

## 使用示例

下面以学术硕士论文为例。编译时需保留示例中的 `images/suep-logo.png` 和 `suepthesis-graduate.bst`。

```latex
% !TeX program = xelatex
% !BIB program = bibtex
\documentclass[type=master,degreeType=academic]{suepthesis}

\SUEPSetup{
  cover = {date = 2026年6月},
  info = {
    title = 面向新能源的电力系统优化研究,
    titleEn = {Optimization of Power Systems with Renewable Energy},
    author = 张三,
    studentId = 20260001,
    supervisor = 李四教授,
    institute = 电气工程学院,
    major = 电气工程,
    degree = 工学硕士,
    classification = TM73,
    classifiedLevel = 公开,
    finalizationDate = 2026年6月1日,
    keywords = {电力系统,新能源,优化调度},
    keywordsEn = {Power systems,Renewable energy,Optimal scheduling}
  }
}

\usepackage{gbt7714}
\SUEPBibliographyStyle

\begin{document}
\MakeCover
\MakeOriginality
\frontmatter
\input{abstract.tex}
\MakeTOC
\mainmatter
\input{body.tex}
\backmatter
\begin{bibprint}
  \bibliography{references}
\end{bibprint}
\begin{acknowledgements}
  感谢指导教师和同学的帮助。
\end{acknowledgements}
\end{document}
```

`type`、`degreeType` 及其别名 `degree` 是文档类选项，应写在 `\documentclass[...]` 中。`info/degree` 表示封面上显示的学位名称，与学位类型选项不同。本科使用 `institution` 填写学院（部），并可填写 `grade` 和 `subtitle`。

博士论文的章、节和三级标题需提供英文译名，例如 `\chapter{绪论}[Introduction]`；图表统一使用 `\SUEPCaption{中文题目}{英文题目}`。模板据此生成英文目录和双语题注。完整结构与接口请查阅使用手册。

## 盲审、字体与装订

文档类选项 `blindPeerReview=true` 可隐藏模板输出的姓名、学号、导师和 PDF 作者信息，并省略声明、致谢、个人成果及科研工作清单。正文中的身份信息可使用 `\SecretInfo{真实信息}[替代文本]` 或 `blindPeerReview` 环境处理；正文、图片和附件仍需作者自行核对。

中文字体选项为 `cjk-font=auto|windows|mac|fandol`，西文字体选项为 `font=auto|times|termes`。默认自动检测可用字体；跨系统协作可选择 `cjk-font=fandol,font=termes`。字体变化可能影响字形与分页，正式提交时请核对院系规定。仓库不分发商业字体。

本科默认单面排版，研究生默认双面排版并从奇数页开始各章。单面预览可设置 `twoside=false`。研究生在文末调用 `\MakeSpine` 可生成书脊文字页，供装订人员按实际厚度裁切。

## 文档与贡献

- [使用手册](suepthesis-doc.pdf)：完整接口、排版规则与使用说明。
- [学校原始文档说明](resources/README.md)：规范来源与原件用途。
- [本科示例说明](templates/undergraduate-thesis/README.md)、[硕士示例说明](templates/graduate-thesis/README.md)、[博士示例说明](templates/doctoral-thesis/README.md)：各学位的使用入口与填写提示。

欢迎通过仓库的问题反馈与合并请求提出改进意见、报告排版问题或贡献代码。反馈时请附上学位类型、编译引擎、TeX 发行版、可复现的最小示例和相关日志。

开发时修改 `suepthesis.dtx`，重新提取文档类，并同步更新手册、示例与相关检查。Windows PowerShell 可运行：

```powershell
./scripts/check-source.ps1  # 源码、示例、版本及 Word 原件检查
./scripts/build.ps1         # 编译全部示例和使用手册
./scripts/check-build.ps1   # 示例与手册编译、数学字体字号与公式编号
```

源码检查与打包使用 Python 标准库；构建环境要求见上文“准备环境”。修改版式后请逐页检查生成的 PDF。

## 重要提醒

学校要求与学院提交说明应以作者收到的最新文件为准。本项目的示例用于演示或核对排版，摘要字数、文献数量、研究内容、成果清单和签名日期等须按实际情况填写。提交前请逐页检查最终 PDF，并保留源码与编译环境信息。

## 特别感谢

SUEPThesis 的开发参考了已有论文模板，并在开源文献样式的基础上适配学校要求。感谢以下项目及其维护者：

- [BIThesis（北京理工大学论文模板）](https://github.com/BITNP/BIThesis)：为统一配置接口、LaTeX3 开发及示例和使用手册的组织提供了参考。
- [fduthesis（复旦大学论文模板）](https://github.com/stone-zeng/fduthesis)：为字体组配置、文档类编写和源码文档组织提供了参考。
- [gbt7714（国标 BibTeX 文献样式）](https://github.com/zepinglee/gbt7714-bibtex-style)：提供了本项目使用的参考文献工具；研究生文献样式基于其顺序编码样式调整。

同时感谢学校论文撰写规范与示范文档的编写、整理者，这些资料为封面、正文及各类前后置页面的实现和版式校验提供了依据。

以及所有参与本项目的开发者、贡献者与使用者。谢谢你们！

## 许可证

本项目遵循 [LaTeX 项目公共许可证（LPPL）](LICENSE) 1.3c 或更新版本。
