require 'formula'

class Gitstats < Formula
  homepage 'http://gitstats.sourceforge.net/'
  head 'https://github.com/nerdrew/gitstats.git'

  def install
    system "make", "install", "PREFIX=#{prefix}"
    system "make", "man"
    man1.install "doc/gitstats.1"
  end

  test do
    system "#{bin}/gitstats"
  end
end
