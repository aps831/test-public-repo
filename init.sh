#! /bin/bash

# asdf
asdf install

# trunk
trunk init
tag=$(gh api -H "Accept: application/vnd.github+json" repos/aps831/trunk-io-plugins/releases/latest | jq .name -r)
trunk plugins add --id aps831 https://github.com/aps831/trunk-io-plugins "${tag}"
trunk actions enable commitizen
trunk actions enable commit-branch

# github
gh repo set-default
gh repo edit --delete-branch-on-merge
nameWithOwner=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
gh api --method PUT -H "Accept: application/vnd.github+json" "/repos/${nameWithOwner}/vulnerability-alerts"
gh api --method PUT -H "Accept: application/vnd.github+json" "/repos/${nameWithOwner}/automated-security-fixes"
gh label create github_actions --description "Update to Github actions" --color 0E8A16
gh label create dependencies --description "Update to dependencies" --color D4C5F9
