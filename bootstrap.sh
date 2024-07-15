BLUE='\033[0;36m'
NC='\033[0m'

init_workspace () {
    echo "${BLUE}Initializing workspace${NC}"
    mkdir -pv ${HOME}/workspace
}

init_symlinks () {
    echo "${BLUE}Initializing symlinks${NC}"
    echo "Proceed? (y/n)"
    read resp
    if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        mkdir -pv "${HOME}/.config"
        mkdir -pv "${HOME}/.config/fish"
        ln -svf "$PWD/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
        ln -svf "$PWD/.config/fish/alias.fish" "$HOME/.config/fish/alias.fish"
        ln -svf "$PWD/.config/fish/local.fish" "$HOME/.config/fish/local.fish"
        ln -svf "$PWD/.config/fish/export.fish" "$HOME/.config/fish/export.fish"
        ln -svf "$PWD/.config/fish/jenv.fish" "$HOME/.config/fish/jenv.fish"
        ln -svf "$PWD/.config/starship.toml" "$HOME/.config/starship.toml"
        ln -svf "$PWD/.config/fish/functions/git-backup-branch.fish" "$HOME/.config/fish/functions/git-backup-branch.fish"
        ln -svf "$PWD/.config/fish/functions/git-rebase-force.fish" "$HOME/.config/fish/functions/git-rebase-force.fish"
        echo "Symlinking complete"
    else
        echo "Symlinking cancelled"
        return 1
    fi
}

install_homebrew () {
    if [ $( echo "$OSTYPE" | grep 'darwin' ) ] ; then
        echo "${BLUE}Installing homebrew${NC}"
        echo "Proceed? (y/n)"
        read resp
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            sh brew-install.sh
        else
            echo "Homebrew installation cancelled by user"
        fi
    else
        echo "Skipping installations using Homebrew because MacOS was not detected..."
    fi
}

install_tools() {
    if [ $( echo "$OSTYPE" | grep 'darwin' ) ] ; then
        echo "${BLUE}Installing tools found in Brewfile${NC}"
        echo "Proceed? (y/n)"
        read resp
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            echo "Installing tools using brew. This may take a while..."
            # Make sure we’re using the latest Homebrew
            brew update
            # Upgrade any already-installed formulae
            brew upgrade
            # Install tools in Brewfile
            brew bundle
        else
            echo "Tools installation cancelled by user"
        fi
    else
        echo "Skipping installations using Homebrew because MacOS was not detected..."
    fi
}

#install_aws_mfa() {
#    if [ $( echo "$OSTYPE" | grep 'darwin' ) ] ; then
#        echo "${BLUE}Installing aws-mfa${NC}"
#        echo "Proceed? (y/n)"
#        read resp
#        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
#            sh aws-mfa-install.sh
#        else
#            echo "Aws-mfa installation cancelled by user"
#        fi
#    else
#        echo "Skipping installations using Homebrew because MacOS was not detected..."
#    fi
#}

install_jenv() {
    if [ $( echo "$OSTYPE" | grep 'darwin' ) ] ; then
        echo "${BLUE}NB! Requires a fish session - Installing jenv?${NC}"
        echo "Proceed? (y/n)"
        read resp
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            echo "installing jenv"
            sh jenv-install.sh
        else
            echo "skipping jenv"
        fi
    else
        echo "Skipping installations of jenv because MacOS was not detected..."
    fi
}

init_workspace
init_symlinks
install_homebrew
echo "Making sure brew command is available for this session"
eval "$(/opt/homebrew/bin/brew shellenv)"
install_tools
#install_aws_mfa
install_jenv
