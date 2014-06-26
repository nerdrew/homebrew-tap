require "formula"

class Cargo < Formula
  homepage "https://github.com/rust-lang/cargo"
  head "https://github.com/rust-lang/cargo.git"

  depends_on 'rust'

  def install
    args = ["PREFIX=#{prefix}"]
    system "make", *args
    system "make", "install", *args
  end

  test do
    system "#{bin}/cargo"
  end
end
