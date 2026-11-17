{ pkgs }:
let
  eggDesktop = pkgs.makeDesktopItem {
    name = "eggmouseconfig";
    exec = "EGGMouseConfig";
    desktopName = "EGG Mouse Config";
    comment = "Configure EGG XM2/OP1 8k mice";
    categories = [ "Settings" "HardwareSettings" ];
  };
in
pkgs.stdenv.mkDerivation {
  pname = "unofficial-egg-mouse-config";
  version = "2026-08-22";
  src = pkgs.fetchFromGitHub {
    owner = "niansa";
    repo = "UnofficialEGGMouseConfig";
    rev = "98c48d301f525cab536d38d407558489ad2cac6f";
    hash = "sha256-oELr1B36Ll4EKbTlnGMF+elGsAuJzjvk/udJKZcd6Q4=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = with pkgs; [ cmake pkg-config git ];
  buildInputs = with pkgs; [ glfw freetype hidapi libGL ];
  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "/usr/include/freetype2" "${pkgs.freetype.dev}/include/freetype2"
  '';
  installPhase = ''
    runHook preInstall
    install -Dm755 EGGMouseConfig -t $out/bin
    install -Dm644 ${eggDesktop}/share/applications/* -t $out/share/applications
    runHook postInstall
  '';
}
