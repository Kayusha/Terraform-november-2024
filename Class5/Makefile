virginia:
	terraform workspace select -or-create virginia
	terraform init
	terraform apply -var-file virginia.tfvars --auto-approve

ohio:
	terraform workspace select -or-create ohio
	terraform init
	terraform apply -var-file ohio.tfvars --auto-approve

california:
	terraform workspace select -or-create california
	terraform init
	terraform apply -var-file california.tfvars --auto-approve

oregon:
	terraform workspace select -or-create oregon
	terraform init
	terraform apply -var-file oregon.tfvars --auto-approve


virginia-d:
	terraform workspace select virginia
	terraform init
	terraform destroy -var-file virginia.tfvars --auto-approve

ohio-d:
	terraform workspace select ohio
	terraform init
	terraform destroy -var-file ohio.tfvars --auto-approve

california-d:
	terraform workspace select california
	terraform init
	terraform destroy -var-file california.tfvars --auto-approve

oregon-d:
	terraform workspace select oregon
	terraform init
	terraform destroy -var-file oregon.tfvars --auto-approve

apply-all: virginia ohio oregon california 
destroy-all: virginia-d ohio-d oregon-d california-d 
