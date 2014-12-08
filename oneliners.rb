require 'formula'

class Oneliners < Formula
  head 'https://github.com/nerdrew/oneliners.git'

  depends_on 'git'
  depends_on 'postgresql'

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
