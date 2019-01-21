library(RnBeads)
library(RPMM)

# Set working directory
setwd("/Users/Haakon/Documents/PhD program/WorkplaceR")

# Define paths and file names for  
data.dir = "/Users/Haakon/Documents/PhD program/IdatAndAnnotation/" # This variable is currently not used
idat.dir = file.path("/Users/Haakon/Documents/PhD program", "IdatAndAnnotation") # pointing to the folder IdatAndAnnotation where the idat files and samplesSheet_cordblood.csv are saved
sample.annotation = file.path(idat.dir, "samplesSheet_cordblood.csv")
analysis.dir = "/Users/Haakon/Documents/PhD program/SaveRnBeads" # Difines a directory where the data will be saved
report.dir = file.path(analysis.dir, "CordBlood_Nonadjusted") # Difines a folder within analysis.dir where the results are saved

#Setting up analysis
# filtering blacklist is pointing to a txt file (1 column) of CG-ids in the working directory. This can be changed to any txt file of probes you want removed.
# ?rnb.options() gives quite alot of information regarding the variables to be defined.
rnb.options(
            analysis.name           = "CordBlood",          ## How can we annotate if there is multiple data (ie. some cordBlood and som PBMC?
            identifiers.column      = "Sample_Name",        ## Depending on the sample sheet
            normalization.method    = "bmiq",               ## To be discussed, but probably the best normalizing for now
            filtering.blacklist     = "48639-non-specific-probes-Illumina450k.txt", ## CMP will provide the list 
            filtering.sex.chromosomes.removal = TRUE,       ## Should we remove the X & Y chomosome? Might want to look into X-Chromsome? 
            filtering.greedycut.pvalue.threshold = 0.01,    ## Specific value is probably ok, but sould be discussed
            exploratory             = TRUE,                 ## What does this mean?
            exploratory.columns     = c("Sample_Group", "Method"), 
            exploratory.beta.distribution = FALSE, 
            exploratory.clustering  = "none",
            differential            = FALSE)

#Vanilla analysis, involving filtering, probe-detection checks and bmiq normalization
rnb.run.analysis(
            dir.reports = report.dir, 
            sample.sheet= sample.annotation, 
            data.dir    = idat.dir, 
            data.type   = "idat.dir")                       ## Why the *.dir for the data types?

# extract betas from rnbSet
rnb.set.inference       = load.rnb.set(
            file.path("/Users/Haakon/Documents/PhD program/SaveRnBeads/CordBlood_Nonadjusted/", "rnbSet_preprocessed"))

#get betas for plotting
betas_inference=as.data.frame(meth(rnb.set.inference, row.names=TRUE))
colnames(betas_inference)
rownames(betas_inference)[1:100]
# Plotting of the methylation value for all samples for the first 100 CpGs 
matplot(betas_inference[1:100,], type = "l")

