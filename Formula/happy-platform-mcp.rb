class HappyPlatformMcp < Formula
  desc "happy-platform-mcp composition root and command line: wires the trusted root, services, tools and transports."
  homepage "https://github.com/Happy-Technologies-LLC/happy-platform-mcp"
  version "7.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.0.3/happy-platform-mcp-aarch64-apple-darwin.tar.xz"
      sha256 "60e33a3362341ed1ac70c394a515722b178c9e8aff3e08cd32acef2a4ac179c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.0.3/happy-platform-mcp-x86_64-apple-darwin.tar.xz"
      sha256 "5ee712d17d19f23261db0c80fdb0f3fc08c38b902a8337a06ac900566ffd9868"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.0.3/happy-platform-mcp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ce8b04fc51a84bab757aae7c3473abc05c244a7a46e681b864a35f7b0aa28498"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Happy-Technologies-LLC/happy-platform-mcp/releases/download/v7.0.3/happy-platform-mcp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aafcb7e8fd490b5e0a0c0af2e1447a5e590d37cdee16f1a4d2a454bceb0e1b8c"
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
