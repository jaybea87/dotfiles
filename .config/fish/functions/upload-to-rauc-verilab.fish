# Upload to bucket
function upload-to-rauc-verilab
    gsutil -m cp $argv gs://rvm-software-update-verilab/rauc/
end
