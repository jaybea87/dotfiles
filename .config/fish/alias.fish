# Aliases
alias e='exa --icons --git -laTL 1'

# Google Cloud
alias glogin="gcloud auth login && gcloud auth application-default login"

# Maven
alias mvnp="mvn clean install -Dpackaging=true"
alias mvndc="mvn dependency-check:aggregate -U -DcveValidForHours=24 --fail-at-end"


# Java
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'

