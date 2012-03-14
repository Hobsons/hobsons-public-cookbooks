current_dir = File.dirname(__FILE__)
cookbook_path ["#{current_dir}/../cookbooks"]

cookbook_copyright "Hobsons"
cookbook_email     "pmcfadin@hobsons.com"
cookbook_license   "apachev2"

# EC2:
knife[:aws_access_key_id]     = "AKIAIH5V4RWJOLOXNTBA"
knife[:aws_secret_access_key] = "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"

