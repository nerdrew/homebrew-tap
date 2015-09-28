require 'formula'
require 'date'

class RustNightly < Formula
  def self.latest_rust_nightly_revision
    @latest_rust_nightly_revision ||= begin
      Date.parse(`curl --silent --HEAD 'https://static.rust-lang.org/dist/rust-nightly-x86_64-apple-darwin.tar.gz' | grep 'Last-Modified:'`.split(' ', 2).last.strip).to_s
    end
  rescue => e
    warn "Could not curl Last-Modified: #{e.inspect} #{e.backtrace}"
    "1.0.0"
  end

  def self.sha256_checksum
    `curl --silent 'https://static.rust-lang.org/dist/rust-nightly-x86_64-apple-darwin.tar.gz.sha256'`.split.first
  rescue => e
    warn "Could not curl SHA256: #{e.inspect} #{e.backtrace}"
    ""
  end

  homepage 'http://www.rust-lang.org/'
  url 'https://static.rust-lang.org/dist/rust-nightly-x86_64-apple-darwin.tar.gz'
  version latest_rust_nightly_revision
  sha256 sha256_checksum

  conflicts_with 'rust', :because => 'same'
  conflicts_with 'rust-beta', :because => 'same'

  def install
    system "./install.sh", "--prefix=#{prefix}"
  end

  test do
    system "#{bin}/rustc"
    system "#{bin}/rustdoc", "-h"
  end
end
