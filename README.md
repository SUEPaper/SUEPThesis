# SUEPThesis
上海电力大学数学系本科学位论文模板

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
    ├── conclusion.tex
    ├── content.tex
    ├── reference.tex
    └── ref.bib
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

- *不推荐使用 pdflatex 进行编译*

## 致谢

感谢如下项目为本模板提供参考：

- [BIThesis （北京理工大学论文模板）](https://github.com/BITNP/BIThesis)
- [fduthesis（复旦大学论文模板）](https://github.com/stone-zeng/fduthesis)
- [ThuThesis（清华大学论文模板）](https://github.com/tuna/thuthesis)