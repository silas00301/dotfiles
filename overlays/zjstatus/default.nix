{ pkgs, ... }:
final: prev: {
  zjstatus = pkgs.zjstatus.packages.${prev.system}.default;
}
