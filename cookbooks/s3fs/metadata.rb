maintainer       "Hobsons"
maintainer_email "pmcfadin@hobsons.com"
license          "Apache 2.0"
description      "Installs/Configures s3fs"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

recipe           "s3fs", "Installs s3fs from source"
recipe           "mount", "Mounts S3 bucket using s3fs"

depends          "build-essential"

attribute "s3fs/aws_access_key_id",
  :display_name => "AWS Access Key for S3fs",
  :description => "",
  :required => true,
  :recipes => [ "s3fs::mount"]
  
attribute "s3fs/aws_secret_access_key",
  :display_name => "AWS Secret Access Key for S3fs",
  :description => "",
  :required => true,
  :recipes => [ "s3fs::mount"]
  
attribute "s3fs/s3_bucket_name",
  :display_name => "S3 bucket name",
  :description => "Name of S3 bucket to mount with S3fs",
  :required => true,
  :recipes => [ "s3fs::mount"]
  
attribute "s3fs/mount_point",
  :display_name => "Mount point for S3fs",
  :description => "Name of directory to mount. If ti doesn't exist, it will be created.",
  :required => true,
  :recipes => [ "s3fs::mount"]