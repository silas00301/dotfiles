{ zjstatus, ... }:
final: prev: {
  zjstatus = zjstatus.packages.${prev.stdenv.hostPlatform.system}.default;
}
