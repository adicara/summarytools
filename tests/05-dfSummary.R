# dfSummary.R  -----------------------------------
suppressPackageStartupMessages(library(summarytools))
st_options(tmp.img.dir = "/tmp")
options(tibble.print_max = Inf)

data(tobacco)
tobacco <- tibble::as_tibble(tobacco)

label(tobacco) <- "A Study on Tobacco Use and Health / Étude sur les effets du tabagisme"
label(tobacco$gender) <- "Subject's Gender"
label(tobacco$BMI) <- "Body Mass Index"
label(tobacco$smoker) <- "Smoking Status"
label(tobacco$samp.wgts) <- "Sampling Weights"

# Bare-bones
(dfs1 <- dfSummary(tobacco))
print(dfs1, headings = FALSE)

# Omit columns
print(dfs1, varnumbers = FALSE)
print(dfs1, labels.col = FALSE)
print(dfs1, valid.col = FALSE)
print(dfs1, na.col = FALSE)
print(dfs1, graph.col = FALSE)

# Minimal results using print overrides
print(dfs1, headings = FALSE, labels.col = FALSE, varnumbers = FALSE, valid.col = FALSE, na.col = FALSE, graph.col = FALSE)

# Print to file
print(dfs1, file = "01.html")

# Test global options (1/2)
st_options('reset')
st_options(lang = lang)
st_options(dfSummary.varnumbers = F, dfSummary.labels.col = F, dfSummary.valid.col = F)
st_options(tmp.img.dir = "/tmp")
print(dfSummary(tobacco), file = "02-basic.html")

# Test global options (2/2)
st_options(dfSummary.varnumbers = F, dfSummary.labels.col = F, dfSummary.graph.col = F, dfSummary.valid.col = F, dfSummary.na.col = F)
(dfs2 <- dfSummary(tobacco))
view(dfs2, method="browser", col.widths = c(240, 240, 240), footnote = "3 equal width cols", file = "03-equal-widths.html")

st_options('reset')
st_options(lang = lang)
st_options(tmp.img.dir = "/tmp")
st_options(footnote = "Placeholder footnote")

tobacco$disease.f <- as.factor(tobacco$disease)
(dfs3 <- dfSummary(tobacco, round.digits = 2, max.distinct.values = 4, varnumbers = FALSE, labels.col = TRUE, valid.col = FALSE, na.col = FALSE, max.string.width = 20))
print(dfs3, footnote = "4 distinct vals.", report.title = "DFS - 4 distinct values", file = "04-4-distinct-val.html")

data(cars)
(dfs4 <- dfSummary(cars))
view(dfs4, method="browser", footnote = "cars", file = "05-cars.html")

# Test special variables (ean, binary, ternary, na's, etc)
load(paste0(orig_dir, "/tests/data/special_vars.RData"))
(dfs_special <- dfSummary(special_vars))
view(dfs_special, method = "browser", file = "06-special-vars.html")

# One variable only
data(iris)
dfSummary(iris$Sepal.Length)
dfSummary(iris['Sepal.Length'])
dfSummary(iris[['Sepal.Length']])
dfSummary(iris[["Sepal.Length"]])
data("AirPassengers")
view(dfSummary(AirPassengers), file = "07-AirPassengers.html")

# subsetting
dfSummary(tobacco[1:100,])
print(dfSummary(tobacco[1:100,1:4]), footnote = "subset = [1:100, 1:4]", file = "08-tobacco-subset.html")


# round.digits and frequencies
tobacco$samp.wgts.3 <- round(tobacco$samp.wgts, 3)
tobacco$samp.wgts.3[tobacco$samp.wgts.3 == 0.861] <- 0
tobacco$samp.wgts.4 <- round(tobacco$samp.wgts, 4)
tobacco$samp.wgts.4 <- round(tobacco$samp.wgts, 1)
dfSummary(tobacco, round.digits = 2)
dfSummary(tobacco, round.digits = 3)
dfSummary(tobacco, round.digits = 4)

# st-small
print(dfSummary(tobacco, graph.magnif = 0.8), table.classes = 'st-small', footnote = "st_small", file = "09-st_small.html")

# render
print(dfSummary(tobacco), method = "render")

st_options("reset")
detach("package:summarytools")
