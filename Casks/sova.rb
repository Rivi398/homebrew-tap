# Homebrew cask. Lives in the tap repo Rivi398/homebrew-tap as Casks/sova.rb.
# Install: brew install --cask Rivi398/tap/sova
cask "sova" do
  version "1.0.0"
  sha256 "0b943496cc5e201597ad2f1f3fcd0854c81a506b782e69c9fb1311179d159670"

  url "https://github.com/Rivi398/sova/releases/download/v#{version}/Sova-#{version}.zip"
  name "Sova"
  desc "Keep a MacBook awake with the lid closed, from a menu bar switch"
  homepage "https://github.com/Rivi398/sova"

  depends_on macos: :ventura

  app "Sova.app"

  # Sova is ad-hoc signed, not notarized: drop the quarantine flag like other open-source casks do.
  postflight_steps do
    if_path_exists "{{appdir}}/Sova.app" do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Sova.app"]
    end
  end

  uninstall quit:      "ru.studiasok.sova",
            launchctl: "ru.studiasok.sova.guard",
            delete:    [
              "/etc/sudoers.d/sova",
              "/Library/LaunchDaemons/ru.studiasok.sova.guard.plist",
            ]

  zap trash: "~/Library/Preferences/ru.studiasok.sova.plist"
end
