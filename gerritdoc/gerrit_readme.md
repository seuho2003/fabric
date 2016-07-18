###Welcome to Gerrit Introduction:

Create an Linux Foundation ID in below link
[Linux Foundation](https://identity.linuxfoundation.org/)
Once account is created - Login to [Gerrit](https://gerrit.hyperledger.org/r/#/admin/projects/lf-sandbox ) with your credentials

#####Setting up SSH keys:
Follow below steps to generate SSH keys:

 - From the Terminal or Git Bash, run ssh-keygen
 - Confirm the default path .ssh/id_rsa
 - Enter a passphrase (recommended) or leave it blank. Remember this passphrase, as you will need it to unlock the key whenever you use it.
 - Open ~/.ssh/id_rsa.pub and copy & paste the contents into the SSH Public Keys box. Note that id_rsa.pub is your public key and can be shared,
while id_rsa is your private key and should be kept secret.

Once SSH keys are added successfully in gerrit server, it's time to clone the gerrit repo into your local machine.

#####Clone repo:

 - Click on Projects - General - "Clone with commit-msg hook" and choose "SSH" option. Copy the message hook command and paste in your local machine.
 
 ex: git clone ssh://rameshthoomu@gerrit.hyperledger.org:29418/lf-sandbox && scp -p -P 29418 rameshthoomu@gerrit.hyperledger.org:hooks/commit-msg lf-sandbox/.git/hooks/
 
#####Install git-review:
 
 Execute below command to install git-review `sudo apt-get install git-review`. After install git-review, execute git review -s and provide user name.
 
 configure git config settings with below commands: 
 
 git config --global --add gitreview.username "rameshthoomu"
 
#####Gerrit commands:
 
 - git commit -s //Adds signoff signature
 - git commit -s -m "test commit" //Adds signoff signature and adds commit
 - git commit -s --amend //Commit amends with previous signoff id
 - Once you submit all changes in your work area - 
    - Execute `git review -s` //Submits changes to gerrit server as patch set.
    
Reference:
![Gerrit_Reference](Gerrit_merge.png)
    
    

  
 
 
 




