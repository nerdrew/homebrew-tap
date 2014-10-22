require 'formula'
require 'date'

class CargoNightly < Formula
  homepage "http://crates.io/"
  url 'http://static.rust-lang.org/cargo-dist/cargo-nightly-x86_64-apple-darwin.tar.gz'
  version Date.today.to_s

  depends_on 'rust-nightly'

  def install
    args = ["--prefix=#{prefix}"]
    system "./install.sh", *args
  end

  test do
    system "#{bin}/cargo"
  end
end
