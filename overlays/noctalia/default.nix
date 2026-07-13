{ noctalia, ... }:
final: prev: {
  noctalia = noctalia.packages.${prev.stdenv.hostPlatform.system}.default;
}
