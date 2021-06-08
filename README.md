# databaker-docker
Docker container with Databaker, Jupyter, Pandas and other handy data wrangling tools.

This container is used by Jenkins and Data Engineers to build/run data pipelines within GSS' IDP Dissemination Branch.

There are the internally hosted GSS utilities installed along with common python data wrangling tools, these are:

* [databaker](https://github.com/GSS-Cogs/databaker)
* [gss-utils](https://github.com/GSS-Cogs/gss-utils)

## The `gsscogs/dev` container

Is a convenience for local development purposes, this container is a customised version of master using the :dev image tag, additions are:

* All Python packages listed under `[dev-packages]` in this repos `Pipfile` are installed.
* The GSS-Cogs tool [reposync](https://github.com/GSS-Cogs/airtable-utils) is also installed.
* System package gpg2 is installed.

To use [reposync](https://github.com/GSS-Cogs/airtable-utils), see the reposync [README.md](https://github.com/GSS-Cogs/airtable-utils/blob/master/README.md).

## Updating the Pipfile.lock

If you want to add a python package add it to the `Pipfile` then run `make`. **Do not** run `pipenv install` locally to update it. There are mac os assumptions that we don't want to be making on the linux container environment.

## Builds & CI

Is handled by the github actions defined in `/.github/workflows`. To check build status click `Actions` above.

* `gsscogs/databaker:latest` and `gsscogs/databaker:<release_tag>` are built when (a) you create a `release` and (b) the commit of the release matches the commit of the master branch.

* `gsscogs/databaker:dev` is built whenever you push or merge a change to master.

_Note: I mean `release` literally, just adding a tag will **not** trigger a release build._
