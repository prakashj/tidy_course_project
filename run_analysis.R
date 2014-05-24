readdata <- function(p_file_name,p_dir_name){
  #Assumption all files are under UCI HAR dataset
  basedir <- paste0(getwd(),"/UCI HAR Dataset")
  #read features file
  filepath <- paste0(basedir,"/","features.txt")
  features <- read.table(filepath,header=FALSE,col.names=c("MeasureID","MeasureName"))
  
  #y file name
  filepath <- file.path(basedir,p_dir_name,paste0("y_",p_file_name,".txt"))
  y_data <- read.table(filepath, header=FALSE, col.names=c("ActivityID"))
  
  filepath <- file.path(basedir,p_dir_name,paste0("subject_", p_file_name, ".txt"))
  subject_data <- read.table(filepath, header=FALSE, col.names=c("SubjectID"))
  
  filepath <- file.path(basedir,p_dir_name,paste0("X_",p_file_name,".txt"))
  xdata <- read.table(filepath, header=FALSE,  col.names=features$MeasureName)

  #Identify mean and std deviation measures
  selfeatures <- grepl("mean\\(|std\\(",features$MeasureName)
  xdata <- xdata[,selfeatures] # subset data for the 66 measures
  xdata$ActivityID <- y_data$ActivityID
  xdata$SubjectID <- subject_data$SubjectID
  xdata
}


main <- function(){
#read test
testdata <- readdata("test","test")
#read train
traindata <- readdata("train","train")
combinedata <- rbind(testdata, traindata)

#Read Actiivty File
basedir <- paste0(getwd(),"/UCI HAR Dataset")
filepath=file.path(basedir,"activity_labels.txt")
activity <- read.table(filepath,header=FALSE,col.names=c("ActivityID","ActivityName"))

#merge activityname
data <- merge(combinedata, activity, by="ActivityID")
#remove .. from column names
cnames <- colnames(data)
cnames <- gsub("\\.+mean\\.+", cnames, replacement="Mean")
cnames <- gsub("\\.+std\\.+",  cnames, replacement="Std")
colnames(data) <- cnames

library(reshape2) 

v_id <- c("ActivityID","ActivityName","SubjectID")
v_measure <- setdiff(colnames(data),v_id)
mdata <-melt(data,id=v_id,measure=v_measure)
#recast mean values
finaldata <- dcast(mdata, ActivityName + SubjectID ~ variable, mean)
write.table(finaldata,file="tidy.txt",row.names=F)
}