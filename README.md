# use zig to compile lua

Easily cross-compile lua executable files for different platforms, without the need for mingw, gcc and other tools.

## Compile

```bash
zig build
```

This whill cross-compile all support platform. Output files are in the zig-out directory.

```
[4.0K]  zig-out/
├── [4.0K]  aarch64-linux
│   └── [3.0M]  lua
├── [4.0K]  aarch64-macos
│   └── [418K]  lua         
├── [4.0K]  x86_64-linux-gnu
│   └── [1.8M]  lua
├── [4.0K]  x86_64-linux-musl
│   └── [2.3M]  lua
└── [4.0K]  x86_64-windows
    ├── [572K]  lua.exe
    └── [1.6M]  lua.pdb
```

## References
  
- [zig](https://ziglang.org/)
- [lua](https://www.lua.org/)

# 使用 zig 编译 lua

方面跨平台交叉编译出 lua 可执行文件，无需 mingw,gcc 等工具。

## 编译

```bash
zig build
```


交叉编译，可以一次性编译出所有平台的 Lua 可执行文件。输出文件在 zig-out 目录。

```
[4.0K]  zig-out/
├── [4.0K]  aarch64-linux
│   └── [3.0M]  lua
├── [4.0K]  aarch64-macos
│   └── [418K]  lua         
├── [4.0K]  x86_64-linux-gnu
│   └── [1.8M]  lua
├── [4.0K]  x86_64-linux-musl
│   └── [2.3M]  lua
└── [4.0K]  x86_64-windows
    ├── [572K]  lua.exe
    └── [1.6M]  lua.pdb
```


## 参考

- [zig](https://ziglang.org/)
- [lua](https://www.lua.org/)
