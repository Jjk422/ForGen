# ForGen
## What is it
ForGen is designed to be an easy to use forensic image generator.
The software will hopefully combat the lack of forensic training images in the computer forensics industry.

## Installation
ForGen should be fully machine independent, however a list of needed software for ForGen to function is included below:
* [Packer](https://www.packer.io/)
* [Vagrant](https://www.vagrantup.com/)
* [Puppet](https://puppet.com/)
* [Ruby](https://www.ruby-lang.org/en/)
* [Virtualbox](https://www.virtualbox.org/)
* [ftkimager](http://accessdata.com/product-download)

### Ubuntu
*Please note: Parts of the code containing [] need to be replaced by the stated value*  
cd [ForGen_installation_path]
#### Install FTKimager
curl -o ftkimager.tar.gz https://ad-zip.s3.amazonaws.com/ftkimager.3.1.1_ubuntu32.tar.gz  
tar -xvzf ftkimager.tar.gz  
rm ftkimager.tar.gz  
#### Install Vagrant
curl -o vagrant.deb https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb  
sudo dpkg -i vagrant.deb  
rm vagrant.deb  
#### Install Packer
curl -o packer.zip https://releases.hashicorp.com/packer/0.12.2/packer_0.12.2_linux_amd64.zip  
unzip packer.zip  
rm packer.zip  
#### Add program binaries to path
export PATH=$PATH:[ForGen_Installation_path]/packer:[ForGen_installation_path]/ftkimager  
#### Install Ruby/VirtualBox/Puppet
sudo apt-get install virtualbox build-essential patch ruby-dev zlib1g-dev liblzma-dev puppet  
#### Install Bundler gem
sudo gem install bundler  
#### Install all other Gems
bundle install  

### Windows
TODO: list web pages with download links (maybe with chocolatey used)

### MacOS
TODO: find out how MacOS installs software

## Features
Due to how ForGen is built, it includes multiple features, including, but not limited to:
* Virtual machine creation
* Forensic image creation (intended use)
* Unique tests based off of the generated virtual machines
* Unique tests based off of the generated forensic images
* Corresponding mark sheets that can be marked using ForGen (the marks for questions can be assigned manually or  dynamically)
* Ability to randomise and ensure continuously unique output of all of the above

## Usage
ForGen is built to be as simple for the user as possible while being complex enough to dynamically create unique and testable forensic images.

A few simple commands for ForGen can be found below:
```
# Display ForGen help page
ruby forgen.rb --help
  
# Display ForGen version number
ruby forgen.rb --version
  
# Run forgen.rb, creating a forensic image, its corresponding virtual machine, a corresponding testing sheet and a corresponding mark scheme, based off of the default randomising scenario
ruby forgen.rb run
  
# Run forgen.rb creating all components (see run forgen.rb run command for more details), however a custom scenario file is selected.
Scenario_file_path represents the path of the custom scenario.
ruby forgen.rb run --case-path [case_file_path]
  
# Tell ForGen to only create the ForGen configuration needed to create the VMs and forensic images without creating the VMs and forensic images themselves.
ruby forgen.rb make-config
  
# Tell ForGen to only create the ForGen vagrant basebox and the config that it is based off of.
ruby forgen.rb make-vagrant-basebox --project-dir [project_dir_path]
  
# Tell ForGen to only create the ForGen virtual machine, vagrant basebox and the config that it is based off of.
ruby forgen.rb make-virtual-machine --project-dir [project_dir_path]
  
# Tell ForGen to create the following:
* The ForGen configuration files
* The vagrant basebox
* The virtual machine based off of the ForGen configuration
* The forensic image based on the virtual machine drives
run forgen.rb make-forensic-image --project-dir [project_dir_path]
  
# Tell ForGen to create a test sheet containing questions based on the ForGen configuration
run forgen.rb make-test-sheet --project-dir [project_dir_path]
  
# Tell ForGen to create a mark sheet based on the given test sheet and ForGen configuration 
run forgen.rb make-mark-sheet --project-dir [project_dir_path]
```

## Contributions
ForGen is currently in a closed development phase, however after the software is capable of demonstrating the initial goals and wants of the software, it will be brought to open source, via the use of a public GitHub repository.

Adding code to ForGen is just like contributing to any other GitHub repository, just follow the following steps:
* Pull down the master ForGen repository at https://www.github.com/Jjk422/ForGen
* Add the desired changes or features to the code base
* Sign into your GitHub account
* Pull request the changes (with justification) to the repository using git
* Wait for the pull request to be reviewed
* Respond or modify the pull request code based on the reviews and comments
* When the pull request is reviewed and is deemed to be in good working order, an administrator will add the pull request code to the ForGen master branch
