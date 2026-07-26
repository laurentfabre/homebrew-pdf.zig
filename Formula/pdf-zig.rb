# Homebrew formula for pdf.zig.
#
# This is the canonical source — at GA time it gets copied into the
# `laurentfabre/homebrew-pdf.zig` tap repo so users can install via:
#
#   brew tap laurentfabre/pdf.zig
#   brew install pdf.zig
#
# The placeholder SHA256s below are replaced by `scripts/update-formula.sh`
# after a release is cut. That script reads `release/SHA256SUMS` produced
# by the GH Actions release workflow and rewrites the four `sha256` lines.

class PdfZig < Formula
  desc "PDF -> Markdown extraction CLI, NDJSON-streaming, optimized for LLM consumers"
  homepage "https://github.com/laurentfabre/pdf.zig"
  version "2.2.0"
  license "CC0-1.0"

  base_url = "https://github.com/laurentfabre/pdf.zig/releases/download/v#{version}"

  on_macos do
    on_arm do
      url "#{base_url}/pdf.zig-v#{version}-aarch64-macos.tar.gz"
      sha256 "bf82281761fb7a544d31214755e3978fc3ce0f1bbad278410383fb216df8e19f"
    end
    on_intel do
      url "#{base_url}/pdf.zig-v#{version}-x86_64-macos.tar.gz"
      sha256 "4b3573eb2d5f6627d3abac35b51d45fb41a38610df44768528868b46f660a5ab"
    end
  end

  on_linux do
    on_arm do
      url "#{base_url}/pdf.zig-v#{version}-aarch64-linux.tar.gz"
      sha256 "6bbec166703a26d111bf0f95c11064f3ee8eecdfb16127dbca71d487d8b7d419"
    end
    on_intel do
      url "#{base_url}/pdf.zig-v#{version}-x86_64-linux.tar.gz"
      sha256 "aee88d64afcfd27b313271edb66debf6edd2c89f322d4eb33da059a8448080d1"
    end
  end

  def install
    bin.install "bin/pdf.zig"
    bin.install "bin/zpdf"
    lib.install Dir["lib/*"] if Dir.exist?("lib")
    doc.install "README.md", "LICENSE"
  end

  test do
    # Smoke: --version must exit 0 and print a version string.
    assert_match(/pdf\.zig \d/, shell_output("#{bin}/pdf.zig --version"))
    # Help text must mention the streaming-default mode.
    assert_match(/NDJSON/, shell_output("#{bin}/pdf.zig --help"))
  end
end
