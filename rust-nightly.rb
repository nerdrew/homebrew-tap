require 'formula'
require 'date'

class RustNightly < Formula
  def self.latest_rust_nightly_revision
    @latest_rust_nightly_revision ||= begin
      Date.parse(`curl --silent --HEAD 'https://static.rust-lang.org/dist/rust-nightly-x86_64-apple-darwin.tar.gz' | grep 'Last-Modified:'`.split(' ', 2).last.strip).to_s
    end
  end

  def self.sha256_checksum
    `curl --silent 'https://static.rust-lang.org/dist/rust-nightly-x86_64-apple-darwin.tar.gz.sha256'`.split.first
  end

  homepage 'http://www.rust-lang.org/'
  url 'https://static.rust-lang.org/dist/rust-nightly-x86_64-apple-darwin.tar.gz'
  version latest_rust_nightly_revision
  sha256 sha256_checksum

  conflicts_with 'rust', :because => 'same'
  conflicts_with 'rust-beta', :because => 'same'

  def install
    args = ["--prefix=#{prefix}"]
    system "./install.sh", *args
  end

  test do
    system "#{bin}/rustc"
    system "#{bin}/rustdoc", "-h"
  end
end
