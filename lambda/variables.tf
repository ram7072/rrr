variable "environment_values" {
  default = {

   dev= {
   

		lambda_timeout                        = "400"
		runtime                               = "python3.6"
		account_id                            = "475210740017"
	    payload                               = "lambda_census_function.zip"
		environment                           = "Dev"
		environment_id                        = "Dev"
	    application_name                      = "Census DataLake"
		group                                 = "PGE_DEV_DATALAKE"
	    owner                                 = "CloudDataLake@pgn.com"
	    project                               = "Census"
	    dcio                                  = "CORPORATE"
	    confidentiality                       = "Confidential"
	    cost_center                           = "18100-1840004-3000001661"
		kms_policy                            ="arn:aws:iam::475210740017:policy/dev-kms-access"

    
    }

   test= {

		lambda_timeout                        ="300"
		runtime                               = "python3.6"
		account_id                            ="679494167814"
	  	environment                           = "Test"
	    payload                               = "lambda_census_function.zip"
		environment                           = "Test"
	    application_name                      = "Census DataLake"
		group                                 = "PGE_TEST_DATALAKE"
		environment_id                        = "Test"
		owner                                 = "CloudDataLake@pgn.com"
	    project                               = "Census"
	    dcio                                  = "CORPORATE"
	    confidentiality                       = "Confidential"
	    cost_center                           = "18100-1840004-3000001661"
		kms_policy                           ="arn:aws:iam::679494167814:policy/test-kms-access"
      }

   prod= {

		lambda_timeout                        = "300"
		runtime                               = "python3.6"
		account_id                            = "554931768202"
		runtime                               = "python3.6" 
		payload                               = "lambda_census_function.zip"
		environment                           = "Prod"
		environment_id                        = "Prod"
		group                                 = "PGE_PROD_DATALAKE"
	    application_name                      = "Census DataLake"
		owner                                 = "CloudDataLake@pgn.com"
	    project                               = "Census"
	    dcio                                  = "CORPORATE"
	    confidentiality                       = "Confidential"
	    cost_center                           = "18100-1840004-3000001661"
		kms_policy                            ="arn:aws:iam::554931768202:policy/prod-kms-access"
	
    }

  }
}