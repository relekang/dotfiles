#!/bin/bash

# Source https://gist.github.com/trygveaa/c138332b7cf0326b80a23d9004e6baad

base_branch=${1:-master}
keep_branches="HEAD\|master\|bugfix\|$base_branch"
remote=$(git remote)

confirm () {
  message=${1:-Are you sure?}
  read -r -p "$message [y/N]" response
  response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
  if [[ $response =~ ^(yes|y)$ ]]; then
    return 0
  else
    return 1
  fi
}

list_local () {
  git branch $1 | grep -v "$keep_branches\$"
}

list_remote () {
  git branch -r $1 | grep -v "$keep_branches\$" | grep $2 | sed "s/$2\//:/g"
}

delete_local () {
  branches=$(list_local "--merged $base_branch")
  echo "Local branches to delete:"
  echo "$branches"
  if confirm; then
    git branch -d $branches
  fi
}

delete_remote () {
  branches=$(list_remote "--merged $base_branch" $remote)
  echo "Remote branches to delete:"
  echo "$branches"
  if confirm; then
    git push $remote $branches
  fi
}

list_rebased () {
  if confirm "$1"; then
    for branch in $2; do
      found=true
      while read subject; do
        if ! [ "$(git log -i --grep="^$subject$" $base_branch)" ]; then
          found=false
        fi
      done < <(git log --format=%s $base_branch..$branch)

      if $found; then
        echo $branch
      fi
    done
  fi
}

git fetch -p

delete_local
echo
delete_remote
#echo
#list_rebased "List local rebased branches to delete?" "$(list_local)"
#echo
#list_rebased "List remote rebased branches to delete?" "$(list_local -r)"
