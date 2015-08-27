#!/bin/sh
# 
# Based on GitHub Help : https://help.github.com/articles/changing-author-info/
# 
# To change the name and/or email address recorded in existing commits, 
# you must rewrite the entire history of your Git repository.
#
# Warning: This action is destructive to your repository's history. 
# If you're collaborating on a repository with others, it's considered
# bad practice to rewrite published history. You should only do this in an emergency.
#
# Changelog:
#  - Updated script to support 'contains' which enables fixing old e-mails that 
#    contains special characters (e.g. e-mails with quotes) 
#

git filter-branch --env-filter '

OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"

if [[ "$GIT_COMMITTER_EMAIL" = *"$OLD_EMAIL"* ]]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [[ "$GIT_AUTHOR_EMAIL" = *"$OLD_EMAIL"* ]]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
