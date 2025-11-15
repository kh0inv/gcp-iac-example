mkdir ~/temp && cd ~/temp

wget -O tofu.tar.gz https://github.com/opentofu/opentofu/releases/download/v1.10.7/tofu_1.10.7_linux_amd64.tar.gz

tar -xvzf tofu.tar.gz

sudo mv tofu /usr/bin

wget -O terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v0.93.7/terragrunt_linux_amd64

sudo mv terragrunt /usr/bin

sudo chmod +x /usr/bin/terragrunt

rm -rf ~/temp
