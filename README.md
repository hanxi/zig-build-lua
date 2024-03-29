# use zig to compile lua

Easily cross-compile lua executable files for different platforms, without the need for mingw, gcc and other tools.

## Compile

```bash
zig build
```

Cross-compile, for example, compile exe files on Linux

```bash
zig build -Dtarget=x86_64-windows
```

Output files are in the zig-out directory

## References
  
- [zig](https://ziglang.org/)
- [lua](https://www.lua.org/)

# 使用 zig 编译 lua

方面跨平台交叉编译出 lua 可执行文件，无需 mingw,gcc 等工具。

## 编译

```bash
zig build
```


交叉编译，比如在 Linux 下编译 exe 文件

```bash
zig build -Dtarget=x86_64-windows
```

输出文件在 zig-out 目录

## 参考

- [zig](https://ziglang.org/)
- [lua](https://www.lua.org/)
