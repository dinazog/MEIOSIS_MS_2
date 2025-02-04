# Load Libraries
library(mgcv)
library(MASS)
library(stringr)
library(gamm4)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(viridis)
library(cowplot)
library(kableExtra)
library(knitr)
library(tibble)
library(dplyr)
library(gratia)
library(latex2exp)
library(itsadug)
library(ggdist)
library(readr)
library(tidygeocoder)
library(broom)
library(lattice)
library(lme4)
library(nlme)
library(missRanger)
library(ggeffects)
library(tidyverse)       # Tidy and flexible data manipulation
library(marginaleffects) # Compute conditional and marginal effects
library(patchwork)       # Combining ggplot objects
library(ggcorrplot)

# Load Data
setwd("H:/My Drive/Greece/A_ELIDEK_mine/WP3_DATA ANALYSIS/Output2/FIN_dfs/")
df <- read.table(file = "newdf_Periods_STI_grids_alltraits.csv", sep = ",", header = TRUE)

# Select Variables
df <- df[c("length_cor", "right_wing_span", "tmax_wc", "tmax_chelsa", 
           "Vol_mean", "Year", "FFM", "LFM", "Vol_min", "BIOME",
           "STI", "range.size", "Vol_max", "GenusSpecies", 
           "Elevation", "HPS", "TrC", "HSI",
           "FMo_Min", "FMo_Max", "FMo_Average", "Family",
           "urban", "SumPastures", "SumCrops", "SumForests",
           "Per1_chel","Per2_chel")]

# Filter Data by Year
df <- df[df$Year >= 1850 & df$Year <= 2010, ]

# Fix Variable Formats
df$BIOME <- as.factor(df$BIOME)
df$GenusSpecies <- as.factor(df$GenusSpecies)
df$Family <- as.factor(df$Family)

# Log Transformation
df$length_cor <- log(df$length_cor)

# Impute Missing Values
impute_vars <- c("FFM", "Vol_min", "STI", "range.size",
                 "Per1_chel", "Per2_chel", 
                 "Vol_max", "Elevation",
                 "tmax_chelsa", "Vol_mean",
                 "HSI", "FMo_Average")

for (var in impute_vars) {
  df <- missRanger(df, formula(paste(var, "~ GenusSpecies + ", var)), pmm.k = 2,
                   num.trees = 100, case.weights = rowSums(!is.na(df)))
}

# Standardization of the Data
numeric_vars <- c("Year", "length_cor", "right_wing_span",
                  "urban", "SumPastures", 
                  "SumForests", "SumCrops",
                  "Vol_min", "Vol_max",
                  "FFM", "Elevation",
                  "Per1_chel","STI","range.size",
                  "Per2_chel","tmax_wc","tmax_chelsa","Vol_mean","HSI","FMo_Average")

df[numeric_vars] <- lapply(df[numeric_vars], scale)



# # Model 1: GAM ----------------------------------------------------------
model_gam <- bam(length_cor ~ s(Year, k=5) + FFM + STI + Vol_mean + 
                   range.size + HSI + FMo_Max + OvS +
                   SumPastures + SumForests + SumCrops + urban +
                   Per1_chel + Per2_chel +
                   s(GenusSpecies, bs="re"),
                 data=df, method="REML")
summary(model_gam)

# Model Diagnostics
gam.check(model_gam)

# Plotting Parametric Effects
p <- parametric_effects(model_gam, 
                        terms=c("FFM", "Vol_mean", 
                                "STI", "FMo_Max",
                                "SumForests", 
                                "SumPastures",
                                "Per1_chel", 
                                "Per2_chel"))
plots <- draw(p, ci_level = 0.95, ci_col = "black",
              ci_alpha = 0.1,
              line_col = "black")

combined_plot <- wrap_plots(plots) + 
  plot_annotation(title = "Important Parametric Effects") +
  theme(plot.title = element_text(hjust = 0.5))

print(combined_plot)


# Plot only parametric terms
p <- parametric_effects(model_sex, 
                        terms=c("FFM", "Vol_mean", "STI", "FMo_Max",
                                "SumForests", "SumPastures", 
                                "Per1_chel", "Per2_chel"))
plots <- draw(p, ci_level = 0.95, ci_col = "black",
              ci_alpha = 0.1,
              line_col = "black", rug = TRUE)

new_x_labels <- c("First Flight Month", "Flight period",
                  "Temperature (Period 1)", "Temperature (Period 2)",
                  "Species Temperature Index", "Forest cover", 
                  "Pasture cover", "Generation number")

# Update each plot's x-axis label and ensure no titles are added
for (i in seq_along(plots)) {
  plots[[i]] <- plots[[i]] + labs(x = new_x_labels[i]) +
    theme(plot.title = element_blank())  # Remove titles if any exist
}

# Combine all plots into one if desired (optional)
combined_plot_sex <- wrap_plots(plots) + 
  plot_annotation(title = "Important Parametric Effects by Sex") +
  theme(plot.title = element_text(hjust = 0.5))

# Print the combined plot
print(combined_plot_sex)



# Model with Gender-----------------------------------------------------------------
df$Sex <- relevel(df$Sex, ref = "Male")
#This sets "Male" as the reference level
#and "Female" will now be the comparison level


model_sex <- bam(length_cor ~ s(Year, by=Sex, bs="tp", k=5) + FFM + STI + Vol_mean + 
                   range.size+ HSI + FMo_Max  +OvS
                 +urban + SumForests 
                 + SumPastures + SumCrops + Per1_chel+ Per2_chel+
                   s(GenusSpecies, bs="re"),
                 data=df, method="REML")
summary(model_sex)

