require "formula"

class Rustfmt < Formula
  def self.latest_revision
    @latest_revision ||= begin
      Date.parse(`curl --silent --HEAD 'https://api.github.com/repos/rust-lang-nursery/rustfmt/commits' | grep 'Last-Modified:'`.split(' ', 2).last.strip).to_s
    end
  rescue => e
    warn "Could not curl Last-Modified: #{e.inspect} #{e.backtrace}"
    "2015-01-01"
  end

  url 'https://github.com/nrc/rustfmt.git'
  version latest_revision

  depends_on "rust-nightly" => :build

  def install
    system "cargo build --release"
    bin.install "target/release/rustfmt"
  end
end
