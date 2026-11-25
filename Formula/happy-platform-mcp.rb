class HappyPlatformMcp < Formula
  desc "happy-platform-mcp composition root and command line: wires the trusted root, services, tools and transports."
  homepage "https://github.com/Happy-Technologies-LLC/happy-platform-mcp"
  version "7.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.2/happy-platform-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "fe76dce15fedf913192baf14cfe1fe4469d9a60c07bac0e1a86d0efa75bcda31"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.2/happy-platform-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "3f5d0351371737f47ce5d7ab3c5eb69faf4c0365e1a9d3c2c79f787671bd6288"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.2/happy-platform-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0f91014476fe7943d1ad9a07306f019ef35869ed9320dfbd6a47446ebb24cfc3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.2/happy-platform-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a03dc7ff4f3fd3f0a42d3b3fc17de5186d25999259ffb3e551c4b0ed163641a7"
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
