# MEIOSIS_MS_2
## Second manuscript for the project MEIOSIS
This repository contains R scripts and data for analyzing butterfly body size trends over the past 110 years using Generalized Additive Models (GAM). The study investigates how life history traits (e.g., phenology, voltinism, gender) and ecological factors (e.g., thermal tolerance, mobility) influence body size in response to climate change and land use. Results reveal sex-specific trends, with males showing size reductions and females exhibiting opposite patterns, highlighting the complex effects of environmental change on butterfly morphology.

# Butterfly Body Size Trends Analysis

## 📊 Overview

This repository contains R scripts for analyzing butterfly body size trends in response to climate change. The analyses focus on understanding the influence of environmental variables, ecological traits, and land use on butterfly morphology across different time periods.

## 🚀 Features

- **Data Preprocessing:** Data cleaning, transformation, and imputation of missing values.
- **Statistical Modeling:** Generalized Additive Models (GAMs) and Linear Mixed Effects Models to assess trends.
- **Model Diagnostics:** Evaluation of model assumptions and goodness-of-fit metrics.
- **Visualization:** High-quality plots to visualize parametric effects, smooth terms, and interaction effects.

## 📂 Project Structure

📦 Butterfly-Body-Size-Trends ├── 📁 data/ # Raw data files ├── 📁 scripts/ # R scripts for data analysis ├── 📁 output/ # Model outputs and visualizations └── 📄 README.md # Project documentation


## 📦 Requirements

Ensure you have the following R packages installed:

```R
install.packages(c("mgcv", "MASS", "stringr", "gamm4", "tidyverse", 
                   "ggplot2", "gratia", "missRanger", "patchwork", 
                   "nlme", "lme4", "ggeffects", "visreg"))
```

## 📝 Usage
Load Data: Place the dataset (newdf_Periods_STI_grids_alltraits.csv) in the data/ folder.
Run Scripts: Execute the main analysis script:

source("scripts/Ms_2_script.R")

View Results: Model summaries and diagnostic plots will be saved in the output/ folder for easy review.
## 📊 Models Implemented
📈 GAM for Temporal Trends:

Assess the effect of year on butterfly body size.
Evaluate the impact of environmental and ecological covariates.
## 👥 Gender-Based GAM:

Analyze sex-specific differences in body size trends.
Visualize smooth effects for male and female butterflies.
## 🌍 Land Use Models:

Investigate the influence of land cover changes on butterfly morphology.
📈 Example Plots
📊 Parametric Effects: Displaying key environmental drivers.
⏱️ Smooth Effects: Highlighting temporal trends across decades.
♂️♀️ Gender Comparisons: Contrasting trends between male and female specimens.
🤝 Contributing
Contributions are welcome! Feel free to submit issues or pull requests to improve the codebase. Please follow standard GitHub contribution practices.

## 📜 License
This project is licensed under the MIT License. See the LICENSE file for details.

## 🔗 Citation
If you use this repository for your research, please cite:


