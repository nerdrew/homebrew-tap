require 'formula'

class Oneliners < Formula
  head 'https://github.com/nerdrew/oneliners.git'

  depends_on 'git'
  depends_on 'jq'
  depends_on 'postgresql' => :optional

  def install
    system "make", "install", "PREFIX=#{prefix}"
    zsh_completion.install "completion/cargo-open.zsh" => "_cargo-open"
    zsh_completion.install "completion/git-find-reviewers.zsh" => "_git-find-reviewers"
    zsh_completion.install "completion/git-fresh.zsh" => "_git-fresh"
  end
end
