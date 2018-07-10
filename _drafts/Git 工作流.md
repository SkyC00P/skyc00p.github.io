我们团队现在也是这种模式，master分支用来对外发布，简称稳定版本;beta分支用来对内发布，简称内侧版本；dev分支用来开发，主要承担集成测试的任务；每个工程师根据自己需要做的功能，从dev开新分支进行开发，工程师新开的分支我们简称功能分支，功能分支只能对dev分支提交合并请求。master和beta分支由专人管理，master分支必须是从beta分支提交合并请求，beta分支必须是从dev分支提交合并请求。只有在修复紧急bug的情况下，才能从master或者beta开新分支来进行修复。

*** 

SourceTree

git-flow

***

Master

就是平时我们看到的master，项目的主要分支，对外的第一门面。
所有外人浏览你的项目，使用你的项目，第一时间都是看到master。
你可以把它理解成  稳定无bug发布版 。（任何时候都ready to deploy）
所以，git-flow 要求我们不能在master下做开发。
Develop

处于功能开发最前线的版本，查看develop分支就能知道下一个发布版有哪些功能了。
develop一开始是从master里分出来的，并且定期会合并到master里，
每一次合并到master，表示我们完成了一个阶段的开发，产生一个稳定版。
同样的，develop下也不建议直接开发代码，develop代表的是已经开发好的功能
的回归版本（为什么说回归？）
Feature

带着develop处的疑问，我们在feature里为你解答。（有点长，别不看）
feature的作用是为每一个新功能从develop里创建出来的一个分支。
例如小明和小白分别做两个不相干的功能，就应该分别创建两个分支，
各自开发完以后，先后合并到develop里，这就叫做回归。
在这个过程里，小明小白不需要任何的沟通，分别并行地开发，
git-flow能很好的处理好分支间并行开发的关系。

而develop，则会在适当的时候，由合适的人，合并到master，作为下一个稳定版本。
Hotfix

以上3种以外，还有一个很重要的类型，hotfix。
它是用来修复紧急bug的，而bug通常是来自线上的，
所以hotfix分支是从master里创建出来的，并且，在bug修改好以后，
要同时合并到master和develop，这一点需要特别注意。
Release

release更多倾向与版本发布，项目上线前的一些全面测试以及上线准备。
同样也肩负着版本归档，回滚支持等。

***

https://blog.coding.net/blog/git-workflow-2
http://www.ruanyifeng.com/blog/2016/07/google-monolithic-source-repository.html




