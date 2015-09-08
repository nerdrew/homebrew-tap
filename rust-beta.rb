require 'formula'
require 'date'

class RustBeta < Formula
  homepage 'http://www.rust-lang.org/'
  url 'https://static.rust-lang.org/dist/rust-beta-x86_64-apple-darwin.tar.gz'
  version Date.today.to_s

  conflicts_with 'rust', :because => 'same'
  conflicts_with 'rust-nightly', :because => 'same'

  def install
    args = ["--prefix=#{prefix}"]
    system "./install.sh", *args
  end

  test do
    system "#{bin}/rustc"
    system "#{bin}/rustdoc", "-h"
  end
end
