Terraform Key Concepts
Providers	Plugins responsible for managing specific platforms (e.g., AWS, Azure, GCP, Kubernetes).
Resources	Infrastructure components declared to be managed (e.g., EC2, S3, VPC).
Data Sources	Read-only infrastructure queries fetching existing cloud resources outside Terraform.
Variables	Input values passed into configurations for modularity.
Outputs	Return values that Terraform displays or passes to other configurations.
State File	Tracks real-world resources mapped to configuration (terraform.tfstate).
Modules	Self-contained packages of Terraform configurations that create reusable components.
