class TouchAuth < Formula
  desc "The touch-auth util for MacOS"
  homepage "https://github.com/theseal/touch-auth/"
  url "https://github.com/elsagranger/touch-auth/releases/download/1.1/touch-auth.tar.gz"
  sha256 "642ba20356159778bcb1d3d56bce379c3fe0fceeab45580bdc030c57f812a35f"

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
