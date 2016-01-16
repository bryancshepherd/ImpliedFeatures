# Purpose: Example analysis using job function results
# Author: Bryan Shepherd
# Twitter: @bryancshepherd
# Github: bryancshepherd

jobResultsList = getJobs(c("Python", "SPSS"), 50)

cleanedJobData = cleanJobData(jobResultsList)

orderedTables = createWordTables(cleanedJobData)

flatFile = createFlatFile(orderedTables)

# write.csv(flatFile, "Change Me To Your Preferred Directory", row.names=FALSE)

table(flatFile[, "resultTerms"])

orderedTables[["SPSS"]][["Titles"]]

# Union
combinedTitleTables = merge(orderedTables[["SPSS"]][["Titles"]], orderedTables[["Python"]][["Titles"]], by = "Var1", all= TRUE, suffixes = c("_SPSS", "_Python"))
combinedTitleTables[is.na(combinedTitleTables)] = 0

# Percent difference
combinedTitleTables$SPSS_Percent = (combinedTitleTables[,2]/sum(combinedTitleTables[,2])) * 100
combinedTitleTables$Python_Percent = (combinedTitleTables[,3]/sum(combinedTitleTables[,3])) * 100
combinedTitleTables$PercentDifference = (combinedTitleTables$Python_Percent - combinedTitleTables$SPSS_Percent)
combinedTitleTables$RelativePercentDifference = (combinedTitleTables$Python_Percent - combinedTitleTables$SPSS_Percent)/(combinedTitleTables$Python_Percent + combinedTitleTables$SPSS_Percent)

# write.csv(combinedTitleTables, "S:/users/Shepherd/Presentation/SPSS/tableTitles.csv", row.names=FALSE)


# Intersection
# combinedTables = merge(orderedTables[["SPSS"]][["Titles"]], orderedTables[["Python"]][["Titles"]], by = "Var1", suffixes = c("_SPSS", "_Python"))

# Union of popular
# combinedTables = merge(orderedTables[["SPSS"]][["Titles"]][1:20,], orderedTables[["Python"]][["Titles"]][1:20,], by = "Var1", all= TRUE, suffixes = c("_SPSS", "_Python"))

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
