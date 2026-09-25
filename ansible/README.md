# Ansible deployment

Ansible discovers the private application instances through AWS Systems Manager.

Install the collections:

```powershell
ansible-galaxy collection install -r requirements.yml
```

After Terraform has been applied, set the S3 transfer bucket:

```powershell
$env:ANSIBLE_SSM_BUCKET = (terraform -chdir=../terraform output -raw ansible_ssm_bucket_name)
```

Test inventory discovery:

```powershell
ansible-inventory --graph
```

Deploy the application:

```powershell
ansible-playbook playbooks/deploy.yml
```
