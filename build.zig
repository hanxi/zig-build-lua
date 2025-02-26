const std = @import("std");

const targets: []const std.Target.Query = &.{
    .{ .cpu_arch = .x86_64, .os_tag = .windows },
    .{ .cpu_arch = .aarch64, .os_tag = .macos },
    .{ .cpu_arch = .x86_64, .os_tag = .macos },
    .{ .cpu_arch = .aarch64, .os_tag = .linux },
    .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .musl },
    .{ .cpu_arch = .x86_64, .os_tag = .linux, .abi = .gnu },
};

pub fn build(b: *std.Build) !void {
    for (targets) |t| {
        const target = b.resolveTargetQuery(t);
        const lua = b.addExecutable(.{
            .name = "lua",
            .target = target,
            .optimize = .ReleaseSafe,
        });

        lua.rdynamic = true;
        lua.linkLibC();

        const flags = [_][]const u8{
            // Standard version used in Lua Makefile
            "-std=gnu99",
            // Define target-specific macro
            switch (target.result.os.tag) {
                .linux => "-DLUA_USE_LINUX",
                .macos => "-DLUA_USE_MACOSX",
                .windows => "-DLUA_USE_WINDOWS",
                else => "-DLUA_USE_POSIX",
            },
        };

        const lua_src = b.dependency("lua", .{});
        lua.addIncludePath(lua_src.path("src"));

        var c_source_files = std.ArrayList([]const u8).init(b.allocator);
        defer c_source_files.deinit();

        const lua_src_path = lua_src.path("src").getPath(b);
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
                try c_source_files.append(b.pathJoin(&.{file_name}));
            }
        }

        lua.addCSourceFiles(.{
            .root = lua_src.path("src"),
            .files = c_source_files.items,
            .flags = &flags,
        });

        const target_output = b.addInstallArtifact(lua, .{
            .dest_dir = .{
                .override = .{
                    .custom = try t.zigTriple(b.allocator),
                },
            },
        });

        b.getInstallStep().dependOn(&target_output.step);
    }
}
