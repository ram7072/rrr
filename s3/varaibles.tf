variable "environment_values" {
  default = {
    
   dev= {
	  bucket_name="dsm-datalake-s3-bucket-dev"
	  environment_id="Dev"
	  environment="Development"
   	  application_name = "ADMS Integration"
	  owner = "CloudDataStrategyMgmtDevSupport@pgn.com"
	  project = "ADMS"
	  dcio = "Corporate"
	  confidentiality = "Confidential"
	  cost_center = "18100-1840004-XXXXXXXXXXX"
    }
   test= {
      bucket_name="dsm-datalake-s3-bucket-test"
	  environment_id="Test"
	  environment="Test"
	  application_name = "ADMS Integration"
	  owner = "CloudDataStrategyMgmtTestSupport@pgn.com"
	  project = "ADMS"
	  dcio = "Corporate"
	  confidentiality = "Confidential"
	  cost_center = "18100-1840004-XXXXXXXXXXX"
	 }
   prod= {
      bucket_name="dsm-datalake-s3-bucket-prod"
	  environment_id="Prod"
	  environment="Production"
	  application_name = "ADMS Integration"
	  owner = "CloudDataStrategyMgmtProdSupport@pgn.com"
	  project = "ADMS"
	  dcio = "Corporate"
	  confidentiality = "Confidential"
	  cost_center = "18100-1840004-XXXXXXXXXXX"
    }
	 
  }
}

variable "provider_region" {
  default = "us-west-2"
}