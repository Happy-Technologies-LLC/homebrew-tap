class HappyPlatformMcp < Formula
  desc "happy-platform-mcp composition root and command line: wires the trusted root, services, tools and transports."
  homepage "https://github.com/Happy-Technologies-LLC/happy-platform-mcp"
  version "7.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.3/happy-platform-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "4cad2c665594218ce62c3fe4c5edc7f45a8508293fa2bedeedb30388938be4fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.3/happy-platform-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "033a53d2e12954ccb8c94a44debd79786cfec5165e429494df5309fbbe28e264"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.3/happy-platform-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7025c2e52d570ff0ca5e26ea413b43271a34d08bb88fa70747091d6b6dc9ec6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.3/happy-platform-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ac7c6387465a75bedbe4064ed731a2e697500b0e6640dfad082dccfebad58a82"
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
