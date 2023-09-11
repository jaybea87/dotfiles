#!/usr/bin/env bash
BLUE='\033[0;36m'
NC='\033[0m'

# Jenv - auto switching between jvms (https://www.jenv.be/)

# Setup jenv
brew install jenv

echo "Adding temurin 11 to jenv"
jenv add /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home

echo "Adding temurin 17 to jenv"
jenv add /Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home

# This could be made generic by having the user select from a list of "jenv versions"
echo "Setting global java version to 17.0.8.1"
jenv global 17.0.8.1

echo "Disable maven plugin to make sure that .jenv/shims point to the correct version"
jenv disable-plugin maven
echo "Enable maven plugin that makes jenv take control of java version for maven"
jenv sh-enable-plugin maven
echo "Enable export plugin that makes jenv take control of java version for JAVA_HOME"
jenv sh-enable-plugin export

echo "Calling the jenv doctor to make sure everything is all right"
jenv doctor
echo "${BLUE}Note that 'No JAVA_HOME set' is OK as the export plugin requires a new fish session to take effect${NC}"
echo "${BLUE}If any [ERROR]: Try rerunning this script in a new fish session${NC}"
