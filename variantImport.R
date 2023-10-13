variantImport <- function(url, filename) {
  # Step 1: Use filename to create a filename to store the zip file
  zip_filename <- paste0(filename, ".zip")
  
  # Step 2: Download the data from url and save it to a file
  download.file(url, destfile = zip_filename)
  
  # Step 3: Unzip the compressed file
  unzip(zip_filename)
  
  # Step 4: Read the file using read.csv()
  data <- read.csv(filename)
  
  # Step 5: Remove the rows that do not contain "Pahal" in the "gene" column
  data <- data[data$gene == "Pahal", ]
  
  # Step 6: Split the "pos" column into "begPos" and "endPos" columns
  pos_split <- strsplit(data$pos, "-")
  data$begPos <- sapply(pos_split, function(x) as.numeric(x[1]))
  data$endPos <- sapply(pos_split, function(x) as.numeric(x[2]))
  
  # Step 7: Convert the new columns to numeric values
  data$begPos <- as.numeric(data$begPos)
  data$endPos <- as.numeric(data$endPos)
  
  # Step 8: Reorder the data.frame by chromosome, beginning position, and ending position
  data <- data[order(data$chromosome, data$begPos, data$endPos), ]
  
  # Step 9: Return the subset and sorted dataset
  return(data)
}
