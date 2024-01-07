# 使用 zig 编译 lua

## 编译

```bash
zig build
```


交叉编译，比如在 Linux 下编译 exe 文件

```bash
zig build -Dtarget=x86_64-windows
```

输出文件在 zig-out 目录
