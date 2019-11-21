# Merge data
if (config$merge) {

  # Specify columns based on whether is was unhashed.
  if (config$unhash) {
    merge_cols <- c('study', 'group', 'questionnaire', 'user')
  } else {
    merge_cols <- c("studyID", "groupID", "questionnaireID", "userID")
  }

  # Loop through questionnaires, convert to long and merge.
  iter = 1
  for (f in c(config$to_check, config$not_to_check)) {

    # Convert file to long format
    df <- get(f) %>%
      select(c(starts_with(f), merge_cols)) %>%
      gather(key = "item", value = "value", -merge_cols)
    
    if (iter == 1) {
      merged_data <- df
    } else {
      merged_data <- rbind(df, merged_data)
    }
  }
  
  # Write data to csv file
  write.csv(merged_data, file = config$merged_file)
}