role "web" do
   check "nginx"
   check "puma"
   check "logrotate"
end

recipe "face::db" do
   check "postgres"
end

search 'role:web AND run_list\:recipe\[foo\:\:bar\]' do
   check "nginx"
   check "puma"
   check "logrotate"
end
