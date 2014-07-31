require "formula"

class CargoNightly < Formula
  homepage "http://http://crates.io/"
  head 'http://static.rust-lang.org/cargo-dist/cargo-nightly-x86_64-apple-darwin.tar.gz'

  depends_on 'rust-nightly'

  def install
    args = ["--prefix=#{prefix}"]
    system "./install.sh", *args
  end

  test do
    system "#{bin}/cargo"
  end
end
