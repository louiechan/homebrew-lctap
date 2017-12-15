require 'formula'

VERSION="3.1"

class V2rayCore < Formula
  desc "A platform for building proxies to bypass network restrictions."
  homepage "https://www.v2ray.com/"
  url "https://github.com/v2ray/v2ray-core/releases/download/v#{VERSION}/v2ray-macos.zip"
  version "#{VERSION}"
  sha256 "591a314851519cd22ebe19fd0a02d176132c495fe1d3e1a67bbe71293cd26d0f"
  
  def install
    FileUtils.mv "config.json", "v2ray.json"    
    bin.install "v2ray"
    bin.install "v2ctl"
    bin.install "geoip.dat"
    bin.install "geosite.dat"
    etc.install "v2ray.json"  
  
  end

  plist_options :manual => "v2ray -config=#{HOMEBREW_PREFIX}/etc/v2ray.json"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/v2ray</string>
          <string>-config</string>
          <string>#{etc}/v2ray.json</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    Default config file is  /usr/local/etc/v2ray.json.
    You may turn to https://www.v2ray.com for more help. 
    EOS

  end
  
  test do
    system "#{bin}/v2ray", "-version"
  end
end
