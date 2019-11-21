# surveygizmo

# Introduction
This repo automates processing of Surveygizmo (SG) data for the Sleep and Cognition group of the Netherlands Institute for Neuroscience. The work involves:

* Downloading the data from SG using [this API interface](https://github.com/btlindert/rsurveygizmo).
* Verifying the quality of the data and computing sum scores (Bitbucket repo).
* Unhashing the data to convert truly random hashes to anonymous user IDs.
* Merging the data into a single file.

# Project template
This project was created with [ProjectTemplate](http://projecttemplate.net).

# Requirements
Install `ProjectTemplate` and any of the libraries specified in the `config/global.dcf`.

Create a `.env` file with the api (API=somekey) and secret (SECRET=somesecret) keys of your SG account and questionnaire names and IDs (ISI=1234567890). Specify the path to the `.env` file in `lib/globals.R`. Don't push the file to this repo.

# Getting started
To load this project, you'll first need to `setwd()` into the directory
where this README file is located. Then you need to run the following two
lines of R code:

```
library('ProjectTemplate')
load.project()
```

After you enter the second line of code, you'll see a series of automated
messages as ProjectTemplate goes about doing its work. This work involves:
* Reading in the global configuration file contained in `config`.
* Loading any R packages you listed in the configuration file.
* Reading in any datasets stored in `data` or `cache`.
* Preprocessing your data using the files in the `munge` directory.

Once that's done, you can execute any code you'd like. For every analysis
create a file in the `src` directory. All files should start with the two lines mentioned above:

```
library('ProjectTemplate')
load.project()
```

So you'll have access to all of your data, already fully preprocessed, and
all of the libraries you want to use.

See the README files in each of the directories to see what it's for and what it does.
