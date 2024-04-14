# README
- Joseph Harrell
- Term Project for CSC-4710, Spring 2024

## Introduction
This application is designed for keeping track of membership information and annual dues payments 
for a sailing club. It tracks names, address, phone number, email address, invoices, and payments.

## System dependencies
- Ubuntu 22-LTS
- rvm 1.29.12
- ruby 3.2.3
- bundler 2.5.6
- rails 7.1.3.2
- node 12.22.9
- npm 8.5.1
- sqlite3 gem 1.7.2
- bootstrap 5.3.2
- puma web applicaiton server
- git 2.34.1
  
## Configuration
### System setup
```
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
reboot
```
### Sql client
```
sudo apt install sqlite3
```

### Node and NPM
Verions of node and npm installed with 22-LTS are too old.
Uninstall and replace with current versions
```
sudo apt remove cmdtest npm nodejs -y
sudo apt autoremove
https://github.com/nodesource/distributions?tab=readme-ov-file#ubuntu-versions 
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
sudo apt-get install -y nodejs
node -v
npm -v
```
### rvm and ruby
Reference https://rvm.io/
```
sudo gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | sudo bash -s stable
sudo usermod -a -G rvm jrh
source /etc/profile.d/rvm.sh
rvm -v # 1.29.12 (latest)
rvm install 3.2.3
ruby -v # 3.2.3
echo ruby-3.2.3 > .ruby-version
```

### gem and bundler
```
sudo chmod -R g+w /usr/local/rvm/gems
echo "gem: --no-document" >> ~/.gemrc
gem update --system 3.5.6
gem -v # 3.5.6 / 2024-02-06
gem install bundler
bundle -v sudo chmod -R g+w /usr/local/rvm/gems
echo "gem: --no-document" >> ~/.gemrc
gem update --system 3.5.6
gem -v # 3.5.6 / 2024-02-06
gem install bundler
bundle -v  # Bundler version 2.5.6
```

### Rails 7
```
gem install rails
rails -v # Rails 7.1.3.2
```

