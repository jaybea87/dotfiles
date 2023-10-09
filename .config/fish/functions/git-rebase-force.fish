function git_rebase_force
  # Extract the current branch name
  set CURRENT_BRANCH $(git rev-parse --abbrev-ref HEAD)

  if [ "$CURRENT_BRANCH" = "main" ] || [ "$CURRENT_BRANCH" = "master" ]
    echo "Stopping rebasing as you are on $CURRENT_BRANCH."
    return 1
  end

  git_backup_branch $CURRENT_BRANCH
  if test $status -eq 1
    return 1
  end


end