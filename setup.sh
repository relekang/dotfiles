rm $HOME/.bash_profile
ln -s $PWD/.bash_profile $HOME/.bash_profile
echo "Created symbolic link for .bash_profile"

rm $HOME/.gitignore
ln -s $PWD/.gitignore $HOME/.gitignore
echo "Created symbolic link for .gitignore"

rm $HOME/.vimrc
ln -s $PWD/.vimrc $HOME/.vimrc
echo "Created symbolic link for .vimrc"
