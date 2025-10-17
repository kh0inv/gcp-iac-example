mkdir ~/temp && cd ~/temp

wget -O tofu_1.10.6_linux_amd64.tar.gz https://github.com/opentofu/opentofu/releases/download/v1.10.6/tofu_1.10.6_linux_amd64.tar.gz

tar -xvzf tofu_1.10.6_linux_amd64.tar.gz

sudo mv tofu /usr/bin

wget -O terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v0.91.1/terragrunt_linux_amd64

sudo mv terragrunt /usr/bin

sudo chmod +x /usr/bin/terragrunt
