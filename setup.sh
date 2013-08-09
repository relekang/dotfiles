rm $HOME/.bash_profile
ln -s $PWD/bash/bash_profile $HOME/.bash_profile
echo "Created symbolic link for .bash_profile"

rm $HOME/.bash_aliases
ln -s $PWD/bash/bash_aliases $HOME/.bash_aliases
echo "Created symbolic link for .bash_aliases"

rm $HOME/.gitconfig
ln -s $PWD/git/gitconfig $HOME/.gitconfig
echo "Created symbolic link for .gitconfig"

if [[ $OSTYPE == "darwin12" ]]; then
  echo "Setting OS X settings"
  sh osx_defaults.sh
fi

echo "Cloning vimfiles from github.com/relekang/vimfiles"
git clone git@github.com:relekang/vimfiles.git

cd vimfiles/
git submodule init
git submodule update
cd ..

rm $HOME/.vim
ln -s $PWD/vimfiles/vim $HOME/.vim
echo "Created symbolic link for .vim"

rm $HOME/.vimrc
ln -s $PWD/vimfiles/vimrc $HOME/.vimrc
echo "Created symbolic link for .vimrc"
