@REM Staging
terraform -chdir=./staging init -backend-config ../backend-staging.tf

terraform -chdir=./staging plan

terraform -chdir=./staging apply --auto-approve

@REM Production
terraform -chdir=./production init -backend-config ../backend-production.tf

terraform -chdir=./production plan

terraform -chdir=./production apply --auto-approve