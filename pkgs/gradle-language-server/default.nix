{
  lib,
  makeWrapper,
  ripgrep,
  stdenvNoCC,
  unzip,
  vscode-utils,
  ...
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "gradle-language-server";
  version = "3.15.0";

  src = vscode-utils.fetchVsixFromVscodeMarketplace {
    publisher = "vscjava";
    name = "vscode-gradle";
    inherit (finalAttrs) version;
    sha256 = "sha256-/aX/6deD+vXF2DF6V/uXji0/0A0jXkTAGRermQDjpNI=";
  };

  nativeBuildInputs = [
    makeWrapper
    ripgrep
    unzip
  ];

  buildPhase = ''
    mkdir -p $out/{share,bin}/

    cp lib/*.jar $out/share/
    cp lib/gradle-server $out/share/
  '';

  installPhase = ''
    GRADLE_SERVER_BASE_JVM_OPTS="$(rg -o 'GRADLE_SERVER_BASE_JVM_OPTS="(.+?)"' -r "\$1" ./dist/index.js)"
    GRADLE_SERVER_OPTS="$GRADLE_SERVER_BASE_JVM_OPTS $(rg -o 'GRADLE_SERVER_OPTS="(.+?)"' -r "\$1" ./dist/index.js)"

    makeWrapper $out/share/gradle-server $out/bin/gradle-language-server \
      --set GRADLE_SERVER_OPTS "$GRADLE_SERVER_BASE_JVM_OPTS"
  '';

  meta = with lib; {
    description = "Gradle Language Server extracted from the Visual Studio Code extension";
    homepage = "https://github.com/microsoft/vscode-gradle";
    license = licenses.mit;
    # sourceProvenance = lib.sourceTypes.binaryBytecode;
  };
})
