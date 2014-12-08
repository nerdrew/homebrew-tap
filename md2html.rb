require 'formula'

class Md2html < Formula
  head 'https://github.com/nerdrew/md2html.git'

  depends_on 'pandoc'

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/md2html.rb"
  end
end
