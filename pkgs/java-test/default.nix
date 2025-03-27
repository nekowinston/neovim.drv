{
  _sources,
  jdk,
  lib,
  stdenvNoCC,
  unzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  inherit (_sources.java-test) pname version src;

  nativeBuildInputs = [ unzip ];
  sourceRoot = "extension";

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/share/java-test"
    cp ./server/*.jar "$out/share/java-test/"
  '';

  meta = {
    description = "Run and debug Java test cases (extracted from VSCode Extension).";
    homepage = "https://github.com/microsoft/java-test";
    license = lib.licenses.mit;
    platforms = jdk.meta.platforms;
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    maintainers = [ ];
  };
})
