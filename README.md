# example of setting up ec2 and aurora

_Last Updated: 2022-07-19 14:25:23_

- customized vpc
- public subnet for ec2 as jumphost
- private subnet for aurora subnet

## How to run examples (Linux OS)

**PREREQUISITE**

- terraform binary installed
- a sandbox/lab AWS account
- `~/.aws/credentials` has privileged admin user's access key and secret access key setup for [default]
- a RSA key setup in AWS Console with name **jumphost**, download private key and stored in local

---

**!!! IMPORTANT !!!**

global replace `rsdot` to anything else inside every file, due to S3 has global unique namespace

---

1. Under `terraform-ec2-rds/global/team1/remote-state/`

    1. comment out entire block
    
    ```hcl
    #--------------------------------------------------------------------------------
    # process step 2 start
    #--------------------------------------------------------------------------------
    terraform {
      backend "s3" {
        bucket         = "rsdot-team1-terraform-state"
        key            = "globals/team1/remote-state/terraform.tfstate"
        region         = "us-east-1"
    
        dynamodb_table = "rsdot-team1-terraform-state-lock"
        encrypt        = true
      }
    }
    #--------------------------------------------------------------------------------
    # process step 2 complete, run terraform init and apply in order to upload local tfstage file to S3 bucket
    #--------------------------------------------------------------------------------
    ```

    2. run 

    ```bash
    terraform init
    terraform apply
    ```

    3. UNcomment out entire block

    ```hcl
    #--------------------------------------------------------------------------------
    # process step 2 start
    #--------------------------------------------------------------------------------
    terraform {
      backend "s3" {
        bucket         = "rsdot-team1-terraform-state"
        key            = "globals/team1/remote-state/terraform.tfstate"
        region         = "us-east-1"
    
        dynamodb_table = "rsdot-team1-terraform-state-lock"
        encrypt        = true
      }
    }
    #--------------------------------------------------------------------------------
    # process step 2 complete, run terraform init and apply in order to upload local tfstage file to S3 bucket
    #--------------------------------------------------------------------------------
    ```

    4. run 

    ```bash
    terraform init
    terraform apply
    ```

2. Under `terraform-ec2-rds/global/team1/iam/aurora-access-s3`

    1. run 

    ```bash
    terraform init
    terraform apply
    ```

3. Under `terraform-ec2-rds/global/team1/s3/xtrabackup`

    1. run 

    ```bash
    terraform init
    terraform apply
    ```

4. Under `terraform-ec2-rds/live/dev/us-east-1/network`

    1. run 

    ```bash
    terraform init
    terraform apply
    ```

5. Under `terraform-ec2-rds/live/dev/us-east-1/team1/database/aurora-mysql/parameter-group`

    1. run 

    ```bash
    terraform init
    terraform apply
    ```

6. Under `terraform-ec2-rds/live/dev/us-east-1/team1/database/aurora-mysql`

    1. run 

    ```bash
    export TF_VAR_master_username=xxxx
    export TF_VAR_master_password=xxxx
    terraform init
    terraform apply
    ```

    2. verify from AWS Console for Aurora cluster and instances

7. Under `terraform-ec2-rds/live/dev/us-east-1/jumphost`

    1. run 

    ```bash
    terraform init
    terraform apply
    ```

    2. ssh into jumphost

    ```bash
    ssh -i ~/.ssh/jumphost.pem ubuntu@EC2-PUBLICIP
    ```

    3. once inside jumphost, install mysql-client, then try to connect to aurora cluster's endpoint in command line:

    ```bash
    MYSQL_PWD=xxxx mysql -h AURORA-ENDPOINT -u xxxx -e "SELECT AURORA_VERSION()"
    ```


---

**TEAR DOWN IN REVERSE ORDER**

    1. run 

    ```bash
    terraform destory
    ```

    2. s3 bucket folders need manual removal

    3. DynamoDB needs manual removal

---
