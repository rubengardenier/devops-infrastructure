# DevOps Infrastructure

Scripts and configuration for setting up and managing the DevOps infrastructure used by the Brewstack AKS Terraform project.

## Overview

This repository contains automation scripts for provisioning and maintaining the CI/CD infrastructure, including:

- Self-hosted Azure DevOps agent setup (Ubuntu)
- Azure backend storage configuration for Terraform state
- Service connection and permission configuration

## Related Repositories

- **AKS Terraform** (Azure DevOps): Main infrastructure-as-code repository for deploying AKS clusters across DTAP environments

## Prerequisites

- Azure CLI (`az`)
- Azure subscription with appropriate permissions
- Azure DevOps organization access

## Environment Structure

The infrastructure supports a DTAP pipeline model:

| Environment | Pipeline | State File |
|-------------|----------|------------|
| Development | `deploy-dev.yml` | `dev.terraform.tfstate` |
| Test | `deploy-test.yml` | `test.terraform.tfstate` |
| Acceptance | `deploy-acc.yml` | `acc.terraform.tfstate` |
| Production | `deploy-prod.yml` | `prod.terraform.tfstate` |

Each environment uses its own variable group (`tfstate-<env>`) for backend configuration.
