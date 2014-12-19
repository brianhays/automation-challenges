## Description

This configuration managment project uses Ansible to accomplish the items listed in the [README file](README.md)

## Requirements
In order to run this ansible playbook you will need to have Ansible installed on your workstation. The corresponding client servers only need to be accessible via ssh (no other client software required).

To install Ansible:

on OSX you can either install via Homebrew (`brew install ansible`) or via pip:
```
sudo easy_install pip
sudo pip install paramiko PyYAML Jinja2 httplib2
sudo pip install ansible
```

on Linux:
 * For RHEL/CentOS install the EPEL repo, then install Ansible via `yum -y install ansible
 * For Debian/Ubuntu run `sudo apt-get -y install python-pip python-dev` then install Ansible via `sudo pip install ansible`

 ## Usage Instructions
 Clone this project to your local workstation or server. If your machine meets the above requirements, from within the "configuration management" directory open the 'my_hosts' and enter your desired host targets.

 The playbook assumes you have passwordless access (via ssh-agent/keys) to the target hosts. If not, simply run the playbook with the '-k' flag to be prompted for your password.

 To run the playbook:
 ```
ansible-playbook -i my_hosts main.yml
 ```

 To run the playbook with password prompt:
 ```
ansible-playbook -k -i my_hosts main.yml
 ```

 Running the playbook will produce a stats report that will include the hosts the playbook ran against, success or failure of each, along with the changes made.

 In testing I used the linux 'date' command as a substitue for 'facter' on my test systems. Below is the sample stats report followed by the updated /etc/widgetfile on the tested host:

Output (stats):
 ```
ansible-playbook -i my_hosts main.yml 

PLAY [widgets] **************************************************************** 

GATHERING FACTS *************************************************************** 
ok: [10.131.118.82]

TASK: [Grab output from 'facter -p widget' on each host] ********************** 
changed: [10.131.118.82]

TASK: [Copy widget file to hosts] ********************************************* 
changed: [10.131.118.82] => (item=Fri Dec 19 16:24:28 EST 2014)

PLAY RECAP ******************************************************************** 
10.131.118.82             : ok=3    changed=2    unreachable=0    failed=0    
```

updated widgetfile:
```
option 1234
speed 88mph
capacitor_type flux
widget_type Fri Dec 19 16:14:11 EST 2014
model delorean
avoid shopping_mall_parking_lots
```