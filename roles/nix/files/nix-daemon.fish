#!/usr/bin/env fish
# --8<-- [This file is automatically generated from /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh, do not edit] ---
# Only execute this file once per shell.
if test -n "$__ETC_PROFILE_NIX_SOURCED" ; exit 0; end
set -g  __ETC_PROFILE_NIX_SOURCED 1

set -xg NIX_USER_PROFILE_DIR /nix/var/nix/profiles/per-user/$USER
set -xg NIX_PROFILES /nix/var/nix/profiles/default $HOME/.nix-profile

# Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.
if test ! -z "$NIX_SSL_CERT_FILE"
    true # Allow users to override the NIX_SSL_CERT_FILE
else if test -e /etc/ssl/certs/ca-certificates.crt  # NixOS, Ubuntu, Debian, Gentoo, Arch
    set -xg NIX_SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
else if test -e /etc/ssl/ca-bundle.pem  # openSUSE Tumbleweed
    set -xg NIX_SSL_CERT_FILE /etc/ssl/ca-bundle.pem
else if test -e /etc/ssl/certs/ca-bundle.crt  # Old NixOS
    set -xg NIX_SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt
else if test -e /etc/pki/tls/certs/ca-bundle.crt  # Fedora, CentOS
    set -xg NIX_SSL_CERT_FILE /etc/pki/tls/certs/ca-bundle.crt
else
  # Fall back to what is in the nix profiles, favouring whatever is defined last.
  for i in $NIX_PROFILES
    if test -e $i/etc/ssl/certs/ca-bundle.crt
      set -xg NIX_SSL_CERT_FILE $i/etc/ssl/certs/ca-bundle.crt
    end
  end
end

set -xg NIX_PATH nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs /nix/var/nix/profiles/per-user/root/channels
set -xg PATH $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin $PATH

# --8<-- EOF ---