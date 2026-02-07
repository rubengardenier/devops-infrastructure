# DevOps Infrastructure

Setup and configuration for the self-hosted Ubuntu Azure DevOps agent used by Brewstack.

## Overview

This repository contains scripts and documentation for provisioning and maintaining the self-hosted Azure DevOps agent running on Ubuntu. This agent is used to execute CI/CD pipelines for Terraform deployments.

## Agent Details

| Property | Value |
|----------|-------|
| Pool name | `Ubuntu` |
| Agent name | `ubuntu` |
| OS | Ubuntu Linux |
| Purpose | Terraform CI/CD pipeline execution |

## Installed Software

The agent requires the following software:

- **Terraform** - Infrastructure as Code tool
- **Azure CLI** (`az`) - Azure resource management
- **Git** - Source control
- **unzip** - Required for various pipeline tasks

## Setup

1. Provision an Ubuntu VM (Azure VM, on-premise, or other)
2. Install required software listed above
3. Register the agent with Azure DevOps:
   ```bash
   ./config.sh --unattended \
     --url https://dev.azure.com/brewstack \
     --auth pat \
     --token <PAT> \
     --pool Ubuntu \
     --agent ubuntu
   ```
4. Start the agent:
   ```bash
   ./run.sh
   ```

## Related

- **AKS Terraform** (Azure DevOps): Infrastructure-as-code repository that uses this agent for deployments
