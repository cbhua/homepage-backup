hugo -t pure
cd .\public
git add -A
git status
git commit -m "upload post"
git push origin master