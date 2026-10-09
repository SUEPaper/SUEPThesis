# SUEPThesis · 上海电力大学学位论文 LaTeX 模板

SUEPThesis 是面向上海电力大学本科、硕士和博士论文的 LaTeX 模板，采用 LaTeX3 开发，支持学术学位与专业学位。排版依据见[学校原始文档](resources/README.md)，完整接口见[使用手册](suepthesis-doc.pdf)。

## 特性

- 通过 `\SUEPSetup` 统一配置论文信息、封面和目录。
- 提供封面、声明、中英文摘要、目录、正文、参考文献、附录与致谢等完整结构。
- 博士论文支持英文目录和中英文图表题注。
- 使用 `gbt7714` 与 BibTeX，按 GB/T 7714—2015 顺序编码制排版参考文献。
- 支持盲审、单双面排版、研究生书脊、字体自动检测及矢量校徽与校标。

## 快速开始

### 1. 准备环境

推荐完整安装 **TeX Live 2026 或更新版本**，使用 **XeLaTeX + BibTeX**，由 `latexmk` 自动完成编译。

### 2. 选择示例

| 论文类型 | 示例入口 | 文档类选项 |
| --- | --- | --- |
| 本科毕业论文 | [本科示例](templates/undergraduate-thesis/main.tex) | `type=bachelor` |
| 学术硕士论文 | [学术硕士示例](templates/graduate-thesis/main.tex) | `type=master,degreeType=academic` |
| 专业硕士论文 | [专业硕士示例](templates/graduate-thesis/main-professional.tex) | `type=master,degreeType=professional` |
| 学术博士论文 | [学术博士示例](templates/doctoral-thesis/main.tex) | `type=doctor,degreeType=academic` |
| 专业博士论文 | [专业博士示例](templates/doctoral-thesis/main-professional.tex) | `type=doctor,degreeType=professional` |

### 3. 编译

Windows PowerShell 在仓库根目录运行：

```powershell
./scripts/build.ps1 -Target bachelor             # 本科
./scripts/build.ps1 -Target master               # 学术硕士
./scripts/build.ps1 -Target master-professional  # 专业硕士
./scripts/build.ps1 -Target doctor               # 学术博士
./scripts/build.ps1 -Target doctor-professional  # 专业博士
./scripts/build.ps1 -Target doc                  # 使用手册
./scripts/build.ps1                              # 全部示例与手册
```

macOS 或 Linux 在仓库根目录运行：

```sh
make all
```

构建会提取文档类和标识宏包，并复制到各示例目录。论文 PDF 位于对应示例目录，手册为根目录的 `suepthesis-doc.pdf`。

### 4. 开始写作

编译后，将对应示例目录完整复制为自己的论文项目。Release 下载包中的示例已包含 `suepthesis.cls`、`sueplogo.sty` 和预览 PDF，可直接复制使用。

- `main.tex` 或 `main-professional.tex`：填写论文信息、组织文档结构。
- `abstract.tex`：中英文摘要。
- `body.tex` 或 `chapters/`：正文。
- `references.bib`：参考文献。

在论文目录运行：

```sh
latexmk -xelatex main.tex
```

专业学位使用 `main-professional.tex`。编辑器或在线环境选择相应主文件、XeLaTeX 和 BibTeX。

## 常用配置

以学术硕士为例，在示例的导言区填写：

```latex
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
    keywords = {电力系统,新能源,优化调度},
    keywordsEn = {Power systems,Renewable energy,Optimal scheduling}
  }
}
```

`type` 和 `degreeType` 是文档类选项；`info/degree` 是封面显示的学位名称。本科使用 `institution` 填写学院（部）。其余字段见各示例。

- **博士双语标题**：标题使用 `\chapter{绪论}[Introduction]` 等形式，图表使用 `\SUEPCaption{中文题目}{英文题目}`。
- **盲审**：设置 `blindPeerReview=true`，隐藏模板中的身份信息并省略声明、致谢和个人成果等页面；正文身份信息可用 `\SecretInfo{真实信息}[替代文本]` 或 `blindPeerReview` 环境处理。
- **字体**：默认自动检测；中文可选 `cjk-font=windows|mac|fandol`，西文可选 `font=times|termes`。跨系统协作可使用 `cjk-font=fandol,font=termes`。
- **单双面与书脊**：本科默认单面，研究生默认双面。设置 `twoside=false` 可切换为单面；研究生在文末调用 `\MakeSpine` 生成书脊文字页。

默认直接读取项目 `fonts/` 中的字体，无需安装到系统；缺失时按字族回退到系统或 TeX Live 字体。独立复制论文项目时，可将根目录的 `fonts/` 一并复制到论文目录；也可通过文档类选项 `font-path=自定义目录` 指定位置，或用 `font-path=none` 禁用项目字体。字体许可见 [fonts/README.md](fonts/README.md)。

## 矢量校徽与校标

模板通过 `sueplogo` 宏包以 TikZ 绘制学校 SVG 轮廓。默认封面自动使用本科校徽或研究生横向组合标识，也可通过 `cover/headerImage` 指定自定义图片。

在普通 LaTeX 文档中可单独使用：

```latex
\usepackage{sueplogo}
\suepemblem[width=3cm]
\suepname[width=8cm]
\suepemblem[width=3cm,color=SUEPRed]
```

校徽、校标及校名书法体版权归上海电力大学所有，原件与来源见 [上海电力大学VI 设计规范](https://www.shiep.edu.cn/vi/list.htm)。。

## 文档与开发

- [使用手册](suepthesis-doc.pdf)：完整接口与排版说明。
- [本科示例说明](templates/undergraduate-thesis/README.md)、[硕士示例说明](templates/graduate-thesis/README.md)、[博士示例说明](templates/doctoral-thesis/README.md)：各学位的填写提示。
- [学校原始文档说明](resources/README.md)：规范来源与参考资料。

文档类及手册统一维护于 `suepthesis.dtx`，矢量标识源码位于 `suepthesis-logo.dtx`，通过 `suepthesis.ins` 提取为 `suepthesis.cls` 和 `sueplogo.sty`。修改后运行 `./scripts/build.ps1` 或 `make all`，编译示例和手册；版式改动需检查生成的 PDF。

欢迎提交 Issue 或 Pull Request。报告问题时请附论文类型、编译环境、最小示例和相关日志。CI 自动构建五份论文示例与手册；推送 `v*` 标签后，Release 提供完整模板 ZIP 和独立使用手册。

## 致谢与许可证

感谢以下项目及其维护者：

- [BIThesis](https://github.com/BITNP/BIThesis)：配置接口、LaTeX3 开发与示例组织的参考。
- [fduthesis](https://github.com/stone-zeng/fduthesis)：字体配置、文档类与独立 Logo 宏包的参考。
- [gbt7714](https://github.com/zepinglee/gbt7714-bibtex-style)：提供国标参考文献样式。

感谢学校规范与示范文档的编写者，以及所有开发者、贡献者与使用者。

本项目遵循 [LaTeX 项目公共许可证（LPPL）](LICENSE) 1.3c 或更新版本。
