{
  jdk,
  lib,
  stdenvNoCC,
  unzip,
  vscode-utils,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "java-debug";
  version = "0.43.0";

  src = vscode-utils.fetchVsixFromVscodeMarketplace {
    publisher = "vscjava";
    name = "vscode-java-test";
    version = "0.43.0";
    hash = "sha256-EM0S1Y4cRMBCRbAZgl9m6fIhANPrvdGVZXOLlDLnVWo=";
  };
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
