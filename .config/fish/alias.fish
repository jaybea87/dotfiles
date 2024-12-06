# Aliases
alias e='exa --icons --git -laTL 1'

# Google Cloud
alias glogin="gcloud auth login jannik.berg@tomra.com --no-browser && gcloud auth application-default login"
alias gproject-list="gcloud projects list"
alias gproject-set="gcloud config set project $1"
alias gcompute-list="gcloud compute instances list"
alias gsql-list="gcloud sql instances list"

# Kubectl
alias k="kubectl"
alias kc="kubectl config get-contexts"
alias kcs-eu="kubectl config use-context gke_eu-prod-mx006-dt644_europe-west1_gke-autopilot-cluster-eu-prod"
alias kcs-us="kubectl config use-context gke_us-prod-mx006-dt644_us-central1_gke-autopilot-cluster-us-prod"
alias kcs-au="kubectl config use-context gke_au-prod-mx006-dt644_australia-southeast1_gke-autopilot-cluster-au-prod"
alias kcs-eu-test="kubectl config use-context gke_eu-test-mx006-dt644_europe-west1_gke-autopilot-cluster-eu-test"
alias kcs-eu-lab="kubectl config use-context gke_eu-lab-mx006-dt643_europe-west1_gke-autopilot-cluster-eu-lab"
alias kgp="kubectl get pods"
alias kgp-yaml="kubectl get pod $1 -o yaml"
alias kdp="kubectl describe pods $1"
alias kgs="kubectl get secrets"
alias klogs="kubectl logs -f $1"
alias kshell="kubectl exec $1 -it --/bin/sh"

# Gitlab runner issue (https://gitlab.com/gitlab-org/gitlab-runner/-/issues/3376)
#alias gitlabget = "gcloud container clusters get-credentials gitlab-terraform-gke --region=europe-west1 --project=gitlab-runner-df52"
#alias gitlabkill = "kubectl get pods | grep "^runner-" | grep -e "\s\d*h" | cut -d ' ' -f1 | while read podname; do echo "KILLING $podname"; kubectl delete pod $podname; done"

# Maven
alias mvnp="mvn clean install -Dpackaging=true"
alias mvndc="mvn dependency-check:aggregate -U -DcveValidForHours=24 --fail-at-end"
alias mvntomrasources="mvn dependency:sources -DincludeGroupIds=com.tomra"
alias mvnlatest="mvn versions:use-latest-versions -Dincludes=com.tomra\*\:\* && mvn versions:update-parent && mvn versions:commit"

# Git
alias gcb="git checkout $1"
alias gcnb="git checkout -b $1"

# Terraform
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tflock="terraform providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=linux_amd64 -platform=darwin_arm64"
alias tfmove="terraform state mv $1 $2"
alias tfrm="terraform state rm $1"

# Java
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'

# Docker
alias docker-run="docker run -i -t $1 /bin/bash"

# Fish to zsh
alias unset="set --erase"
