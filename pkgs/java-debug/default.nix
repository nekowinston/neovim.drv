{
  fetchFromGitHub,
  jdk,
  lib,
  maven,
  ...
}:
maven.buildMavenPackage rec {
  pname = "java-debug";
  version = "0.53.0";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-Lke+yyCUqcoGYS6pNYXdQdAn9uZ+S3pk9JVhfakAFvY=";
  };

  buildOffline = true;

  patches = [ ./make-deterministic.patch ];

  manualMvnArtifacts = [ "org.apache.maven.plugins:maven-surefire-plugin:3.2.5" ];

  mvnHash = "sha256-ZucMxrfCK7ybyHp6J/5GtOmHDS0Du86aeI+CypFMvR4=";
  mvnParameters = "-Dproject.build.outputTimestamp=1980-01-01T00:00:02Z";

  installPhase = ''
    mkdir -p "$out/share/java-debug"
    install -Dm644 "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-${version}.jar" "$out/share/java-debug/java-debug.jar"
  '';

  meta = with lib; {
    description = "The debug server implementation for Java. It conforms to the debug protocol of Visual Studio Code (DAP, Debugger Adapter Protocol)";
    homepage = "https://github.com/microsoft/java-debug";
    license = licenses.epl10;
    platforms = jdk.meta.platforms;
    maintainers = [ ];
  };
}
