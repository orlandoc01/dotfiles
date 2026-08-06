#!/usr/bin/env bash
set -e

# Trust third-party sources before a Brewfile can load their packages.
brew trust --tap \
  asmvik/formulae \
  felixkratz/formulae \
  golangci/tap

brew trust --formula \
  asmvik/formulae/skhd \
  asmvik/formulae/yabai \
  felixkratz/formulae/sketchybar \
  golangci/tap/golangci-lint
