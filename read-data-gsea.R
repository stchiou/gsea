setwd("U:/My Documents/_research/R-working/gsea")
text_files <- list.files(path = "U:/My Documents/_research/R-working/gsea/gsea-data", 
              pattern = "*.txt", full.names = TRUE)
target_folder <- getwd()
file.copy(text_files, target_folder)
targets <- c(" ", "-", ".txt")
replacements <- c("_", "_", "")
old_names <- text_files
temp_names <- gsub(targets[1], replacements[1], old_names)
new_names <- gsub(targets[2], replacements[2], temp_names)
file.rename(old_names, new_names)
temp <- lapply(new_names, read.table, sep = "\t", header = FALSE)
names(temp) <- list.files(full.names = FALSE)
object_names <- substr(new_names,1,regexpr(".txt",new_names)-1)
new_obj <- lapply(temp,subset,row.names(temp) != "2")
names(new_obj) <- object_names

for(i in 1:length(new_names)){
  obj_names <- object_names[i]
  assign(obj_names, data.frame(new_obj[i]))
  save(obj_names, file = paste(object_names[i], ".rda", sep = ""))
}
