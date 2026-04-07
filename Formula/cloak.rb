class Cloak < Formula
  desc "Invisible overlay for Claude Code and OpenAI Codex"
  homepage "https://github.com/pokharnajay/cloak"
  url "https://github.com/pokharnajay/cloak/releases/download/v0.2.0/Cloak-0.2.0-arm64.zip"
  sha256 "9304f5070cf0a4b9bdd3f1327ed5d39e47c318648f8172455c497005a8b45cb8"
  version "0.2.0"

  def install
    prefix.install "Cloak.app"
  end

  def post_install
    system "xattr", "-cr", "#{prefix}/Cloak.app"
    system "codesign", "--force", "--deep", "--sign", "-", "#{prefix}/Cloak.app"
    ln_sf "#{prefix}/Cloak.app", "/Applications/Cloak.app"
  end

  def caveats
    <<~EOS
      Cloak.app has been linked to /Applications.
      On first launch, grant Accessibility & Screen Recording permissions.
      Toggle with: Option + Space
    EOS
  end

  test do
    assert_predicate prefix/"Cloak.app", :exist?
  end
end
