# DevOps Chalenge for Energi

## 1) Docker Whale:

Write a Dockerfile to run Energi v3.1.2 in a container. It should somehow verify the checksum of the downloaded release
(there’s no need to build the project), run as a normal user, it should run the client, and print its output to the console.
https://wiki.energi.world/en/downloads/core-node
The build should be security conscious, and ideally pass a container image security test such as ECR, or Trivy. [20 pts]

$ wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/energi3-v3.1.3-linux-amd64.tgz
$ tar zxvf ./energi3-v3.1.3-linux-amd64.tgz
$ ls -alF 
Output:
energi3-v3.1.3-linux-amd64/bin/energi3
energi3-v3.1.3-linux-amd64/COPYING


wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/v3.1.3/SHA256SUMS
$ sha256sum -c --ignore-missing SHA256SUMS

Output:
energi3-v3.1.3-linux-amd64.tgz: OK

#### Preparing docker image steps:

$ sudo apt install -y debootstrap docker-compose docker.io
$ sudo debootstrap focal linux > /dev/null
$ sudo tar -C linux -c . | sudo docker import - linux

sha256:ea13c4966dec260aa32235ffc933f1bd97102424cdb773d57bedb2960ca03a13

$ sudo docker image ls -a
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
focal        latest    976f7b7a9ed8   37 seconds ago   322MB

#### Checking vanila Linux docker images:

$ sudo docker run focal cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04 LTS"


git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/eldaraydayev/energi3.git
git push -u origin main


git clone https://github.com/eldaraydayev/energi3.git
sudo docker build --tag energi3 .
sudo . ./.env docker-compose exec /usr/local/bin/energi --datadir /home/nrgstaker/.energi_core attach
sudo docker-compose up --detach

### Run this command from Linux Shell to install all required packages and Docker images:

curl -s https://raw.githubusercontent.com/eldaraydayev/energi3/main/build_docker.sh|sh

## 2. K8S Awesomness: Write a Kubernetes StatefulSet to run the above, using persistent volume claims and resource limits. [10 pts]

Instruction can be find here:
https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/

## 3. All the continuouses: Write a simple build and deployment pipeline for the above using groovy / Jenkinsfile, Travis CI or Gitlab CI. [15 pts]

Instruction can bi find here:
https://www.jenkins.io/doc/book/pipeline/

## 4. Script kiddies: Source or come up with a text manipulation problem and solve it with at least two of awk, sed, tr. and / or grep. Check the question below first though, maybe. [10 pts]

Instruction can be find here: 
https://blog.knoldus.com/play-with-text-in-linux-grep-cut-awk-sed/

## 5. Script grown-ups: Solve the problem in question 4 using any programming language of your choice. [15 pts]

Information can be find here:
https://www.freecodecamp.org/news/python-string-manipulation-handbook/

## 6. Terraform lovers: write a Terraform module that creates the following resources in IAM: - A role, with no permissions, which can be assumed by users within the same account - A policy, allowing users / entities to assume the above role - A group, with the above policy attached - A user, belonging to the above group - All four entities should have the same name, or be similarly named in some meaningful way given the context e.g. prod-ci-role, prod-ci-policy, prod-ci-group, prod-ci-user; or just prod-ci. Make the suffixes toggleable, if you wish. [20 pts]

Information can be find here:
https://gruntwork.io/repos/v0.21.4/module-security/modules/iam-policies
https://kulasangar.medium.com/creating-and-attaching-an-aws-iam-role-with-a-policy-to-an-ec2-instance-using-terraform-scripts-aa85f3e6dfff
