cask "cloak" do
  version "0.2.0"
  sha256 "db7ec80237aa5f21effecad4990fb96b53e93265c2c9c8da7db9dc7f4835db6a"

  url "https://github.com/pokharnajay/cloak/releases/download/v#{version}/Cloak-#{version}-arm64.dmg"
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
