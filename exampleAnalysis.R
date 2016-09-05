# Purpose: Example analysis using job function results
# Author: Bryan Shepherd
# Twitter: @bryancshepherd
# Github: bryancshepherd

source("jobSearchFunctions.R")

# set search terms
term1 = "Python"
term2 = "SPSS"

# Get the job results - this may take a couple of minutes
jobResultsList = getJobs(c(term1, term2), nPages=50)

# Clean the data
cleanedJobData = cleanJobData(jobResultsList)

# Create ordered wordlists for titles and descriptions
orderedTables = createWordTables(cleanedJobData)

# Create a flat file from the data for easier manipulation and plotting
flatFile = createFlatFile(orderedTables)

# Use this to write the flat file to csv if needed
# write.csv(flatFile, "Change Me To Your Preferred Directory", row.names=FALSE)

# Union
combinedTitleTables = merge(orderedTables[[term1]][["Titles"]], orderedTables[[term2]][["Titles"]], by = "Var1", all = TRUE, suffixes = c(paste0("_", term1), paste0("_", term2)))
combinedTitleTables[is.na(combinedTitleTables)] = 0

# Percent difference
combinedTitleTables$term1_Percent = (combinedTitleTables[,2]/sum(combinedTitleTables[,2])) * 100
combinedTitleTables$term2_Percent = (combinedTitleTables[,3]/sum(combinedTitleTables[,3])) * 100
combinedTitleTables$PercentDifference = (combinedTitleTables$term1_Percent - combinedTitleTables$term2_Percent)
combinedTitleTables$RelativePercentDifference = (combinedTitleTables$term1_Percent - combinedTitleTables$term2_Percent)/(combinedTitleTables$term1_Percent + combinedTitleTables$term2_Percent)

# write.csv(combinedTitleTables, "Your directory here", row.names=FALSE)

# Intersection
# combinedTables = merge(orderedTables[["SPSS"]][["Titles"]], orderedTables[["Python"]][["Titles"]], by = "Var1", suffixes = c("_SPSS", "_Python"))

# Union of popular
combinedTables = merge(orderedTables[["SPSS"]][["Titles"]][1:20,], orderedTables[["Python"]][["Titles"]][1:20,], by = "Var1", all= TRUE, suffixes = c("_SPSS", "_Python"))

combinedTables[is.na(combinedTables)] = 0

cor(combinedTables[2], combinedTables[3], method = "spearman")

wordcloud(words = combinedTables[,1], freq = combinedTables[,2], min.freq=5, max.words=25)

wordcloud(words = combinedTables[,1], freq = combinedTables[,3], min.freq=5, max.words=25)

# flatFile$Percent = ifelse(flatFile$searchTerm == "Python", -flatFile$Percent, flatFile$Percent)

ggplot(data = flatFile[flatFile$resultType == "Titles" & flatFile$Percent >= 2,], 
       aes(x=resultTerms, y=Percent, group=searchTerm, fill=searchTerm)) + 
  geom_bar(stat="identity", position=position_dodge(), size = .3) +
  theme(axis.title.x = "Job Title Terms")

ggplot(data = flatFile[flatFile$resultType == "Titles" & abs(flatFile$Percent) >= 2,], 
       aes(x=resultTerms, y=Percent, group=searchTerm, fill=searchTerm)) + 
  geom_bar(stat="identity", size = .3)

ggplot(data = flatFile[flatFile$resultType == "Summaries" & flatFile$Percent >= 1,], 
       aes(x=resultTerms, y=Percent, group=searchTerm, fill=searchTerm)) + 
  geom_bar(stat="identity", position=position_dodge(), size = .3)
