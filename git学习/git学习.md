集中式：SVN、CVS

分布式：GIT



```
git --global user.name 名字
git --global user.email 邮箱（可以是不存在的邮箱，只是用来确认提交的人）
```

配置文件在`C:\Users\20390\.gitconfig`



```shell
git init # 初始化仓库，创建.git文件，删除这个文件就是删除仓库
git statue # 查看仓库状态
git add <filename> # 将文件添加到暂存区，可以使用通配符*表示所有文件
git commet -m "message，comment注释" <fimename> # 提交到本地库

git clone 远程仓库网址 # 将远程仓库克隆到本地
git remote add 名称（比如origin、github，可自定义）远程仓库网址（SSH协议） # 将远程仓库与本地关联
git remote -v # 查看与本地仓库关联的远程仓库
git remote remove 需要删除的远程仓库名称 # 取消与远程仓库的关联
git push # 推送到远程仓库，前提是已经关联好了远程仓库

git branch -M (名字，比如main) # 将本地当前分支重命名为main
```



克隆远程仓库的时候，不能使用网线连接校园网，只能使用wifi连接。

# git fetch和git pull的区别

`git fetch` 和 `git pull` 都是用于同步远程仓库更新的命令，但它们的执行逻辑和风险程度有本质区别。以下是两者的对比和操作建议：

---

### **1. `git fetch`：仅获取更新，不修改本地代码**
- **作用**：从远程仓库下载最新的提交记录（如分支、标签等），但不会自动合并到当前分支。
- **使用场景**：安全查看远程仓库的变更，手动决定是否合并。
- **命令示例**：
  
  ```bash
  git fetch origin  # 获取 origin 远程仓库的所有更新
  ```
- **操作流程**：
  1. 查看远程分支的更新：
     ```bash
     git log origin/main  # 查看远程 main 分支的提交记录
     ```
  2. 手动合并到本地分支：
     ```bash
     git merge origin/main  # 将远程 main 分支合并到当前分支
     ```

---

### **2. `git pull`：获取更新并自动合并**
- **作用** = `git fetch` + `git merge`，即拉取远程更新并直接合并到当前分支。
- **使用场景**：快速同步远程变更到本地（适合简单项目或单人开发）。
- **命令示例**：
  
  ```bash
  git pull origin main  # 拉取 origin/main 分支并合并到当前分支
  ```
- **潜在风险**：若远程更新与本地代码有冲突，可能直接触发合并冲突，需手动解决。

---

### **关键区别总结**
| 行为                 | `git fetch`                              | `git pull`                             |
| -------------------- | ---------------------------------------- | -------------------------------------- |
| **是否下载远程代码** | ✅ 下载到 `.git` 目录，但**不修改工作区** | ✅ 下载并**直接合并到工作区**           |
| **是否自动合并**     | ❌ 需手动执行 `git merge`                 | ✅ 自动合并（相当于 `fetch` + `merge`） |
| **安全性**           | ⭐⭐⭐⭐ 高（可控）                          | ⭐⭐ 低（可能直接触发冲突）              |
| **适用场景**         | 需要谨慎处理合并时                       | 确定远程更新安全且无冲突时             |

---

### **操作示例：`git fetch` + 手动合并（推荐流程）**
```bash
# 1. 查看远程更新（不修改本地文件）
git fetch origin

# 2. 对比本地分支与远程分支的差异
git diff main origin/main

# 3. 合并远程分支到本地（若差异可接受）
git merge origin/main

# 4. 解决冲突（如果有）
# 手动编辑冲突文件 → git add → git commit
```

---

### **常见问题**
#### **Q1: 为什么推荐优先使用 `git fetch`？**
- **避免意外覆盖**：直接 `git pull` 可能自动合并冲突代码，导致本地未提交的修改丢失。
- **可控性高**：可先通过 `git log` 或 `git diff` 检查远程更新内容，再决定是否合并。

#### **Q2: `git pull` 冲突了怎么办？**
- 冲突文件会被标记，需手动编辑后执行：
  ```bash
  git add .          # 标记冲突已解决
  git commit -m "Resolve merge conflict"
  ```

#### **Q3: 如何撤销一次错误的 `git pull`？**
- 回退到合并前的状态：
  ```bash
  git reset --hard HEAD@{1}  # HEAD@{1} 是 pull 前的提交
  ```

---

### **总结**
- **保守操作**：用 `git fetch` + 手动合并，适合团队协作或复杂项目。
- **激进操作**：用 `git pull`，适合个人项目或确认更新无风险时。
- **始终牢记**：在合并前通过 `git diff` 检查差异，避免盲目操作。







