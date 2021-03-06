#!/bin/bash

set -eu

vars_store_prefix=/tmp/bosh-deployment-test

clean_tmp() {
  rm -f $vars_store_prefix
  rm -f ${vars_store_prefix}.*
}

trap clean_tmp EXIT

# Only used for tests below. Ignore it.
function bosh() {
  shift 1
  command bosh int --var-errs --var-errs-unused ${@//--state=*/} > /dev/null
}

echo "- AWS"
bosh create-env bosh.yml \
  -o aws/cpi.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v access_key_id=test \
  -v secret_access_key=test \
  -v az=test \
  -v region=test \
  -v default_key_name=test \
  -v default_security_groups=[test] \
  -v private_key=test \
  -v subnet_id=test

echo "- AWS with UAA"
bosh create-env bosh.yml \
  -o aws/cpi.yml \
  -o uaa.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v access_key_id=test \
  -v secret_access_key=test \
  -v az=test \
  -v region=test \
  -v default_key_name=test \
  -v default_security_groups=[test] \
  -v private_key=test \
  -v subnet_id=test

echo "- AWS with UAA + config-server"
bosh create-env bosh.yml \
  -o aws/cpi.yml \
  -o uaa.yml \
  -o config-server.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v access_key_id=test \
  -v secret_access_key=test \
  -v az=test \
  -v region=test \
  -v default_key_name=test \
  -v default_security_groups=[test] \
  -v private_key=test \
  -v subnet_id=test

echo "- AWS with UAA + CredHub + Turbulence"
bosh create-env bosh.yml \
  -o aws/cpi.yml \
  -o uaa.yml \
  -o credhub.yml \
  -o turbulence.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v access_key_id=test \
  -v secret_access_key=test \
  -v az=test \
  -v region=test \
  -v default_key_name=test \
  -v default_security_groups=[test] \
  -v private_key=test \
  -v subnet_id=test \
  -v credhub_dev_key=test \
  -v file_path_to_credhub_release=test

echo "- AWS with UAA for BOSH development"
bosh deploy bosh.yml \
  -o aws/cpi.yml \
  -o uaa.yml \
  -o bosh-dev.yml \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_ip=test \
  -v access_key_id=test \
  -v secret_access_key=test \
  -v region=test \
  -v default_key_name=test \
  -v default_security_groups=[test]

echo "- AWS with external db"
bosh create-env bosh.yml \
  -o aws/cpi.yml \
  -o external-db.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v access_key_id=test \
  -v secret_access_key=test \
  -v az=test \
  -v region=test \
  -v default_key_name=test \
  -v default_security_groups=[test] \
  -v private_key=test \
  -v subnet_id=test \
  -v external_db_host=test \
  -v external_db_port=test \
  -v external_db_user=test \
  -v external_db_password=test \
  -v external_db_adapter=test \
  -v external_db_name=test

echo "- AWS (cloud-config)"
bosh update-cloud-config aws/cloud-config.yml \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v az=test \
  -v subnet_id=test

echo "- GCP"
bosh create-env bosh.yml \
  -o gcp/cpi.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v gcp_credentials_json=test \
  -v project_id=test \
  -v zone=test \
  -v tags=[internal,no-ip] \
  -v network=test \
  -v subnetwork=test

echo "- GCP with UAA"
bosh create-env bosh.yml \
  -o gcp/cpi.yml \
  -o uaa.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v gcp_credentials_json=test \
  -v project_id=test \
  -v zone=test \
  -v tags=[internal,no-ip] \
  -v network=test \
  -v subnetwork=test

echo "- GCP with BOSH Lite"
bosh create-env bosh.yml \
  -o gcp/cpi.yml \
  -o bosh-lite.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v gcp_credentials_json=test \
  -v project_id=test \
  -v zone=test \
  -v tags=[internal,no-ip] \
  -v network=test \
  -v subnetwork=test

echo "- GCP with BOSH Lite on Docker"
bosh create-env bosh.yml \
  -o gcp/cpi.yml \
  -o bosh-lite-docker.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v gcp_credentials_json=test \
  -v project_id=test \
  -v zone=test \
  -v tags=[internal,no-ip] \
  -v network=test \
  -v subnetwork=test

echo "- GCP with external db"
bosh create-env bosh.yml \
  -o gcp/cpi.yml \
  -o external-db.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v gcp_credentials_json=test \
  -v project_id=test \
  -v zone=test \
  -v tags=[internal,no-ip] \
  -v network=test \
  -v subnetwork=test \
  -v external_db_host=test \
  -v external_db_port=test \
  -v external_db_user=test \
  -v external_db_password=test \
  -v external_db_adapter=test \
  -v external_db_name=test

echo "- GCP (cloud-config)"
bosh update-cloud-config gcp/cloud-config.yml \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v zone=test \
  -v network=test \
  -v subnetwork=test \
  -v tags=[tag]

echo "- Openstack"
bosh create-env bosh.yml \
  -o openstack/cpi.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v auth_url=test \
  -v az=test \
  -v default_key_name=test \
  -v default_security_groups=test \
  -v net_id=test \
  -v openstack_password=test \
  -v openstack_username=test \
  -v openstack_domain=test \
  -v openstack_project=test \
  -v private_key=test \
  -v region=test

echo "- Openstack (cloud-config)"
bosh update-cloud-config openstack/cloud-config.yml \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v az=test \
  -v net_id=test

echo "- vSphere"
bosh create-env bosh.yml \
  -o vsphere/cpi.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v internal_ip=test \
  -v network_name=test \
  -v vcenter_dc=test \
  -v vcenter_ds=test \
  -v vcenter_ip=test \
  -v vcenter_user=test \
  -v vcenter_password=test \
  -v vcenter_templates=test \
  -v vcenter_vms=test \
  -v vcenter_disks=test \
  -v vcenter_cluster=test

echo "- vSphere (cloud-config)"
bosh update-cloud-config vsphere/cloud-config.yml \
  -v internal_cidr=test \
  -v internal_gw=test \
  -v network_name=test \
  -v vcenter_cluster=test

echo "- Azure"
bosh create-env bosh.yml \
  -o azure/cpi.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=10.0.0.0/24 \
  -v internal_gw=10.0.0.1 \
  -v internal_ip=10.0.0.4 \
  -v vnet_name=boshvnet-crp \
  -v subnet_name=Bosh \
  -v subscription_id=test \
  -v tenant_id=test \
  -v client_id=test \
  -v client_secret=test \
  -v resource_group_name=test \
  -v storage_account_name=test \
  -v default_security_group=nsg-bosh

echo "- Azure (custom-environment)"
bosh create-env bosh.yml \
  -o azure/custom-environment.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=test \
  -v internal_cidr=10.0.0.0/24 \
  -v internal_gw=10.0.0.1 \
  -v internal_ip=10.0.0.4 \
  -v vnet_name=boshvnet-crp \
  -v subnet_name=Bosh \
  -v environment=AzureChinaCloud \
  -v subscription_id=test \
  -v tenant_id=test \
  -v client_id=test \
  -v client_secret=test \
  -v resource_group_name=test \
  -v storage_account_name=test \
  -v default_security_group=nsg-bosh

echo "- Azure (cloud-config)"
bosh update-cloud-config azure/cloud-config.yml \
  -v az=test \
  -v internal_cidr=10.0.16.0/24 \
  -v internal_gw=10.0.16.1 \
  -v vnet_name=boshvnet-crp \
  -v subnet_name=CloudFoundry \
  -v security_group=nsg-cf

echo "- VirtualBox with BOSH Lite"
bosh create-env bosh.yml \
  -o virtualbox/cpi.yml \
  -o bosh-lite.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=vbox \
  -v internal_ip=192.168.56.6 \
  -v internal_gw=192.168.56.1 \
  -v internal_cidr=192.168.56.0/24

echo "- VirtualBox with BOSH Lite with garden-runc"
bosh create-env bosh.yml \
  -o virtualbox/cpi.yml \
  -o bosh-lite.yml \
  -o bosh-lite-runc.yml \
  -o jumpbox-user.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=vbox \
  -v internal_ip=192.168.56.6 \
  -v internal_gw=192.168.56.1 \
  -v internal_cidr=192.168.56.0/24

echo "- Warden (cloud-config)"
bosh update-cloud-config warden/cloud-config.yml

echo "- Docker"
bosh create-env bosh.yml \
  -o docker/cpi.yml \
  -o jumpbox-user.yml \
  --state=$vars_store_prefix \
  --vars-store $(mktemp ${vars_store_prefix}.XXXXXX) \
  -v director_name=docker \
  -v internal_cidr=10.245.0.0/16 \
  -v internal_gw=10.245.0.1 \
  -v internal_ip=10.245.0.10 \
  -v docker_host=tcp://192.168.50.8:4243 \
  -v docker_tls=ca_cert \
  -v network=net3

echo "- Docker (cloud-config)"
bosh update-cloud-config docker/cloud-config.yml -v network=net3
