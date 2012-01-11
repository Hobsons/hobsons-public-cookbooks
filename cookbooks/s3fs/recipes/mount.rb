bash "mount s3fs" do
  cwd "/tmp"
  code <<-EOH
  mkdir -p /mnt/#{ node[:s3][:bucket] } 
  s3fs #{ node[:s3][:bucket] }  -o accessKeyId=#{ node[:access_key] } -o secretAccessKey=#{ node[:secret_key] } -o allow_other /mnt/#{ node[:s3][:bucket] } 

  EOH
  
  not_if { File.exists?("/usr/bin/s3fs") }
end