# MEIOSIS_MS_2
## Second manuscript for MEIOSIS project
Summary: Because of its close ties to numerous ecological and life history characteristics, body size is regarded as one of an organism's most important characteristics and is frequently considered a significant indicator of fitness. According to recent studies, ectotherms in particular, may see a reduction in body size with rising temperatures. How life history and ecological traits influence, however, shifts in butterfly body size in response to environmental changes, particularly focusing on the effects of temperature and land use is poorly studied. Using Generalized Additive Models (GAM), we analyzed forewing length data alongside various life history (phenology, overwintering developmental stage, voltinism, diet breadth, gender) and ecological traits (mobility, thermal tolerance) as well as environmental parameters for a period that lasts 110 years. Smaller body sizes were linked to early-season emergence and increasing forest cover, while larger sizes were linked to longer flight durations and later seasonal appearance. Males exhibited a pronounced decline in body size while females showed an opposite trend, suggesting sex-specific vulnerabilities to climate change. This research highlights the complex interplay between climate change, habitat fragmentation, and butterfly morphology, emphasizing the need for further investigation into sexual size dimorphism as anthropogenic influences continue to reshape butterfly populations.
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


