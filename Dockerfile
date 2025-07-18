# 使用一个轻量级的Linux发行版作为基础镜像，例如alpine
FROM alpine:latest

# 设置工作目录
WORKDIR /app

# 创建非 root 用户和用户组
RUN addgroup -g 1000 baidupcs && \
    adduser -u 1000 -G baidupcs -s /bin/sh -D baidupcs

# 将本地的 BaiduPCS-Go 可执行文件复制到镜像中
# 请确保 BaiduPCS-Go 文件在构建时与 Dockerfile 在同一目录或可访问的子目录
# 或者你需要在 docker build 命令中指定 -f 或 --file 来指向 Dockerfile
# 这里假设 BaiduPCS-Go 可执行文件就在构建上下文的根目录
COPY BaiduPCS-Go .

# 赋予 BaiduPCS-Go 可执行权限
RUN chmod +x BaiduPCS-Go

# 切换到非 root 用户
USER baidupcs

# 在容器启动时执行 BaiduPCS-Go
# 使用 CMD ["./BaiduPCS-Go", "command", "arg"] 的形式
# 这允许 Docker 将 BaiduPCS-Go 的标准输出直接捕获为容器日志
# 注意：BaiduPCS-Go 启动后会进入交互模式，如果需要执行特定命令，
# 你可能需要在这里添加，或者通过 docker run 的方式传入
CMD ["./BaiduPCS-Go"]

# 如果 BaiduPCS-Go 内部需要任何端口，可以在这里暴露，但对于命令行工具通常不需要
# EXPOSE 8080
