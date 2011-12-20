maintainer       "Heavy Water Software Inc."
maintainer_email "darrin@heavywater.ca"
license          "Apache 2.0"
description      "Installs/Configures graphite"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.1.0"

depends  "apache2"
supports "ubuntu"

recipe  "graphite::default", "Installs all Graphite components"
recipe "graphite::whisper", "Installs Whisper Graphite component"
recipe "graphite::carbon", "Installs Carbon Graphite component"
recipe "graphite::web", "Installs Web Graphite component"

attribute "graphite/password",
  :display_name => "Graphite Web Password",
  :description => "Password for Graphite Web interface",
  :required => true,
  :recipes => [ "graphite::default", "graphite::web" ]