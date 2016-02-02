require "formula"

class RustNightly < Formula
  env :std
  homepage "http://www.rust-lang.org/"
  head "https://static.rust-lang.org/rustup.sh"

  conflicts_with "rust", :because => "both install rustc, rustdoc, cargo, rust-lldb"
  conflicts_with "multirust", :because => "both install rustc, rustdoc, cargo, rust-lldb"

  def install
    ENV["RUSTUP_HOME"] = HOMEBREW_CACHE.join("rustup")
    system "sh", "--", "rustup.sh", "--prefix=#{prefix}", "--channel=nightly", "--yes", "--disable-sudo", "--save"
    mv bin, libexec
    mkdir_p bin
    libexec.children(false).each do |exe|
      (bin/exe).write_env_script(libexec/exe, :LD_LIBRARY_PATH => lib, :DYLD_LIBRARY_PATH => lib)
      chmod 0555, bin/exe
    end
  end

  test do
    system "#{bin}/rustdoc", "-h"
    (testpath/"hello.rs").write <<-EOS.undent
    fn main() {
      println!("Hello World!");
    }
    EOS
    system "#{bin}/rustc", "hello.rs"
    assert_equal "Hello World!\n", `./hello`
    system "#{bin}/cargo", "new", "hello_world", "--bin"
    assert_equal "Hello, world!",
                 (testpath/"hello_world").cd { `#{bin}/cargo run`.split("\n").last }
  end
end
