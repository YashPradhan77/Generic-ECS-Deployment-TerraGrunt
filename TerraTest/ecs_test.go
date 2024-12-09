package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEcsInfra(t *testing.T) {
	// Specify the Terraform options
	terraformOptions := &terraform.Options{
		// Path to the Terraform code that will be tested
		TerraformDir: "../",

	// terraformOptions := &terraform.Options{
	// 	TerraformDir: "../env/dev",  // Path to the Terragrunt directory
	// 	EnvVars: map[string]string{
	// 		"TERRAGRUNT_CONFIG": "../env/dev/terragrunt.hcl",
	// 	},
	// }
		
		defer terraform.Destroy(t, terraformOptions)
		terraform.InitAndApply(t, terraformOptions)
		
		// Variables to pass to Terraform
		// Vars: map[string]interface{}{
		// 	"region": "eu-central-1",
		// },

		// Disable colored output for easier parsing
		NoColor: true,
	}

	// Ensure Terraform destroy is run to clean up resources
	defer terraform.Destroy(t, terraformOptions)

	// Run Terraform init and apply
	terraform.InitAndApply(t, terraformOptions)

	// ecsClusterName := terraform.Output(t, terraformOptions, "ecs_cluster_name")
	// assert.NotEmpty(t, ecsClusterName)

	// Validate ALB Security Group ID
	// securityGroupID := terraform.Output(t, terraformOptions, "alb_security_group_id")
	// assert.Contains(t, securityGroupID, "sg-", "Security group ID must be valid")

	// Validate outputs 
	vpcName := terraform.Output(t, terraformOptions, "vpc_id")
	assert.NotEmpty(t, vpcName)

	dnsName := terraform.Output(t, terraformOptions, "lb_dns_name")
	assert.NotEmpty(t, dnsName)
}
