maintainer       "Hobsons"
maintainer_email "pmcfadin@hobsons.com"
license          "Apache 2.0"
description      "Installs/Configures s3fs"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

recipe           "s3fs", "Installs s3fs from source"

depends          "build-essential"