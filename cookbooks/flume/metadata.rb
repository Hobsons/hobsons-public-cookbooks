maintainer       "Hobsons"
maintainer_email "pmcfadin@hobsons.com"
license          "Apache 2.0"
description      "Installs/Configures flume"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "1.0"

depends          "apt"

recipe           "flume::default",                     "Base configuration for flume"