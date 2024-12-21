{
  jdk,
  lib,
  stdenvNoCC,
  unzip,
  vscode-utils,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "java-debug";
  version = "0.53.0";

  src = vscode-utils.fetchVsixFromVscodeMarketplace {
    publisher = "vscjava";
    name = "vscode-java-debug";
    version = "0.58.2024090204";
    hash = "sha256-xOITwuGoWWFHFETG2R0B+hH8nsPm5w0loT5KAyhJhBQ=";
  };
  nativeBuildInputs = [ unzip ];
  sourceRoot = "extension";

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/share/java-debug"
    install -Dm644 "./server/com.microsoft.java.debug.plugin-${finalAttrs.version}.jar" "$out/share/java-debug/java-debug.jar"
  '';

  meta = {
    description = "The debug server implementation for Java. It conforms to the debug protocol of Visual Studio Code (DAP, Debugger Adapter Protocol)";
    homepage = "https://github.com/microsoft/java-debug";
    license = lib.licenses.epl10;
    platforms = jdk.meta.platforms;
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    maintainers = [ ];
  };
})
