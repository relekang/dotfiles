rm $HOME/.bash_profile
ln -s $PWD/.bash_profile $HOME/.bash_profile
echo "Created symbolic link for .bash_profile"

rm $HOME/.bash_aliases
ln -s $PWD/.bash_aliases $HOME/.bash_aliases
echo "Created symbolic link for .bash_aliases"

rm $HOME/.gitignore
ln -s $PWD/.gitignore $HOME/.gitignore
echo "Created symbolic link for .gitignore"

rm $HOME/.vimrc
ln -s $PWD/.vimrc $HOME/.vimrc
echo "Created symbolic link for .vimrc"

rm -r $HOME/.vim
ln -s $PWD/.vim $HOME/.vim
echo "Created symbolic link for .vim/"
