# Basic Template

## Usage

To use this repository as a template run
`gh repo create <repo_name> --clone --private -p aps831/basic-template`.

Once cloned:

-   delete `.github` directory
-   rename `github` directory to `.github`
-   update `username` and `repositoryname` in `.github/workflows/bitbucket-mirror.yaml`
-   update `.github/dependabot.yml`
-   run the init script `init.sh`
-   delete the init script `init.sh`
-   update `README.md`
