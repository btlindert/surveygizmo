# Specify directories.
nsr_dir <- config$nsr_dir
misc_dir <- file.path(nsr_dir, 'misc')
ques_dir <- file.path(nsr_dir, 'questionnaires')

# Source functions.
source(file.path(misc_dir, 'compareScales.R'))
source(file.path(misc_dir, 'naCheck.R'))
source(file.path(misc_dir, 'rangeCheck.R'))

# Check which date to use for data files
if ('date' %in% names(config)) {
  date = config$date
} else {
  # List files in data dir.
  files <- list.files('data', pattern = '^[[:digit:]]{6}_')

  # Get the most recent date of all files.
  date <- files %>%
    tibble() %>%
    transmute(date = as.numeric(str_extract(., pattern = '^[[:digit:]]{6}'))) %>%
    arrange(desc(date)) %>%
    slice(1) %>%
    pull(date)
}

# Select the data with the specified date.
files <- list.files('data', pattern = str_c('^', date))

# Check which files to process
if ('to_check' %in% names(config)) {
  if (length(config$to_check) != 0) {
    subset <- config$to_check
    files <- paste0(date, '_', subset, '.csv')
  } else {
    print('Please specify a list for config$to_check')
    break
  }
}
# Else; process all files in files

# Pass these files to the cleaning scripts.
for (file_name in files) {

  # Extract questionnaire id.
  questionnaire <- str_extract(file_name, "(?<=_)[:alpha:]*(?=.csv$)")

  # Source the corresponding R script.
  rscript <- file.path(ques_dir, str_c(str_to_upper(questionnaire), ".R"))
  if (file.exists(rscript)) {

    # Script.
    source(rscript)

    # Data file.
    data_file <- str_c("X", date, ".", str_replace(questionnaire, "_", "."))

    if (exists(data_file)) {
      expression <- str_c("data <- ", str_to_upper(questionnaire), "(", data_file, ", drop.na = TRUE)")
    }

    # Evaluate the script with the data.
    eval(parse(text = expression))
  }

  # Assing to a variable with the name of the questionniare.
  assign(questionnaire, data)

  # Optional: Write data frame to csv file
  # write.csv(get(questionnaires[q]), file = file.path(outputDir, paste0(format(Sys.Date(), "%y%m%d_"), questionnaires[q], ".csv")))
}
