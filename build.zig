const std = @import("std");

const Build = std.Build;

pub fn build(b: *Build) !void {
    const target = b.standardTargetOptions(.{});
    const lua = b.addExecutable(.{
        .name = "lua",
        .target = target,
    });

    lua.linkLibC();

    const flags = [_][]const u8{
        // Standard version used in Lua Makefile
        "-std=gnu99",
    };

    const lua_src_path = "lua-5.4.6/src";
    var dir = try std.fs.cwd().openDir(lua_src_path, .{ .iterate = true });
    defer dir.close();

    var dir_it = dir.iterate();
    while (try dir_it.next()) |entry| {
        if (entry.kind != .file) {
            continue;
        }
        const file_name = entry.name;
        if (std.mem.eql(u8, file_name, "luac.c")) {
            continue;
        }
        if (std.mem.endsWith(u8, file_name, ".c")) {
            lua.addCSourceFile(.{ .file = .{ .cwd_relative = b.pathJoin(&.{ lua_src_path, file_name }) }, .flags = &flags });
        }
    }

    b.installArtifact(lua);
}
