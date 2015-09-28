require "formula"

class Racer < Formula
  def self.latest_racer_revision
    @latest_racer_revision ||= begin
      Date.parse(`curl --silent --HEAD 'https://api.github.com/repos/phildawes/racer/commits' | grep 'Last-Modified:'`.split(' ', 2).last.strip).to_s
    end
  rescue => e
    warn "Could not curl Last-Modified: #{e.inspect} #{e.backtrace}"
    "2015-01-01"
  end

  url 'https://github.com/phildawes/racer.git'
  version latest_racer_revision

  depends_on "rust-nightly" => :build

  def install
    system "cargo build --release"
    bin.install "target/release/racer"
  end
end
