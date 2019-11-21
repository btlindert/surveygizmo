unhash_data <- function(hash_table_all, data, project = 'all') {
  
  # To avoid merge warnings: convert vars to character
  hash_table_all <- hash_table_all %>%
    mutate(Hash = as.character(Hash))
  data <- data %>%
    mutate(groupID = as.character(groupID),
           questionnaireID = as.character(questionnaireID),
           studyID = as.character(studyID),
           userID = as.character(userID))
  
  # Select group hashes.
  group <- hash_table_all %>%
    filter(Type == 'Group') %>%
    select(Name, Hash) %>%
    rename(group = Name,
           groupID = Hash)
  
  # Select questionnaire hashes.
  questionnaire <- hash_table_all %>%
    filter(Type == 'Questionnaire') %>%
    select(Name, Hash) %>%
    rename(questionnaire = Name,
           questionnaireID = Hash)
  
  # Select study hashes.
  study <- hash_table_all %>%
    filter(Type == 'Study') %>%
    select(Name, Hash) %>%
    rename(study = Name,
           studyID = Hash)
  
  # Select user hashes.
  user <- hash_table_all %>%
    filter(Type == 'User') %>%
    select(-Type, -ID) %>%
    rename(user = Name,
           userID = Hash)
  
  # Unhash study.
  data <- left_join(data, study, by = 'studyID')
  
  # Unhash group.
  data <- left_join(data, group, by = 'groupID')
  
  # Unhash questionnaire.
  data <- left_join(data, questionnaire, by = 'questionnaireID')
  
  # Unhash user (mulitple enrollments).
  data <- left_join(data, user, by = 'userID')
  
  # Drop hash columns.
  data <- data %>%
    select(-studyID, -groupID, -questionnaireID, -userID)
  
  # If project is specified, subset the data.
  if (project != 'all') {
    data <- data %>% 
      filter(Enrollment == project)
  }
  
  return(data)
}
