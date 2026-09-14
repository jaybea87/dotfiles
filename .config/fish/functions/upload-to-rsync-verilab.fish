# Upload to bucket
function upload-to-rsync-verilab
    gsutil -m cp $argv gs://rvm-software-update-verilab/rsync/
end
