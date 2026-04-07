cask "cloak" do
  version "0.2.0"
  sha256 "9304f5070cf0a4b9bdd3f1327ed5d39e47c318648f8172455c497005a8b45cb8"

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
