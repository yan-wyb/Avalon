set -euxo pipefail

echo -e "\033[32m $(git version) \033[0m"

git config user.name "yan"
git config user.email "yan-wyb.com"

cd ~/blog/Avalon

git pull origin master
whereis rvm
/home/yan/.rvm/gems/ruby-2.7.0/wrappers/bundle install
/home/yan/.rvm/gems/ruby-2.7.0/wrappers/jekyll build

exit 0
