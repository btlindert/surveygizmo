# Munge

The preprocessing scripts stored in `munge` will be executed sequentially when you call `load.project()`, so you should append numbers to the filenames to indicate their sequential order.

This dir contains files to:

- Download new data
- Check the data quality using the scripts in the NSR Bitbucket repo
- Unhash the data to obtain anonymous user IDs

See the script documentation for details.
