{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "osu-collect";
  version = "0.6.1";
  src = pkgs.fetchurl {
    url = "https://github.com/uwuclxdy/osu-collect/releases/download/v0.6.1/osu-collect-linux-x64";
    hash = "sha256-diT7U9Zzehy0ia2eNv+pKR9aphU8g/vi7GW42eYgUnI=";
  };
  dontUnpack = true;
  nativeBuildInputs = with pkgs; [ autoPatchelfHook ];
  buildInputs = with pkgs; [ openssl gcc.cc.lib ];
  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/osu-collect
    runHook postInstall
  '';
}
