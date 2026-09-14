# Upload to bucket
function upload-to-rsync-prod
    gsutil -m cp $argv gs://rvm-software-update-prod/rsync/
end
