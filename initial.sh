#/bin/bash
set -x

if [ -f $HOME/.ssh/id_rsa.pub ]; then
  echo "Key already exists"
else
  ssh-keygen -t rsa -b 4096 -C "me@rolflekang.com"
  cat ~/.ssh/id_rsa.pub | pbcopy
  
  open https://github.com/settings/ssh/new
  
  read -n1 -r -p "Press any key to continue..." key
fi

ssh-add

until git --version; do
  sleep 1
done

cd ~
git clone git@github.com:relekang/dotfiles.git .files

cd .files
make clean install
