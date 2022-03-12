#! /bin/bash  -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo BEGIN
date '+%Y-%m-%d %H:%M:%S'


#configure aws region
aws configure set region us-west-2

#Install Updates to EC2
sudo yum update -y

#Install gcc
sudo yum -y groupinstall "Development Tools"

#Install Python 3 and configure to use Artifactory
sudo yum -y install python3
echo "Updating /etc/pip.conf to use Artifactory"
echo "index-url = http://xwtcvpartifactrepo.corp.dom:8081/artifactory/api/pypi/pypi_cache/simple" >> /etc/pip.conf
sudo cat /etc/pip.conf

#Install Snappy and Snappy-Devel -- needed for package python-snappy
sudo yum -y install snappy
sudo yum -y install snappy-devel

# Install python header files (needed to compile C code)
sudo yum -y install python3-devel

#Install GIT
sudo yum -y install git

#Configure SSL for GIT
cd /home/ec2-user/
echo "-----BEGIN CERTIFICATE-----
MIIGozCCBYugAwIBAgITKgAAABcwRoZJkvFOogAAAAAAFzANBgkqhkiG9w0BAQsF
ADBMMRMwEQYKCZImiZPyLGQBGRYDZG9tMRQwEgYKCZImiZPyLGQBGRYEY29ycDEf
MB0GA1UEAxMWUEdFLVBST0RVQ1RJT04tUk9PVC1DQTAeFw0xOTAzMjkwMjEyNDda
Fw0zNTAzMjkwMjIyNDdaMFExEzARBgoJkiaJk/IsZAEZFgNkb20xFDASBgoJkiaJ
k/IsZAEZFgRjb3JwMSQwIgYDVQQDExtQR0UtUFJPRFVDVElPTi1JU1NVSU5HLUNB
MDEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDB8s0BhyEWb08KCapa
1vYeN2/ULNuCNhqJKm9KBJH44G9nefjxl5yqMPcJbbakNk1C9MPMxRhhRDEeXE4d
iR9doKpVHnEWC+UQrplMVnlegYgvynU6X9fGdoiOekgNmJcMFVeBTQxyRrudX+OC
nAZ8bHp1ffGNRf7zuP8A5fKFiK8oNTTPCNiyKhArFiyjYOIbsADD5Zprd0F3jEIQ
KuPsvEoPPGMqdec8dhRScw4EiLNSIX51+GuZPA33WHrJo00zSyWd9+sns6l5/9vG
/YgoKBhMIHk1m3d+7C8HWSuHC7Rytxz6Xkd5iMQhylNu3niVUoqsyJaVb6lbQriz
xTifAgMBAAGjggN3MIIDczAQBgkrBgEEAYI3FQEEAwIBATAjBgkrBgEEAYI3FQIE
FgQUg6FtzUs1Z03PBuGiOvbYszxcOaIwHQYDVR0OBBYEFJONtm+GROm67qdG9IrC
anyH5HcUMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAP
BgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFLYT/geGAKsHgLHnV/MijYQthRNY
MIIBHgYDVR0fBIIBFTCCAREwggENoIIBCaCCAQWGgcFsZGFwOi8vL0NOPVBHRS1Q
Uk9EVUNUSU9OLVJPT1QtQ0EsQ049SldUQ1ZQUk9PVENFUlQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRp
b24sREM9Y29ycCxEQz1kb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNl
P29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hj9maWxlOi8vLy9KV1RD
VlBST09UQ0VSVC5jb3JwLmRvbS9QS0kvUEdFLVBST0RVQ1RJT04tUk9PVC1DQS5j
cmwwggGdBggrBgEFBQcBAQSCAY8wggGLMIGyBggrBgEFBQcwAoaBpWxkYXA6Ly8v
Q049UEdFLVBST0RVQ1RJT04tUk9PVC1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5
JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1jb3Jw
LERDPWRvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNh
dGlvbkF1dGhvcml0eTBoBggrBgEFBQcwAoZcaHR0cDovL0pXVENWUFJPT1RDRVJU
LmNvcnAuZG9tL0NlcnRFbnJvbGwvSldUQ1ZQUk9PVENFUlQuY29ycC5kb21fUEdF
LVBST0RVQ1RJT04tUk9PVC1DQS5jcnQwagYIKwYBBQUHMAKGXmZpbGU6Ly8vL0pX
VENWUFJPT1RDRVJULmNvcnAuZG9tL0NlcnRFbnJvbGwvSldUQ1ZQUk9PVENFUlQu
Y29ycC5kb21fUEdFLVBST0RVQ1RJT04tUk9PVC1DQS5jcnQwDQYJKoZIhvcNAQEL
BQADggEBAHqtlayB5Z7q8k7NVUPuczfR9sDiuNXFsLBM8iuvW3YxU7kgI2n3+4fw
f4b/+ZBF/U1onRO4Hq103ziF8DYQJV7CuQ/PlM14peowbJU/fjqSDe/S/iA32J/L
lNdmvuPPM9fAxaNlnPnBu5ZP98doJf50OylIHcAByVOIxuTbgMxgI7io4u+0UBk3
aQKzTiNmBADgMk5U1vvze7W7HqzqbAiNqu70v4Jp+0De3Gdz0PxaZGFxBCs/+1XK
wNJxKi7eKyC05jmicBtfS08qzdIo6/gjvSzyTCjiJjAR53POsvoXAconO5hZsxLR
Osm9I6N3bbKVAXMesyXPdRUeYsHWS0c=
-----END CERTIFICATE-----


