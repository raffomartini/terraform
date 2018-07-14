# terraform
```
gcloud services enable serviceusage.googleapis.com 
gcloud auth application-default login
export TF_VAR_project_name=<NEW_PROJECT_NAME>
export PROJECT=$(gcloud config get-value project)
export OAUTH_TOKEN=$(gcloud auth application-default print-access-token)
export CLOUDBILLING_API="https://cloudbilling.googleapis.com/v1"
export NAME="projects/${PROJECT}"
export TF_VAR_billing_account=$(curl --header "Authorization: Bearer ${OAUTH_TOKEN}" "$CLOUDBILLING_API/$NAME/billingInfo" | jq -r '.billingAccountName' | cut -f2 -d'/')
export TF_VAR_region="europe-west1"
```
