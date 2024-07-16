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

  manualMvnArtifacts = [
    "org.apache.maven.plugins:maven-jar-plugin:3.4.1"
    "org.apache.maven.plugins:maven-clean-plugin:3.2.0"
    "org.apache.maven.plugins:maven-install-plugin:3.1.2"
    "org.apache.maven.plugins:maven-site-plugin:3.12.1"
    "org.apache.maven.plugins:maven-resources-plugin:3.3.1"
    "org.apache.maven.plugins:maven-deploy-plugin:3.1.2"
    "org.apache.maven.surefire:surefire-junit4:3.2.5"
    "org.apache.maven.plugins:maven-surefire-plugin:3.2.5"
    "org.eclipse.tycho:tycho-p2-plugin:4.0.6"
    "org.eclipse.tycho:tycho-ds-plugin:4.0.6"
    "org.eclipse.tycho:tycho-packaging-plugin:4.0.6"
    "org.eclipse.tycho:tycho-bnd-plugin:4.0.6"
  ];

  mvnHash = "sha256-U8hRHfGPb8AwzoMWVyL3jyaPL9rOy341A9NV7hef2oA=";
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
