# Go Microservice Sample Project

This repository contains a simple microservice application built in Go. It serves as a test application for learning and can be integrated into a Kubernetes setup in the future.

## Project Structure

- **main.go**: The main entry point for the Go HTTP server (listens on port 8080 and returns "Hello, World!").
- **go.mod**: Go module configuration.
- **Dockerfile**: Multi-stage Dockerfile to build a minimal container image for the microservice.
- **.gitignore**: File that excludes unnecessary files and sensitive data (e.g., binaries, environment files, and editor-specific files).
- **.github/workflows/use-ci.yaml**: A GitHub Actions workflow that references a reusable CI pipeline from the basic-gha repository. This workflow automates the process of checking out code, building the application, running tests, building the Docker image, scanning for vulnerabilities, and pushing the image to an existing Amazon ECR repository.

## Getting Started

### Prerequisites

- Go (version 1.18 or higher) installed locally.
- Docker for building container images.
- Git for version control.
- An AWS account with the necessary permissions, along with credentials stored as GitHub Secrets in your repository (e.g., AWS_ACCOUNT_ID, AWS_REGION, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, ECR_REPOSITORY, PAT_FOR_WORKFLOW).

### Running Locally

1. Build and run the Go application:
   ```bash
   go build -o microservice .
   ./microservice
   ```

2. Open your browser and navigate to `http://localhost:8080` to see the "Hello, World!" message.

### Building the Docker Image

Use the provided Dockerfile to build the Docker image:

```bash
docker build -t <your-ecr-repo>:<tag> .
```

### CI/CD Pipeline

- The GitHub Actions workflow in `.github/workflows/use-ci.yaml` is triggered on pushes to the `main` branch.
- This workflow references a reusable CI pipeline from the [basic-gha](https://github.com/olu-folarin/basic-gha) repository, which is configured to set up multi-architecture support via QEMU and Docker Buildx.
- The workflow builds, tests, scans, and pushes your Docker image to your pre-configured ECR repository.

## Terraform Integration

The CI/CD pipeline is designed to work in tandem with the Terraform automation defined in the [tf-automation](https://github.com/olu-folarin/tf-automation/tree/main/modules) repository. This integration includes:

- **IAM Module**: Provisions an IAM user with the appropriate permissions and generates access keys.
- **Secrets Module**: Stores AWS credentials and the ECR repository URL securely in AWS Secrets Manager.
- **ECR Module**: Manages the ECR repository where Docker images are pushed.

This separation of concerns ensures that infrastructure provisioning and secret management are handled securely via Terraform, while the CI/CD workflows focus on code building, testing, and deployment.

## License

This project is intended for learning and testing purposes.
