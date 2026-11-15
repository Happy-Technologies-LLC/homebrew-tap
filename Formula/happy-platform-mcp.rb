class HappyPlatformMcp < Formula
  desc "happy-platform-mcp composition root and command line: wires the trusted root, services, tools and transports."
  homepage "https://github.com/Happy-Technologies-LLC/happy-platform-mcp"
  version "7.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.0.2/happy-platform-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "c8bfb61ab7d4127953657e52b3204873a1e541e6cda328bacafc07aca1f8f676"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.0.2/happy-platform-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "0944ded5bd427361facf53650b6f640237685b15c1379a9d208ba99fc1f2080e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.0.2/happy-platform-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fbdda3c29a215e2051f01f7e66d3fdf0c77a1ff0ea31fbfb8a4ffd6361b04451"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.0.2/happy-platform-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d3f812b98bd0e8f4167a4a6633d3d952159c32e9408f8a6a7bfffed507b5a0a4"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "happy-platform-mcp", "happy-platform-mcp-http", "servicenow-mcp-server"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "happy-platform-mcp", "happy-platform-mcp-http", "servicenow-mcp-server"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "happy-platform-mcp", "happy-platform-mcp-http", "servicenow-mcp-server"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "happy-platform-mcp", "happy-platform-mcp-http", "servicenow-mcp-server"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
