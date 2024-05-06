# SUEPThesis

上海电力大学学位论文模板，目前支持本科生毕业论文，硕士和博士论文正在开发中（等老学长忙于996的工作中，等老学长百忙之中抽空慢慢实现把所有学位论文模板补齐

*当前本科毕业论文模板仅在数理学院数学系使用，不是官方正式的LaTeX模板。如果能联系到本科生院或者研究生院老师，并且本科生院或者研究生院有意向提供官方LaTeX模板，我们很高兴有机会和官方达成战略合作。*

**请尽可能使用最新版本撰写文章，我们的代码仓库是：https://github.com/SUEPaper/SUEPThesis 。**

## 项目结构

```sh
.
├── README.md
├── images
│   ├── logo.png
│   └── logo_black.png
├── output
│   ├── ...
│   └── main.pdf
├── fonts
│   ├── ...
│   └── simhei.ttf
├── main.tex
├── latexmkrc
├── suepthesis.cls
└── content
    │────chapters
    │    ├── chapter1.tex
    │    └── chapter2.tex
    ├── abstract.tex
    ├── appendix.tex
    ├── acknowledgements.tex
    ├── reference.tex
    └── thesis.bib
```

## 编译方式

方式一（推荐）：

```
latexmk
```

方式二：

```
-> xelatex
-> biber
-> xelatex
-> xelatex
```

- _不推荐使用 pdflatex 进行编译_

## 致谢

感谢如下项目为本模板提供参考：

- [SJTUTex (上海交通大学论文模板)](https://github.com/sjtug/SJTUTeX)
- [fduthesis（复旦大学论文模板）](https://github.com/stone-zeng/fduthesis)
- [ThuThesis（清华大学论文模板）](https://github.com/tuna/thuthesis)
- [BIThesis （北京理工大学论文模板）](https://github.com/BITNP/BIThesis)
