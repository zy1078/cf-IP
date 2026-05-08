# git_sync.ps1
# 功能：将当前目录下的 ip.txt 文件强制推送到 GitHub 仓库的指定分支
# 使用场景：配合 Cloudflare IP 优选工具，自动同步优选结果到远程仓库
#
# ⚠️ 安全提醒：使用前请将下方的 $github_token 替换为你自己的 GitHub Personal Access Token
#    切勿将真实令牌提交到公开仓库！

# ==================== GitHub 认证信息（请修改为你的信息） ====================
# 个人访问令牌（Personal Access Token），用于身份验证
$github_token = ""
# GitHub 用户名
$github_username = "zy1078"
# 仓库名称
$repo_name = "cf-IP"
# 目标分支
$branch = "master"

# ==================== 切换到脚本所在目录 ====================
Set-Location $PSScriptRoot

# ==================== 拉取远程最新更新 ====================
git pull origin $branch

git config --global user.email "1017sklhyhy@gmail.com"
git config --global user.name "zy1078"
# ==================== 暂存并提交 ip.txt ====================
git add ip.txt
$commit_msg = "Update ip.txt on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $commit_msg || exit 0

# ==================== 强制推送到 GitHub ====================
git push https://${github_token}@github.com/${github_username}/${repo_name}.git $branch --force

Write-Host "✅ ip.txt 已推送到 GitHub"
