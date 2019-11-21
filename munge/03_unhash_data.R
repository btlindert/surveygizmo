# Unhash

# Run unhashing if required
if (config$unhash) {

  # Load the hash table.
  hash_table <- import_hash_table_all(config$hash_table)

  for (questionnaire in c(config$to_check, config$not_to_check)) {
    data <- unhash_data(hash_table, get(questionnaire), config$project)
    assign(questionnaire, data)
  }
}
