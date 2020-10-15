fn-pizza-discount-cloud-events.git

git repo with cloud events fn function to upload discount campaign JSON files and trigger to ATP.
Oci config files required to access to Object Storage and invoke other functions are copied from Developer Cloud Service oci cli setup pipeline.
In the deployment pipeline jobs, you must create an OCI CLI connection. Config file and private key .pem file will be created in the build machine. 
You can use them instead of include them in the GIT repository, improving the security of the project.