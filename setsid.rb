require 'formula'

class Setsid < Formula
  head "https://github.com/jerrykuch/ersatz-setsid.git"

  depends_on "git"

  def install
    system "make", "setsid"
    bin.install "setsid"
  end
end
