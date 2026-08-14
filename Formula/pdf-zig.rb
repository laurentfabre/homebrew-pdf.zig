# Homebrew formula for pdf.zig — RETIRED.
#
# The upstream repository is no longer public, so the release assets the
# `url` lines below point at are not anonymously fetchable. `disable!`
# rather than `deprecate!`: an install cannot succeed, so it should fail
# with the reason instead of a bare 404 from the download step.
#
# The `url`/`sha256` lines are kept as-is so the digests stay on record.

class PdfZig < Formula
  desc "PDF -> Markdown extraction CLI, NDJSON-streaming, optimized for LLM consumers"
  homepage "https://github.com/laurentfabre/pdf.zig"
  version "2.4.0"
  license "CC0-1.0"

  # Homebrew renders this as "Disabled because it <reason>!", so the string
  # has to read as a continuation. The date is in the past on purpose: a
  # same-day or future date is treated as a pending deprecation, which only
  # warns, and a warning still lets the doomed download run.
  disable! date: "2026-08-13", because: "can no longer be downloaded — the upstream repository is no longer public"

  base_url = "https://github.com/laurentfabre/pdf.zig/releases/download/v#{version}"

  on_macos do
    on_arm do
      url "#{base_url}/pdf.zig-v#{version}-aarch64-macos.tar.gz"
      sha256 "2029996c4736db9f958741c13a0e8148b8ee1b63ccbbd2b3e1a78256eeae6e58"
    end
    on_intel do
      url "#{base_url}/pdf.zig-v#{version}-x86_64-macos.tar.gz"
      sha256 "33ab09ba1be493bc5ef9e741a38973b7ba5bfecbef8af2233091d6c67e7c0ea0"
    end
  end

  on_linux do
    on_arm do
      url "#{base_url}/pdf.zig-v#{version}-aarch64-linux.tar.gz"
      sha256 "adf1cb88b0b43d4e2b5985851f9c82e642f49590c8c09ec96394a834d06acc3c"
    end
    on_intel do
      url "#{base_url}/pdf.zig-v#{version}-x86_64-linux.tar.gz"
      sha256 "ae7f14df88393635af56a599109186020550188724e4d79fc8172deff23dfe32"
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
