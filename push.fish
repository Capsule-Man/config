cp -r ~/.emacs.d .
rm -rf Code;and mkdir Code
cp -r ~/.config/Code/User Code/User
rm -rf Code/User/locale.json Code/User/workspaceStorage/ 
git add -A
git commit -m "change"
git push -u origin master
