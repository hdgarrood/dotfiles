# Harry's dotfiles

To set up:

- Install Lix: <https://git.lix.systems>
- Run `nix-shell -p ruby npingler` (for bootstrapping)
- Run `./install.rb` to put all the dotfiles in the right places
- Run `npingler switch` to install npingler-provided software and pin nixpkgs
- Install a nightly version of WezTerm manually from the website. Unfortunately
  recent versions of macOS don't let unsigned apps (such as nixpkgs-built
  wezterm) send notifications, otherwise I would have it installed from Nix.

Some nice things we have in here:

- [npingler](https://github.com/999years/npingler):
    - npingler uses nix to make it easy to install almost all of the software I
      use on a daily basis with a single command, keep everything in sync
      between different machines, keep track of versions which were previously
      installed, and make it easy to roll changes back if necessary.
    - A lot of the stuff elsewhere in this repo assumes you have GNU
      coreutils at the front of your path, not the BSD ones that come with
      macOS. npingler takes care of this for me.
- [fish shell](https://fishshell.com). In most cases I prefer to stay closer to
  the defaults, but I've found fish to be so much nicer to use than bash or zsh
  that it's a no-brainer for me:
    - completions that almost always work well out of the box
    - history searching without having to ask for it
    - vi key bindings!!! fish's vi key bindings work much better than any other
      shell that I've tried
    - fish sets a $CMD_DURATION variable containing how long the previous
      command took to run (whereas trying to get hold of this information in
      bash and zsh requires cursed hacks that don't really work). This makes it
      possible to implement automatic notifications when long-running commands
      in non-focused windows finish. It's really nice.
- [Neovim](https://neovim.io/) for text editing.
- [Jujutsu](https://www.jj-vcs.dev) instead of git. I really recommend
  switching if you haven't already; I think it only took me about two hours
  before I felt as productive as I used to with git.

## Notes

- Wezterm is deliberately not listed in the npingler config, because it's not
  installed from nixpkgs. Installing from nixpkgs would be my preference, but
  unfortunately the nixpkgs-built version on macOS is not signed by the
  developer, which means it's not allowed to send notifications. The fix is to
  install it from <https://wezterm.org> instead. For some reason, the "stable"
  version of WezTerm offered on the download page of the wezterm website is
  ancient, and in particular it has a bug where notifications don't display
  properly on macOS, which was fixed months ago, so make sure you get the
  nightly version.
- The nix shell prompt indicator assumes you're using Lix for the
  `$NIX_SHELL_LEVEL` environment variable. It also assumes that direnv is only
  ever used for nix shells (which, for me, is pretty much true)

