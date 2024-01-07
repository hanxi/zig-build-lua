const std = @import("std");

const Build = std.Build;

pub fn build(b: *Build) void {
    const target = b.standardTargetOptions(.{});
    const os_tag = target.os_tag orelse
        (std.zig.system.NativeTargetInfo.detect(target) catch unreachable).target.os.tag;

    const lua = b.addExecutable(.{
        .name = "lua",
        .target = target,
    });

    lua.linkLibC();
    //lua.addIncludeDir("lua-5.4.6/src");

    const flags = [_][]const u8{
        // Standard version used in Lua Makefile
        "-std=gnu99",

        // Define target-specific macro
        switch (os_tag) {
            .linux => "-DLUA_USE_LINUX",
            .macos => "-DLUA_USE_MACOSX",
            .windows => "-DLUA_USE_WINDOWS",
            else => "-DLUA_USE_POSIX",
        },
    };

    for (lua_54_source_files) |file| {
        lua.addCSourceFile(.{ .file = .{ .path = b.pathJoin(&.{ "lua-5.4.6/src", file }) }, .flags = &flags });
    }

    b.installArtifact(lua);
}

const lua_54_source_files = [_][]const u8{ "lapi.c", "lcode.c", "lctype.c", "ldebug.c", "ldo.c", "ldump.c", "lfunc.c", "lgc.c", "llex.c", "lmem.c", "lobject.c", "lopcodes.c", "lparser.c", "lstate.c", "lstring.c", "ltable.c", "ltm.c", "lundump.c", "lvm.c", "lzio.c", "lauxlib.c", "lbaselib.c", "lcorolib.c", "ldblib.c", "liolib.c", "lmathlib.c", "loadlib.c", "loslib.c", "lstrlib.c", "ltablib.c", "lutf8lib.c", "linit.c", "lua.c" };
