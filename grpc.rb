require 'formula'

class Grpc < Formula
  homepage "https://github.com/grpc/grpc"
  head "https://github.com/nerdrew/grpc.git"

  depends_on "autoconf"
  depends_on "automake"
  depends_on "cmake"
  depends_on "gflags"
  depends_on "libtool"

  def install
    system "make", "install", "prefix=#{prefix}"
  end
end
