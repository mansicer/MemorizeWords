# 我要记单词

**完成度: 尚未完全完成**

NJU iOS-2020课程大作业, 一个用来记忆与复习单词的App. 目前已导入了5000多个托福单词的数据.

## 代码结构

### MemorizeWords

使用Swift语言编写的XCode项目, 其中UI部分使用SwitUI实现. 

### TOEFLWords

内含多个Python文件和一个初始词表, 实现了Python代码, 以处理

- 从初始词表中提取对应的托福单词内容
- 将每个单词通过有道词典网页版查询, 通过Python库`requests`和`lxml`爬取其释义, 例句等相关内容
- 将爬取到的单词及其内容结构化存储为`json`文件, 供App读取

## CoreML结合

在每天的背单词过程中, 我们都会留下对于已学习过单词的记录, 如果我们认为已学习过的单词反映了用户的一种偏好的话, 实际上我们可以通过学习这种偏好来决定推荐用户学习什么其他单词, 这样的过程中可以构筑一个推荐系统模型. 

在XCode的Create ML软件中允许我们创建简单的推荐系统模型, 但遗憾的是, 我并没有足够的用户数据来让模型训练变得准确, 因此用于训练模型的数据很多是由我自己编造的, 在App中只能起到演示效果.





