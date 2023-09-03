# Java
set -xg JAVA_8_HOME (/usr/libexec/java_home -v1.8)
set -xg JAVA_11_HOME (/usr/libexec/java_home -v11)
set -xg JAVA_17_HOME (/usr/libexec/java_home -v17)

set -xg JAVA {$JAVA_17_HOME}/jre/bin/java
