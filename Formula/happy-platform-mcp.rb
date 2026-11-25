class HappyPlatformMcp < Formula
  desc "happy-platform-mcp composition root and command line: wires the trusted root, services, tools and transports."
  homepage "https://github.com/Happy-Technologies-LLC/happy-platform-mcp"
  version "7.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.1/happy-platform-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "f720ac2db85edd17d12d7fd91d731c965e9d2a0ff566d651025844834cefaa01"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.1/happy-platform-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "4325b1bf69089c768cba028faeb4fbaf18e103c4173c8223b50720b526fa30e0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.1/happy-platform-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6f71b8f9fa8f2ae7a90ec60b8a57807156d6a9e2c55adb806ea3669261d62390"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.2.1/happy-platform-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7b645ea65038935aa22616278e344ae1ebb6e48643c5604e0b87c22facc0185a"
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
