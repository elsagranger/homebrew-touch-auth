class TouchAuth < Formula
  desc "The touch-auth util for MacOS"
  homepage "https://github.com/theseal/touch-auth/"
  url "https://github.com/elsagranger/touch-auth/releases/download/1.2/touch-auth.tar.gz"
  sha256 "6018e8fbf92d42a76eea9293016f5520852556581cefdf88fd409f98bae73edc"

  def install
    bin.install "#{name}"
    # The label in the plist must be #{plist_name} in order for `brew services` to work
    # See https://github.com/Homebrew/homebrew-services/issues/376
    inreplace "touch-auth.plist", /<string>com.github.theseal.touch-auth<\/string>/, "<string>#{plist_name}</string>"
    inreplace "touch-auth.plist", %r{/usr/local/bin}, "#{opt_prefix}/bin"
    prefix.install "#{name}.plist" => "#{plist_name}.plist"
  end

  def caveats; <<~EOF
    NOTE: You will need to run the following to load the SSH_ASKPASS environment variable:
      brew services start #{name}
    EOF
  end

  test do
    system "true"
  end

  service do
    name macos: "#{plist_name}"
  end
end
