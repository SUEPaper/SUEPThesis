# 上海电力大学矢量标识原件

- `suep-emblem.svg`：用户提供的 `ref/上海电力大学校徽.svg` 的原样副本。
- `suep-name.svg`：用户提供的 `ref/上海电力大学校标.svg` 的原样副本，包含校徽、中英文校名横向组合。
- 学校 VI 资料与校徽校标标准字制图附件：[VI 设计规范](https://www.shiep.edu.cn/vi/list.htm)。

两个文件均已将文字转为路径。仅转换这些已有轮廓，不重新描摹或替换字体。`scripts/generate-logo.py` 保留 SVG 的曲线、分组平移、填充规则、描边与原色，并移除 A4 画布的外围空白。输出为 `suepthesis-logo.dtx`，源文件 SHA-256 同时写入生成文件；`suepthesis.ins` 提取出独立的 `sueplogo.sty`。

`SUEPRed` 采用学校 VI“校徽红”图示的 `#CC0000`，即 RGB `(204, 0, 0)`。图示同时标注 CMYK `(26, 100, 100, 0)`；宏包的 RGB 定义直接采用图示值，不从 CMYK 换算。

校徽 SVG 原件的红色为 `FF0000`，横向校标原件主要红色为 `BC121D`，另有局部 `CC0000`；默认 `color=original` 保留这些源文件值，`SUEPEmblemRed` 保留独立校徽 SVG 的原始 `FF0000`。使用标准校徽红可设置 `color=SUEPRed`。`color=black` 等单色模式替换非白色部分，保留白色留白。

更新原件后运行：

```sh
python scripts/generate-logo.py
xetex -interaction=nonstopmode -halt-on-error suepthesis.ins
python scripts/generate-logo.py --check
python scripts/check_logo.py
```

生成器只使用 Python 标准库，正常论文编译无需这些 SVG 或 Python。宏包代码遵循仓库 LPPL 许可证；校徽、校名及相关标识权益归上海电力大学，代码许可证不授予学校标识的商标权。宏包组织参考 fduthesis，未复制其复旦大学图形路径。