# Extract parametric terms
param_terms <- summary(model_sex)$p.table
# Plot the intercept (reference level)
barplot(param_terms[, "Estimate"], names.arg = rownames(param_terms), col = "lightblue",
        main = "Parametric Terms", ylab = "Estimates")
abline(h = 0, col = "red", lty = 2)


draw(model_sex, parametric = TRUE)


#checking traits model
gam.check (model_sex)
#Model diagnostics 
appraise(model_sex, method = "simulate")


#Plot only parametric terms
p <- parametric_effects(model_sex, 
                        terms=c("FFM", "FMo_Max", "STI", "Vol_mean",
                                "SumForests", "SumPastures"))
draw(p, ci_level = 0.95, ci_col = "black",
     ci_alpha = 0.1,
     line_col = "black", rug = TRUE)

#plots only key parametric terms
p <- parametric_effects(model_sex, 
                        terms=c("FFM", "FMo_Max", "STI", "Vol_mean",
                                "SumForests", "SumPastures"))
plots <- draw(p, ci_level = 0.95, ci_col = "black",
              ci_alpha = 0.1,
              line_col = "black", rug = TRUE)

new_x_labels <- c("First Flight Month","Flight period", "Species Temperature Index",
                  "Forest cover","Pasture cover","Generation number")

# Update each plot's x-axis label and ensure no titles are added
for (i in seq_along(plots)) {
  plots[[i]] <- plots[[i]] + labs(x = new_x_labels[i]) +
    theme(plot.title = element_blank())  # Remove titles if any exist
}

# Combine all plots into one if desired (optional)
library(patchwork)  # Load patchwork if you want to combine plots
combined_plot <- wrap_plots(plots) + 
  plot_annotation(title = "Important Parametric Effects") +
  theme(plot.title = element_text(hjust = 0.5))

# Print the combined plot
print(combined_plot)

#for factor plotting
library(visreg)
visreg(model_sex, xvar = "Year",
       by = "OvS", data = df,
       method = "REML")


plot_predictions(model_sex, condition = 'Sex', 
                 type = 'response', points = 0.1,
                 rug = TRUE) +
  labs(y = "Expected response",
       title = "Average smooth effect of Year")

#split prediction per Gender
plot_predictions(model_sex, condition = c('Year', 'OvS'),
                 type = 'link') +
  labs(y = "Linear predictor (link scale)",
       title = "Average smooth effect of Year",
       subtitle = "Per Gender")

itsadug::plot_smooth(model_sex, view="Year", plot_all=c("OvS"), rm.ranef=T, sim.ci = T,
                     main = "Year Response by Gender",ylab = "Predicted wing length",
                     n.grid = length(unique(df$Year)),
                     hide.label = F, legend_plot_all = "topright",
                     col = c("firebrick2", "dodgerblue3"),
                     lwd = 3, shade= T,
                     v0 = c(0))

plot_slopes(model_sex, variables = 'Year',
            condition = c('Year', 'Sex'),
            type = 'response') +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(y = "1st derivative of the linear predictor",
       title = "Conditional slope of the gender effect")


#Comparing difference between Sex
wald_gam(model_sex)
wald_gam(model_sex, comp=list(Sex=levels(df$Sex)))

library(itsadug)
diff <- get_difference(model_sex, comp=list(Sex=c("Female", "Male" )), 
                       cond=list(Year =seq(1900,2010,length=100)))
plot_diff(model_sex, view="Year", comp=list(Sex=c("Female", "Male")), 
          n.grid = length(unique(df$Year)),rm.ranef=FALSE)



smooths(model_sex)
sm1 <- smooth_estimates(model_sex, smooth = "s(Year):SexFemale")
sm2 <- smooth_estimates(model_sex, smooth = "s(Year):SexMale")


#Plot for females
plotF <- sm1 |>
  add_confint() |>
  ggplot(aes(y = .estimate, x = Year)) +
  geom_ribbon(aes(ymin = .lower_ci, ymax = .upper_ci),
              alpha = 0.2, fill = "forestgreen"
  ) +
  geom_line(colour = "forestgreen", linewidth = 1) +
  labs(
    y = "Partial effect", title = "a) Females",
    subtitle = expression("Partial effect of" ~ f(Year[i])),
    x = expression(Year[i])
  ) +
  geom_hline(yintercept = 0, linetype = 'dashed', colour = 'black', linewidth =0.5) +
  geom_vline(xintercept = c(1935, 1975), colour = 'red4', linetype = 'dashed',linewidth = 0.01) +
  theme(axis.title.x = element_text(size = 14), 
        axis.title.y = element_text(size = 14)) +
  theme (axis.text.x = element_text(size = 11),
         axis.text.y = element_text(size = 11))


#Plot for males
plotM <- sm2 |>
  add_confint() |>
  ggplot(aes(y = .estimate, x = Year)) +
  geom_ribbon(aes(ymin = .lower_ci, ymax = .upper_ci),
              alpha = 0.2, fill = "red1"
  ) +
  geom_line(colour = "red1", linewidth = 1) +
  labs(
    y = "Partial effect", title = "b) Males",
    subtitle = expression("Partial effect of" ~ f(Year[i])),
    x = expression(Year[i])
  ) +
  geom_hline(yintercept = 0, linetype = 'dashed', colour = 'black', linewidth =0.5) +
  geom_vline(xintercept = c(1950), colour = 'red4', linetype = 'dashed',linewidth = 0.01) +
  theme(axis.title.x = element_text(size = 14), 
        axis.title.y = element_text(size = 14)) +
  theme (axis.text.x = element_text(size = 11),
         axis.text.y = element_text(size = 11))


library(cowplot)
plot_grid(plotF, plotM)


