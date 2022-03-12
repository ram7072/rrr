variable "environment_values" {
  default = {
   default= {

   }
    
   test= {
   }
  
   preprod= {
   } 
   prod= {
   }
 }
}
  
variable "provider_region" {
  default = "us-west-2"
}
