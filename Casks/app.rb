cask "app" do
  version "0.2.0"
  sha256 "0684f41c52134b19b989fffffb374012e553933afe0db6e4c9844321402d0c98"

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
