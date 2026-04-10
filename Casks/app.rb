cask "app" do
  version "0.2.0"
  sha256 "bba5abc60d9fe989ff7365c9ead2866f0d084d60582eaeac503165f0ad72c52f"

  url "https://github.com/pokharnajay/cloak/releases/download/v#{version}/Cloak-#{version}-arm64.zip"
  name "Cloak"
  desc "Invisible overlay for Claude Code and OpenAI Codex"
  homepage "https://github.com/pokharnajay/cloak"

  depends_on macos: ">= :ventura"

  app "Cloak.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Cloak.app"],
                   sudo: false
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/Cloak.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Cloak",
    "~/Library/Preferences/com.cloak.app.plist",
    "~/Library/Caches/com.cloak.app",
  ]
end
