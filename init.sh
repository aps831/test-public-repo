#! /bin/bash

# # asdf
# asdf install

# # trunk
# trunk init
# tag=$(gh api -H "Accept: application/vnd.github+json" repos/aps831/trunk-io-plugins/releases/latest | jq .name -r)
# trunk plugins add --id aps831 https://github.com/aps831/trunk-io-plugins "${tag}"
# trunk actions enable commitizen
# trunk actions enable commit-branch

# # github
# gh repo set-default
# gh repo edit --delete-branch-on-merge

# nameWithOwner=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
# branch=$(git rev-parse --abbrev-ref HEAD)
isPrivate=$(gh repo view --json isPrivate --jq '.isPrivate')

# gh api --method PUT -H "Accept: application/vnd.github+json" "/repos/${nameWithOwner}/vulnerability-alerts"
# gh api --method PUT -H "Accept: application/vnd.github+json" "/repos/${nameWithOwner}/automated-security-fixes"
# gh api --method PUT -H "Accept: application/vnd.github+json" "/repos/${nameWithOwner}/actions/permissions/workflow" -f default_workflow_permissions='read' -F can_approve_pull_request_reviews=true
# gh label create github_actions --description "Update to Github actions" --color 0E8A16
# gh label create dependencies --description "Update to dependencies" --color D4C5F9

# TODO add scorecard workflow to github-public
# TODO add codeql workflows to github-public

if [ $isPrivate == "false" ]; then
  echo "here"
  # MIT Licence
  # wget -q -O LICENCE.md "https://raw.githubusercontent.com/IQAndreas/markdown-licenses/master/mit.md"
  # Advanced security
  echo '{"security_and_analysis":{"secret_scanning":{"status":"enabled"}}}' | gh api --method PATCH -H "Accept: application/vnd.github+json" "/repos/${nameWithOwner}" --input - >/dev/null 2>&1
  echo '{"security_and_analysis":{"advanced_security":{"status":"enabled"}}}' | gh api --method PATCH -H "Accept: application/vnd.github+json" "/repos/${nameWithOwner}" --input - >/dev/null 2>&1
  # Branch protection
  echo '{"required_status_checks":null,"enforce_admins":true,"required_pull_request_reviews":null,"restrictions":null,"required_linear_history":true,"allow_fork_syncing":false}' | gh api --method PUT -H "Accept: application/vnd.github+json" "https://api.github.com/repos/${nameWithOwner}/branches/${branch}/protection" --input - >/dev/null 2>&1
fi