-----BEGIN CERTIFICATE-----
MIIDiDCCAnCgAwIBAgIQGkj0sqprlKxGPpRALQYdvzANBgkqhkiG9w0BAQsFADBM
MRMwEQYKCZImiZPyLGQBGRYDZG9tMRQwEgYKCZImiZPyLGQBGRYEY29ycDEfMB0G
A1UEAxMWUEdFLVBST0RVQ1RJT04tUk9PVC1DQTAeFw0xNTA4MzExNjAzMTZaFw0z
NTA4MzExNjEzMTZaMEwxEzARBgoJkiaJk/IsZAEZFgNkb20xFDASBgoJkiaJk/Is
ZAEZFgRjb3JwMR8wHQYDVQQDExZQR0UtUFJPRFVDVElPTi1ST09ULUNBMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAr4yJApkGKtWcCgwhwVml2A3COOrT
1iOkoJzXSvSfsj+n8WModyvUQK7ysHHoiC6rtbdaVen33vDXxpr8cSENuuNcPqTC
38Y/6Wk7JIEL6+0BkiucAHukZEuZ2gA8JxFxxIuikElov3QmoQ9/7Bq/MnBcCRig
X4upcr/Wm5biv65Vsqw8xwz4aOrEzoOwlwpA+rvy2vb5DCqeBIRdo9GE/nz3ivfe
qkU2d5QjgVx1ulx0yC1khd0a87pbhO1CDhRxK/VQfQrkRMetQKP5ipY7dGIRn1vp
9mxe4F9wTDFMo6prONONmTVEt8cWN1Omotavpcg7APRgemUcGM6JjF9CmwIDAQAB
o2YwZDATBgkrBgEEAYI3FAIEBh4EAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/
BAUwAwEB/zAdBgNVHQ4EFgQUthP+B4YAqweAsedX8yKNhC2FE1gwEAYJKwYBBAGC
NxUBBAMCAQAwDQYJKoZIhvcNAQELBQADggEBAJCm/nPHzfJNl0EHNbJSVRGwkiE6
VEK9hXDOOoHTCzpKsRjxsYj5Flt/2IiTE24JL4aY02e0r7la0r31h56totaOTa1C
FCQGE1fHbj44PpLTRmodTrItBUO4pJgOHaJdqa9fK1ToTL1ZKGxsS1nNKgtNTi3d
nFh2W20Og1SNfBhgaqjS9yQyF7m3hI2td5xWVrAO3aARUSQV0qFYJyw+cic2ZWbW
oAc5w4mBHpDB28aLtnCEqL66UXJvdQEFenWryWiRPo4R+juZzYt1RSWHwrNAnmNV
rBVeKIDd9Wz/ygRwfYa2uU+8GnOI9T5DigxmaXZ1W5KeLyzZZ9ivaV/XxxE=
-----END CERTIFICATE-----
" >> pge-root-issuing
export GIT_SSL_CAINFO=/home/ec2-user/pge-root-issuing
sudo git config --system http.sslCAPath ./pge-root-issuing
#------------------------------------------------------------
#Clone Repository
git clone https://mycode.corp.dom:8443/scm/ddsp/adms_load_profile.git
cd adms_load_profile
aws s3 sync s3://dsm-datascience-s3-bucket-prod/SnowflakeExports/ADMS/20200729_131449/ .
#git checkout record-structure
git checkout primary_meter_kvarh
chmod -R 777 ../adms_load_profile
#cat ./preprocessPandas.py
#python3 preprocessPandas.py
python3 adms_pandas.py


# set region for ec2-user
sudo -H -u ec2-user bash -c 'aws configure set region us-west-2' 


#Install Mail Client to email log
sudo yum -y install mailx
sudo echo "set smtp=smtp.corp.dom" >> /etc/mail.rc
sudo echo "set from="noreply@pgn.com"" >> /etc/mail.rc
echo "Deployed via Terraform"
mail -s 'AWS EC2C ADMS - Load Profile Deployment Log' Jensen.Lugo@pgn.com < /var/log/user-data.log
