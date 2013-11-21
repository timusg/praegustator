role "web" do
   taste "nginx"
   taste "puma"
   taste "logrotate"
end


recipe "face::web" do
   taste "nginx"
   taste "puma"
   taste "logrotate"
end

search "role:web AND chef_environmnet:production" do
   taste "nginx"
   taste "puma"
   taste "logrotate"
end
