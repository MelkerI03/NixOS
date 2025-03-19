{ lib, ... }:
{
  extraConfigVim = ''
    set number relativenumber
    set tabstop=2
    set shiftwidth=2
  '';
}
