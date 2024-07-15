{
  fetchFromGitHub,
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

  patches = [ ./make-deterministic.patch ];

  mvnHash = "sha256-Am2jZvQOl+XAGiPK47DWfgaeW609KRHp3D+7XjJ1I3A=";

  installPhase = ''
    mkdir -p "$out/share/java-debug"
    install -Dm644 "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-${version}.jar" "$out/share/java-debug/java-debug.jar"
  '';

  meta = with lib; {
    description = "The debug server implementation for Java. It conforms to the debug protocol of Visual Studio Code (DAP, Debugger Adapter Protocol)";
    homepage = "https://github.com/microsoft/java-debug";
    license = licenses.epl10;
    maintainers = [ ];
  };
}
