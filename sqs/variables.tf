variable "environment_values" {
  default = {
    
   dev= {
      account_id="475210740017"
	  sqs_json_file="sqs_dev_json.json"
    }
   test= {
      account_id="679494167814"
	  sqs_json_file="sqs_test_json.json"
	 }
   prod= {
      account_id="554931768202"
	  sqs_json_file="sqs_prod_json.json"
    }
	 
  }
}