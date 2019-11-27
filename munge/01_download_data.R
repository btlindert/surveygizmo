# For each questionnaire download the data from SG using the API.

# Load dotenv file with confidential information.
load_dot_env(file = config$dotenv)

# Set date for processing.
date <- config$date #' 191022' # format(Sys.Date(), '%y%m%d')

# List of questionnaires to pull from SG.
questionnaires <- c(config$to_check, config$not_to_check)

# Loop through the files and download the data, if not already present.
reload = FALSE
for (questionnaire in questionnaires) {

  # Create data file name for checking/saving.
  file_name <- file.path("data", str_c(date, "_", questionnaire, ".csv"))

  # Download data if not already present.
  if (!file.exists(file_name)) {
    
    # Update terminal.
    print(paste('Downloading data for:', questionnaire))
    reload = TRUE

    # Download data.
    df <- pullsg(Sys.getenv(questionnaire),
                 Sys.getenv('API'),
                 Sys.getenv('SECRET'),
                 config$locale,
                 completes_only = TRUE)

    # Write data frame to csv file
    write.csv(df, file = file_name)
  }
}

if (reload) {
  print('New data downloaded. Reloading project.')
  reload.project()
}