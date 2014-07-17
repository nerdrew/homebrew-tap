require 'formula'
require 'date'

class RustNightly < Formula
  homepage 'http://www.rust-lang.org/'
  head 'http://static.rust-lang.org/dist/rust-nightly-x86_64-apple-darwin.tar.gz'

  conflicts_with 'rust', :because => 'same'

  def install
    args = ["--prefix=#{prefix}"]
    system "./install.sh", *args
  end

  test do
    system "#{bin}/rustc"
    system "#{bin}/rustdoc", "-h"
  end
end
