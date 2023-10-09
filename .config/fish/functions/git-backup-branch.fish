function git_backup_branch --argument branch
  echo "Making sure backup branch is created"
  set BRANCH_BACKUP $branch-backup
  git show-ref --verify --quiet refs/heads/$BRANCH_BACKUP
  if test $status -eq 1
    echo "Creating backup branch $BRANCH_BACKUP"
    git branch $BRANCH_BACKUP
    if test $status -eq 0
      echo "$BRANCH_BACKUP created"
    else
      echo "Something went wrong..."
      return 1
    end
  else
    echo "Backup branch already exists"
    # Should probably update the backup branch
  end
end