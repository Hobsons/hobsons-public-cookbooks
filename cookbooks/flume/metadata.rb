maintainer       "Chris Howe - Infochimps, Inc"
maintainer_email "coders@infochimps.com"
license          "Apache 2.0"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "3.0.0"

description      "Installs/Configures flume"

#depends          "java"
depends          "apt"
#depends          "mountable_volumes"
#depends          "provides_service"

recipe           "flume::default",                     "Base configuration for flume"
recipe           "flume::hbase_sink_plugin",           "Hbase Sink Plugin"
recipe           "flume::jruby_plugin",                "Jruby Plugin"
recipe           "flume::master",                      "Configures Flume Master, installs and starts service"
recipe           "flume::node",                        "Configures Flume Node, installs and starts service"
recipe           "flume::test_flow",                   "Test Flow"

%w[ debian ubuntu ].each do |os|
  supports os
end

attribute "flume/aws_access_key",
  :display_name          => "AWS access key used for writing to s3 buckets",
  :description           => "AWS access key used for writing to s3 buckets",
  :default               => ""

attribute "flume/aws_secret_key",
  :display_name          => "AWS secret key used for writing to s3 buckets",
  :description           => "AWS secret key used for writing to s3 buckets",
  :default               => ""

attribute "flume/cluster_name",
  :display_name          => "",
  :description           => "The name of the cluster to participate with (masters and zookeepers...)",
  :default               => "cluster_name"

attribute "flume/plugins",
  :display_name          => "Hash for plugin configuration",
  :description           => "If you have a particular plugin to configure, you can also configure the classpath and the classes to include in the configuration file with attributes in the following forms:\nnode[:flume][:plugin][{plugin_name}][:classes]\nnode[:flume][:plugin][{plugin_name}][:classpath]\nnode[:flume][:plugin][{plugin_name}][:java_opts]",
  :default               => ""

attribute "flume/classes",
  :display_name          => "",
  :description           => "",
  :default               => ""

attribute "flume/classpath",
  :display_name          => "list of directories and jars to add to the FLUME_CLASSPATH",
  :description           => "list of directories and jars to add to the FLUME_CLASSPATH",
  :default               => ""

attribute "flume/java_opts",
  :display_name          => "list of command line parameters to add to the jvm",
  :description           => "list of command line parameters to add to the jvm",
  :default               => ""

attribute "flume/collector",
  :display_name          => "Format of node's logs",
  :description           => "output_format -- Controls what format the node writes logs (using collectorSink):\n * avro - Avro Native file format. Default currently is uncompressed.\n * avrodata - Binary encoded data written in the avro binary format.\n * avrojson - JSON encoded data generated by avro.\n * default - a debugging format.\n * json - JSON encoded data.\n * log4j - a log4j pattern similar to that used by CDH output pattern.\n * raw - Event body only. This is most similar to copying a file but does not preserve any uniqifying metadata like host/timestamp/nanos.\n * syslog - a syslog like text output format.\n\ncodec -- Controls what kind of compression the collector will use when writing a file.\nwhether or not collected logs are gzipped before writing\nthem to their final resting place (using collectorSink)\n * GZipCodec\n * BZip2Codec\n",
  :default               => ""

attribute "flume/data_dir",
  :display_name          => "Directory for local in-transit files",
  :description           => "Directory for local in-transit files",
  :default               => "/data/db/flume"

attribute "flume/master/external_zookeeper",
  :display_name          => "Use External Zookeeper?",
  :description           => "false to use flume's zookeeper. True to attach to an external zookeeper.",
  :default               => ""

attribute "flume/master/zookeeper_port",
  :display_name          => "port to talk to zookeeper on (for external zookeeper)",
  :description           => "port to talk to zookeeper on (for external zookeeper)",
  :default               => "2181"
