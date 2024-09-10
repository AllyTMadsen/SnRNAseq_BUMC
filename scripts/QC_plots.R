#!/usr/bin/env Rscript
# Load libraries
library(SingleCellExperiment)
library(Seurat)
library(tidyverse)
library(patchwork)
library(ggplot2)
library(cowplot)


# FOR RAW DATA
data.dir = "/projectnb/setagrp/atmadsen/Seta_aorticAneurysm_snRNA/results/TY_SF_Angiotensin_II_WT/outs/raw_feature_bc_matrix"

# How to read in 10X data using directory
list.files(data.dir)
raw_counts_dir <- Read10X(data.dir)

# Turn count matrix into a Seurat object (output is a Seurat object)
counts_obj <- CreateSeuratObject(counts = raw_counts_dir, project = "angio-WT",
                           min.features = 250)

head(counts_obj@meta.data)

counts_obj

#label mito genes
counts_obj[["percent.mt"]] <- PercentageFeatureSet(counts_obj, pattern = "^mt-")

#create violin QC plots
violin <- VlnPlot(counts_obj, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)

#scatter QC plots
plot1 <- FeatureScatter(counts_obj, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(counts_obj, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")

# Combine the plots into one grid
combined_plot <- plot_grid(plot1, plot2, violin, labels = c("Mt-", "Features", "Violin"), ncol = 1)

# Save the combined plot to a PNG file
ggsave(filename = "QC_angioWT_raw.png", plot = combined_plot, width = 7, height = 15, dpi = 300)

#RAW COUNTS OBJ:
#57186 features across 8861 samples within 1 assay 
#Active assay: RNA (57186 features, 0 variable features)




# FOR SOUPX DATA
data.dir2 = "/projectnb/setagrp/atmadsen/Seta_aorticAneurysm_snRNA/results/soupX_ag_WT_filt"

# How to read in 10X data using directory
list.files(data.dir2)
raw_counts_dir_soup <- Read10X(data.dir2)

# Turn count matrix into a Seurat object (output is a Seurat object)
counts_obj_soup <- CreateSeuratObject(counts = raw_counts_dir_soup, project = "angio-WT",
                           min.features = 250)

head(counts_obj_soup@meta.data)

counts_obj_soup

#label mito genes
counts_obj_soup[["percent.mt"]] <- PercentageFeatureSet(counts_obj_soup, pattern = "^mt-")

#create violin QC plots
violin <- VlnPlot(counts_obj_soup, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)

#scatter QC plots
plot1 <- FeatureScatter(counts_obj_soup, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(counts_obj_soup, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")

# Combine the plots into one grid
combined_plot <- plot_grid(plot1, plot2, violin, labels = c("Mt-", "Features", "Violin"), ncol = 1)

# Save the combined plot to a PNG file
ggsave(filename = "QC_angioWT_soup.png", plot = combined_plot, width = 7, height = 15, dpi = 300)

#FILTERED COUNTS OBJ
#57186 features across 6782 samples within 1 assay 
#Active assay: RNA (57186 features, 0 variable features)

#--removed 2,079 cells