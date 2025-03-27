{
  _sources,
  jdk,
  lib,
  stdenvNoCC,
  unzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  inherit (_sources.java-debug) pname version src;

  nativeBuildInputs = [ unzip ];
  sourceRoot = "extension";

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/share/java-debug"
    cp ./server/com.microsoft.java.debug.plugin-*.jar "$out/share/java-debug/java-debug.jar"
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
