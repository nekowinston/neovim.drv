{
  fetchFromGitHub,
  jdk,
  lib,
  maven,
  ...
}:
maven.buildMavenPackage rec {
  pname = "java-debug";
  version = "0.53.1";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-7h2U0l8OE8VrXymggfQ3XSXacvfBbQKCJmQVSo8J4M0=";
  };

  patches = [ ./make-deterministic.patch ];

  buildOffline = true;
  mvnHash = "sha256-vvsMPUfvbwXx6oYqz43UwkqGND7rynK51el7W5ZOWRY=";
  mvnParameters = lib.escapeShellArgs [
    "-Dproject.build.outputTimestamp=1980-01-01T00:00:02Z"
    "--projects=com.microsoft.java.debug.core"
  ];
  manualMvnArtifacts = [ "org.apache.maven.surefire:surefire-junit4:3.2.5" ];

  installPhase = ''
    mkdir -p "$out/share/java-debug"
    install -Dm644 "com.microsoft.java.debug.core/target/com.microsoft.java.debug.core-${version}.jar" "$out/share/java-debug/java-debug.jar"
  '';

  meta = with lib; {
    description = "The debug server implementation for Java. It conforms to the debug protocol of Visual Studio Code (DAP, Debugger Adapter Protocol)";
    homepage = "https://github.com/microsoft/java-debug";
    license = licenses.epl10;
    platforms = jdk.meta.platforms;
    maintainers = [ ];
  };
}
