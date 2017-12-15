require 'formula'

VERSION="0.9.8"

class Cow < Formula
  homepage 'http://github.com/cyfdecyf/cow/'
  url "https://github.com/cyfdecyf/cow/archive/#{VERSION}.tar.gz"
  sha256 '17ef88ddc69c302ec50f7924c549fc3bcd3ee9abaa73081713024295371cd5e7'

  depends_on "go" => :build 

  def install
    system "go", "get", "github.com/cyfdecyf/cow" 
    system "go", "test"
    system "go", "build"
    FileUtils.mv "cow-#{VERSION}", "cow"    
    bin.install "cow"
    
    docbase = 'https://github.com/cyfdecyf/cow/raw/master/doc'
    system "curl -L #{docbase}/sample-config/rc -o #{prefix}/rc"
  end

  def caveats; <<-EOS.undent
    Example configuration file (with detailed comments): #{prefix}/rc
    Copy it to ~/.cow/rc to use.

    EOS
  end

  # Override Formular#plist_name
  def plist_name; "info.chenyufei.cow" end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
            <string>#{opt_prefix}/bin/cow</string>
        </array>
        <key>KeepAlive</key>
        <true/>
      </dict>
    </plist>
    EOS
  end
end

