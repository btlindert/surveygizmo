import_hash_table_all <- function(file_name, nCols = 50) {
  # Participants can participate in multiple studies. Each study alias is added to a column without a column name.
  # Column length differs per subject. Default read.csv only imports columns with info in first 5 rows.
  # Solution: Generate sufficient column names. Fill empty columns with NA.
  data <- read.csv(file_name, header = F, col.names = paste0("V", c(1:nCols)), fill = TRUE)

  # Clean the data.
  data <- data %>%
    select(which(!apply(data, 2, function(x) all(is.na(x))))) %>% # Drop empty columns
    rename(
      Type = V1,
      ID = V2,
      Name = V3,
      ParticipantId = V4,
      Hash = V5,
      CurrentEnrollment = V6,
      Enrollments = V7
    ) %>% # Rename columns
    slice(-1) %>% # Drop first row with old headers
    mutate(ID = as.numeric(ID)) %>% # convert ID to numeric for sorting
    gather(key = Enrollment, value = StudyId, -Type, -ID, -Name, -Hash, -CurrentEnrollment) %>% # Convert wide to long format
    mutate(Enrollment = str_extract(StudyId, "^[[:alpha:]]{4}")) %>% # Extract Enrollment from StudyId
    distinct() %>% # Drop all the duplicates (many empty due to wide to long conversion of mostly empty columns)
    filter(!(Type == "User" & is.na(Enrollment))) %>%# Drop user rows with empty Enrollment
  arrange(Type, ID, Name) # Sort by Type, then ID, then Name.

  return(data)
}
