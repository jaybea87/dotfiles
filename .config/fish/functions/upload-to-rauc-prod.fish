# Upload to bucket
function upload-to-rauc-prod
    gsutil -m cp $argv gs://rvm-software-update-prod/rauc/
end
