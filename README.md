# databaker-docker
Docker container with Databaker, Jupyter, Pandas and other handy data wrangling tools.

This container is used by Jenkins and Data Engineers to build/run data pipelines within GSS' IDP Dissemination Branch.

There are three internall hosted by OSS utilities installed along with common python data wrangling tools, these are:
* [databaker](https://github.com/GSS-Cogs/databaker)
* [gss-utils](https://github.com/GSS-Cogs/gss-utils)
* [reposync](https://github.com/GSS-Cogs/airtable-utils)

For development purposes the container is customised using the :dev image tag. The changes are to improve the development experience. This image is only addative from latest:
* Python packages pylint and reposync are installed
* System package gpg2 is installed

To use reposync, see the reposync [README.md](https://github.com/GSS-Cogs/airtable-utils/blob/master/README.md).
