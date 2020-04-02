package test

import (
	"crypto/tls"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestApp(t *testing.T) {

	opts := &terraform.Options{Vars: map[string]interface{}{
		"app_name": "findmytea-terraform-tdd",
	},
		TerraformDir: "../modules"}

	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	url := terraform.OutputRequired(t, opts, "app_url")

	expectedStatus := 200
	maxRetries := 10
	timeBetweenRetries := 10 * time.Second

	validate := func(status int, body string) bool {
		return expectedStatus == status
	}

	http_helper.HttpGetWithRetryWithCustomValidation(t, url, &tls.Config{}, maxRetries, timeBetweenRetries, validate)
}
