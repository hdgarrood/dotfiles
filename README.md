# Harry's dotfiles

To set up:

- Install Lix: <https://git.lix.systems>
- Run `nix-shell -p ruby npingler` (for bootstrapping)
- Run `./install.rb` to put the dotfiles in the right places
- Run `npingler switch`
- Install WezTerm (make sure to get the nightly version on macOS)

Some nice things we have in here:

- npingler
    - use nix to keep software in sync between different machines, and be able
      to easily roll changes back
    - A lot of the stuff elsewhere in this repo assumes you have GNU
      coreutils at the front of your path, not the BSD ones that come with
      macOS. npingler takes care of this
- fish shell: just switch if you haven't already, you'll be converted within
  minutes
- also fish vi key bindings. fish is the only program I've ever used that isn't
  vim/neovim which had vi key bindings which didn't suck lol
- jujutsu for vcs. Just switch if you're still on git.
- done.fish for notifications when long-running terminal processes finish

## Notes

- For whatever reason, the "stable" macOS WezTerm is ancient. download the
  nightly one. in particular the "stable" release has a bug where notifications
  just don't work on macOS, which was fixed months ago
- The nix shell prompt indicator assumes you're using Lix for the
  `$NIX_SHELL_LEVEL` environment variable. It also assumes that direnv is only
  ever used for nix shells (which, for me, is pretty much true)

