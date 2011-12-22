maintainer       "Initial owner: Jon Wood. Further enhancements: Patrick McFadin"
maintainer_email "jon@blankpad.net"
license          "Apache 2.0"
description      "Installs/Configures statsd"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends "build-essential"
depends "git"
depends "nodejs"
supports "ubuntu"

recipe  "statsd::default", "Installs statsd for use with graphite"

attribute "statsd/port",
  :display_name => "Statsd port",
  :description => "Listening port for statsd. Destination for sending events.",
  :default => "8125",
  :recipes => [ "statsd::default"]
  
attribute "statsd/graphite_port",
  :display_name => "Graphite port",
  :description => "Listening port for graphite. Statsd will forward events to this port",
  :default => "2003",
  :recipes => [ "statsd::default"]
  
attribute "statsd/graphite_host",
  :display_name => "Graphite host",
  :description => "Host address for graphite. Statsd will forward events to this host.",
  :default => "localhost",
  :required => true,
  :recipes => [ "statsd::default"]