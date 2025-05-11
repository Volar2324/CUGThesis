# 中国地质大学（武汉）硕士毕业论文 LATEX 模板

本项目为个人使用中国地质大学（武汉）毕业论文 latex 模板，如有需要请自取.

**本模板主要根据 [ucasthesis](https://github.com/mohuangrui/ucasthesis) 项目修改得到. 如需进一步修改可参考原项目, 原项目中包含完整的代码注释.**

## 使用说明

根据示例文件修改对应内容，然后编译 `Thesis.tex` 文件即可.

- `Frontinfo.tex` 文件中修改个人信息;
  - **NOTE:** 修改其中 `\DEGREE{}` 选择不同模板. (Master | MasterFull | Doctor) .
- `Abstract.tex` 文件中输入摘要;
- `Prematter.tex` 文件中输入符号列表（默认没有）;
- `CV.tex` 文件中输入个人简历;
- `CHAPTER0.tex` 文件中输入正文;
  - 若拆分为多个 chapters, 需同时修改 `Mainmatter.tex` 中的输入.
- `Appendix.tex` 中修改附录（默认没有）.  
  
若有 *符号列表* 或 *附录*, 或要添加 *图清单* 和 *表清单*, 将 `Thesis.tex` 文件中对应部分取消注释.

## UPDATE

- ***update on 2025/6/09***.
  > 若要加粗目录中的 `chapter`, 在 `cugthesis.cls` 文件第 906 行末尾添加 `\bfseries`

- ***update on 2025/5/11***.
  > 若不需要 `关键词` (`Key Words`) 缩进，在 `Style/cugthesis.cls` 中搜索 `\keywords` (`\KEYWORDS`)，删除对应的 `\noindent`

- ***update on 2025/3/15***.
  > 将盲审需要删除内容全部移到 `Frontinfo.tex` 中, 注释对应内容可以得到盲审版本.

- ***update on 2025/3/11***.
  > 处理行距问题，原先版本行距设置在 `artratex.sty` 中被重置.

- ***update on 2025/3/3***.
  > 若部分生僻字无法显示. 可以在 `documentclass` 中添加 `fontset` 配置.
  > 更多设置问题可参考: [*https://github.com/mohuangrui/ucasthesis/wiki/字体配置*](https://github.com/mohuangrui/ucasthesis/wiki/%E5%AD%97%E4%BD%93%E9%85%8D%E7%BD%AE).  
  >
  > ```latex
  > % \documentclass[twoside]{Style/cugthesis}%
  > \documentclass[twoside, fontset=windows]{Style/cugthesis}%
  > ```
  > 
  > ***update on 2025/3/11***
  >
  > 这个不知道是什么原因？默认应该是会根据操作系统自动选择字体的。如果默认使用 Fandol 字体建议手动配置 `fontset`, 可以通过目录页的 `二零二五` 字样判断.

- ***update on 2025/2/23***.
  > 模板中默认使用 `algorithm` + `algorithmicx` + `algpseudocode` 来提供算法环境. 若需要使用 `algorithm2e` 宏包, 可注释掉 `Style/artratex.sty` 文件 `618` 行中提供的算法环境, 然后在 `Thesis.tex` 文件中自行导入.
  >
  > **NOTE**: 如果浮动体环境中使用了 `H` 参数, 则还需添加 `float` 包 (默认版本中 `algorithm` 包已经添加了 `float` 包依赖).

## 相关链接

- ucas: [*https://github.com/mohuangrui/ucasthesis*](https://github.com/mohuangrui/ucasthesis);
- Timozer/CUGThesis: [*https://github.com/Timozer/CUGThesis*](https://github.com/Timozer/CUGThesis);
- vscode+latex: [*https://zhuanlan.zhihu.com/p/38178015*](https://zhuanlan.zhihu.com/p/38178015).

## 毕业论文格式

官方链接：[*https://graduate.cug.edu.cn/info/1062/5671.htm*](https://graduate.cug.edu.cn/info/1062/5671.htm)
