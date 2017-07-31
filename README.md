This README contains information about the run_analysis.R script and associated codebook, CodeBook.md.

run_analysis.R is an R script that manipulates data from the UCI HAR dataset. Run the script from a working directory that contains the UCI HAR Dataset folder. The script produces a tidy dataset that I've exported and saved as tidy_dataset.txt.

The script loads the original data into R dataframes, manipulates the dataframes to make them easier to read and work with, then uses the dataframes to create output data with the required content as described in the course assignment. See the notes in the script itself for more information about implementation. 

The codebook contains an explanation of the formatting of the tidy dataset, descriptions of variables, and links to the original dataset.

To read tidy_dataset.txt into R, use the following code:
data <- read.table("./tidy_dataset.txt", header = TRUE)
View(data)
