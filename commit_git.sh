#/bin/bash
git add Jenkinsfile
echo "Please input the commit message"
read commitmessage
git commit -m "$commitmessage"
git push jenkins-devops
