# dot-06

## Terraform
- Run first
```
$ terraform init
```
- Check with
```
$ terraform plan
```
- Then apply to cloud infra
```
$ terraform apply
```

## Ansible

- First update the inv file, then run 

```
ansible-playbook -i inv jenkinsinstall.yaml
```

## Jenkins

The pipeline can be found under folder "jenkins" on the repository

- Inside jenkins create a job with remote vm as target and use this repository pipeline