# Merge data
if (config$merge) {

  # Specify columns based on whether is was unhashed.
  if (config$unhash) {
    merge_cols <- c('study', 'group', 'questionnaire', 'StudyId')
  } else {
    merge_cols <- c("studyID", "groupID", "questionnaireID", "StudyId")
  }

  # Loop through questionnaires, convert to long and merge.
  iter = 1
  for (questionnaire in c(config$to_check, config$not_to_check)) {
    
    # Convert file to long format
    df <- get(questionnaire) %>%
      select(-starts_with('calc')) %>%
      gather(key = "item", value = "value", starts_with(questionnaire))
    
    # Sometimes endTime is pulled as end_time...
    names(df) <- str_replace(names(df), 'end_time', 'endTime')
    
    if (iter == 1) {
      merged_data <- df
    } else {
      merged_data <- full_join(df, merged_data)
    }
    iter = iter + 1
  }
  
  # Write data to csv file
  if (!is.na(config$merged_file)) {
    write.csv(file.path(getwd(), 'data'), file = config$merged_file)
  }
}
