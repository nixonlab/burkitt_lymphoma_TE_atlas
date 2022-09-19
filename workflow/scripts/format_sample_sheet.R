################################################################################
################################################################################
################################################################################
################################################################################
#######################  Format Burkitt Lymphoma Metadata ######################

# The original sample sheet (located in "config/samples.tsv") was genereated 
# using the gdcquery.py script, which can be found in "workflow/scripts". The
# information was downloaded through the GDC website, using an API. Additional
# metadata was obtained from https://ocg.cancer.gov/programs/cgci/data-matrix

################################################################################
################################################################################
#################################### SETUP #####################################

library(tidyr)

################################### METADATA ###################################
# Read in sample information
samples <- read.csv("config/samples.tsv", sep = "\t")
# Read in clinical metadata
metadata <- read.csv("config/metadata.patients.tsv", sep = "\t")

colnames(samples) <- c("case_uuid", "project_id", "aliquot_id", "submitter_id",
                       "sample_uuid", "sample_type", "sample_type_id",
                       "sample", "tissue_type", "tumor_descriptor", "case",
                       "data_category", "data_type", "experimental_strategy",
                       "file_id", "file_name", "id", "md5sum")

samples_metadata <- merge(samples, metadata, by.x = "case",
                          by.y = "patient_barcode", all.x = TRUE)

################################### SAVE FILE ###################################

write.table(samples_metadata, 
          "config/samples_metadata.tsv", 
          row.names = FALSE, 
          quote = FALSE,
          sep = "\t")


################################### PILOT SET  ####################################

metadata_pilot <- metadata

# table(metadata$ebv_status, metadata$clinical_variant)
#                 Endemic BL Sporadic BL
# EBV-negative          8          18
# EBV-positive         90           4

# Take all 22 sporadic BL samples
metadata_pilot$pilot[metadata_pilot$clinical_variant == "Sporadic BL"] <- "True"

# Take all 8 EBV-negative endemic BL samples 
metadata_pilot$pilot[metadata_pilot$clinical_variant == "Endemic BL" & 
                       metadata_pilot$ebv_status == "EBV-negative"] <- "True"

# Take 25 random EBV-positive endemic BL samples

metadata_pilot$pilot[metadata_pilot$clinical_variant == "Endemic BL" & 
                       metadata_pilot$ebv_status == "EBV-positive"][1:26] <- "True"


samples_metadata_pilot <- merge(samples, metadata_pilot, by.x = "case",
                          by.y = "patient_barcode", all.x = TRUE)

################################### SAVE FILE ###################################

write.table(samples_metadata_pilot, 
            "config/samples_metadata.tsv", 
            row.names = FALSE, 
            quote = FALSE,
            sep = "\t")
