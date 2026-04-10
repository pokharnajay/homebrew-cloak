cask "app" do
  version "0.2.0"
  sha256 "00a7d03c8dea17f857b88a435cd7254d44c7d9c41f2034b30858a89154dc4e38"

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
