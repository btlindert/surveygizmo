# Add any project specific configuration here.
# Variables
# ---------
# date: string
#   YYMMDD of data files in /data to be used. If date doesn't match files in '/data', new data will be downloaded from SurveyGizmo and stored in data using this date prefix.
# dotenv: string
#   Path to a .env file with system variables defining SG questionnaire IDs, the API code and API secret.
# locale: string
#   Locale to use to connect to SG API. One of 'EU', 'US', 'CA'.
# nsr_dir: string
#   Path to NSR3 Bitbucket repo containing the data verification scripts.
# hash_table: string
#   Path to NSR hash table.
# unhash: boolean
#   TRUE if you want to unhash the data.
# project: string
#   NSR project code. Required if unhash=TRUE. Used to subset the data to only project related data. Default = 'all'
# to_check: character vector
#   List of questionnaires to download from SG and verify with scripts
# not_to_check: character vector
#   List of questionnaires to download from SG but not verify with scripts (e.g. if no scripts are available for verification)
# merge: character vector
#   List of questionnaires to merge after verification.
# merged_file: string
#   Path to store the merged data.
add.config(
  date = '191122',
  dotenv = 'data/.env',
  locale = 'EU',
  apply.override = FALSE,
  nsr_dir = '~/Code/repos/nsr3/scripts',
  hash_table = 'data/20191022_NSRHashMappingAll.csv',
  unhash = TRUE,
  project = 'ercp', # required if unhash = TRUE. Default is 'all'
  to_check = c('HADS', 'RMEQ', 'BEACKE', 'PANAS', 'IDSSR', 'CTQ', 'BAI', 'ISI'), # 'PSQI', 'MCTQC',
  not_to_check = c(),
  merge = TRUE,  # to_check, not_to_check, all'
  merged_file = 'data/merged_file.csv'
)

# Add project specific configuration that can be overridden from load.project()
add.config(
  apply.override = TRUE
)
