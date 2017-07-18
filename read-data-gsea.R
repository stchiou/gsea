setwd("C:/users/chious/R-working/gsea")

# Read Text file, change file names

text_files <- list.files(path = "C:/users/chious/R-working/gsea/gsea-data", pattern = "*.txt", full.names = TRUE)
target_folder <- getwd()
file.copy(text_files, target_folder)
old_names <- list.files(path = target_folder, pattern = "*.txt", full.names = FALSE)
targets <- c(" ", "-", ".txt")
replacements <- c("_", "_", "")
temp_names <- gsub(targets[1], replacements[1], old_names)
new_names <- gsub(targets[2], replacements[2], temp_names)
file.rename(old_names, new_names)
object_names <- substr(new_names,1,regexpr(".txt", new_names)-1)
temp <- lapply(new_names, read.table, sep = "\t", header = FALSE)
names(temp) <- object_names
file.remove(new_names)
for(i in 1:length(temp)){
    temp_obj <- object_names[i]
    assign(temp_obj, as.data.frame(temp[i])[-2,])
    save(temp_obj, file = paste("C:/users/chious/R-working/gsea/temp_obj/", object_names[i], ".rda", sep = ""))
    write.table(get(temp_obj), file = paste("C:/users/chious/R-working/gsea/temp_obj/", object_names[i], ".txt", sep = ""), sep = "\t", row.names = FALSE, col.names = FALSE)
}
class_names <- paste(object_names, "_class", sep = "")
for(j in 1:length(temp)){
  class_obj <- class_names[j]
  assign(class_obj, as.vector(as.data.frame(temp[j])[2,-1]))
}
