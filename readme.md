simple dsl to validate and test chef  managed infra, it basically work upon ssh and use server spec in core


---
environment :staging

role("web") do
 it_should_behave_like: "application/nginx"
 it_should_behave_like: "application/puma"
 it_should_behave_like: "application/s3cmd"
end


---
role("web").it_should_behave_like "application/nginx"
role("web").it_should_behave_like "application/s3cmd"
role("web").it_should_behave_like "application/puma"


---
search("role:web AND chef_environmnet_prod").it_should_behave_like "application/puma"
