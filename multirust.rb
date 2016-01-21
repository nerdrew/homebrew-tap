require "tempfile"

class Multirust < Formula
  homepage "https://github.com/brson/multirust"
  desc "Manage multiple Rust installations"

  # Use the tag instead of the tarball to get submodules
  url "https://github.com/brson/multirust.git",
    :tag => "0.7.0",
    :revision => "b222fcd277898c7e364cbe7dfa0cf7edb5d922d5"

  head "https://github.com/brson/multirust.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "835c85c711bc3df23da5eadb11eaaa715e3dba989cb32a52bd9ec37f1a33c7f3" => :el_capitan
    sha256 "a931aa36e3264b5b73a61171b8615428bd79dac7322c0dff5192140f9a340335" => :yosemite
    sha256 "14310f6110a75f9888a2ddb16be8371b1ad72601a1486984fdeaf8a673bc2f4a" => :mavericks
  end

  depends_on :gpg => [:recommended, :run]

  conflicts_with "rust", :because => "both install rustc, rustdoc, cargo, rust-lldb, rust-gdb"

  def caveats
    <<-EOC.undent
      multirust will install toolchains to ~/.multirust by default. Set $MULTIRUST_HOME to use something else.
    EOC
  end

  def install
    system "./build.sh"
    system "./install.sh", "--prefix=#{prefix}"
    tmp = Tempfile.new("multirust-zsh-completion")
    tmp.puts(ZSH_COMPLETION)
    zsh_completion.install(tmp.path => "_multirust")
  ensure
    tmp.close if tmp
    tmp.unlink if tmp
  end

  test do
    system "#{bin}/multirust", "show-default"
  end

  ZSH_COMPLETION = <<-EOC.undent.freeze
    #compdef multirust

    # ------------------------------------------------------------------------------
    # Description
    # -----------
    #
    #  Completion script for multirust
    #
    # ------------------------------------------------------------------------------

    _multirust_default_toolchains() {
      default_toolchains=(stable beta nightly)
    }

    _multirust_installed_toolchains() {
      installed_toolchains=(${(f)"$(_call_program toolchains multirust list-toolchains 2>/dev/null)"})
    }

    local -a _commands
    _commands=(
      'default:Set the default toolchain'
      'override:Set the toolchain override for the current directory tree'
      'update:Install or update a given toolchain'
      'show-override:Show information about the current override'
      'show-default:Show information about the current default'
      'list-overrides:List all overrides'
      'list-toolchains:List all installed toolchains'
      'remove-override:Remove an override, for current directory unless specified'
      'remove-toolchain:Uninstall a toolchain'
      'run:Run a command in an environment configured for a toolchain'
      'delete-data:Delete all user metadata, including installed toolchains'
      'upgrade-data:Upgrade the $MULTIRUST_HOME directory from previous versions'
      'doc:Open the documentation for the currently active toolchain'
      'which:Report location of the currently active Rust tool.'
      'help:Show help for this command or subcommands'
    )

    local expl cmd
    local -a default_toolchains installed_toolchains

    _arguments '*:: :->subcmds' && return 0

    if (( CURRENT == 1 )); then
      _describe -t commands "multirust subcommand" _commands
      return 0
    elif (( CURRENT == 3)) && [[ "${words[1]}" == 'run' ]]; then
      _path_commands
      return 0
    elif (( CURRENT >= 4)) && [[ "${words[1]}" == 'run' ]]; then
      _dispatch ${words[3]} ${words[3]} -default-
      return 0
    fi

    case "${words[(CURRENT - 1)]}" in

      update)
        _arguments \\
          '1: :->forms' \\
          &&  return 0

        if [[ "$state" == forms ]]; then
          _multirust_default_toolchains
          _wanted toolchains expl 'all toolchains' compadd -a default_toolchains
        fi
      ;;

      default|override|update|run|remove-toolchain)
        _arguments \\
          '1: :->forms' \\
          &&  return 0

        if [[ "$state" == forms ]]; then
          _multirust_installed_toolchains
          _wanted toolchains expl 'all toolchains' compadd -a installed_toolchains
        fi
      ;;

    esac
  EOC
end
