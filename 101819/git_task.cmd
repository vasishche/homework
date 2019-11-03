# git homework
# 1. task
# 1.1 create local repo
mkdir lection_git_hw
cd lection_git_hw
git init

# 1.2 Create file 'homework' and commit it in master branch
touch homework
git add .
git commit -m "1.2 Create file 'homework'"

# 1.3 Create branch and change file 'homework'
git checkout -b hw_git
echo "anything" >> homework
git commit -am "1.3 Changes in 'homework'"

# 1.4 Return to master and change file 'homework'
git checkout master
echo "anything else" >> homework
git commit -am "1.4 Changes in 'homework'"

# 1.5 Merge master and hw_git, keep 'homework' changes from 'hw_git' branch
git merge hw_git
git checkout hw_git homework
git commit -am "1.5 Merge branch 'hw_git'"

# 1.6 Switch hw_git and create new file 'temp_file'
git checkout hw_git
touch temp_file
git add .
git commit -m "1.6 Create file 'temp_file'"

# 1.7 Revert to the first commit in 'hw_git' branch (after parent -> commit No 1.3)
git reset --hard $(git rev-list --min-parents=1 hw_git | tail -1)
# In this case first commit it's parent of curent commit (HEAD~)
# git reset --hard HEAD~

# 2. task
# 2.1 Github: create empty repository 'lection_git_hw'

# 2.2 Set remote
git remote add origin https://github.com/vasishche/lection_git_hw.git

# 2.3 Push all branches to the remote repo
git push -u --all origin

# 2.4 Change everything in file 'homework' in branch 'hw_git' to one line 'Hello Github', commit it and push (we used -u (--set-upstream) in 2.3, so we can push/pull without arguments)
git checkout hw_git
echo "Hello Github" > homework
git commit -am "2.4 Changes in 'homework'"
git push

# 2.5 Create Pull Request from branch 'hw_git' to the master branch

# 3. task
# 3.1 
docker run --detach \
  --hostname gitlab.localhost \
  --publish 443:443 --publish 80:80 --publish 2222:22 \
  --name gitlab \
  --restart always \
  --volume /srv/gitlab/config:/etc/gitlab:Z \
  --volume /srv/gitlab/logs:/var/log/gitlab:Z \
  --volume /srv/gitlab/data:/var/opt/gitlab:Z \
  gitlab/gitlab-ce:latest
sudo setfacl -R -m default:group:docker:rwx /srv/gitlab

# 3.2 - 3.11 screenshots.tar.gz

# 4. task Travis CI
# 4.1 Added Travis CI to 'homework' repository

# 4.2 .travis.yml
language: minimal
script: bash hw.sh
# hw.sh
echo "Hello World!"

# 4.3, 4.4 screenshots.tar.gz
# README.md in master branch
[![Build Status](https://travis-ci.org/vasishche/homework.svg?branch=master)](https://travis-ci.org/vasishche/homework)

