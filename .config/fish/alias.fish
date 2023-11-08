# Aliases
alias e='exa --icons --git -laTL 1'

# Google Cloud
alias glogin="gcloud auth login jannik.berg@tomra.com --no-browser && gcloud auth application-default login"

alias gsql-list="gcloud sql instances list"

# Gitlab runner issue (https://gitlab.com/gitlab-org/gitlab-runner/-/issues/3376)
#alias gitlabget = "gcloud container clusters get-credentials gitlab-terraform-gke --region=europe-west1 --project=gitlab-runner-df52"
#alias gitlabkill = "kubectl get pods | grep "^runner-" | grep -e "\s\d*h" | cut -d ' ' -f1 | while read podname; do echo "KILLING $podname"; kubectl delete pod $podname; done"

# Maven
alias mvnp="mvn clean install -Dpackaging=true"
alias mvndc="mvn dependency-check:aggregate -U -DcveValidForHours=24 --fail-at-end"
alias mvntomrasources="mvn dependency:sources -DincludeGroupIds=com.tomra"

# Git
alias gcm="git checkout main"
alias gcb="git checkout $1"
alias gcnb="git checkout -b $1"

# Terraform
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tflock="terraform providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=linux_amd64 -platform=darwin_arm64"
alias tfmove="terraform state mv $1 $2"

# Java
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'