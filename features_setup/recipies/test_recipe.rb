ip("*")do
  check "basic_commands"
  check "nginx"
end


role("web-server")do
  check "basic_commands"
  check "nginx"
end
