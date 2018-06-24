##############
#
# Set Up
#
##############

using DataFrames
using DataFramesMeta
using CSV
using FreqTables
cd("/users/nick/github/poli_sci_boot_camp/")

##############
#
# Read in data
#
##############

idealpoints = CSV.read("exercise_data/dwnominate.csv")

##############
#
# Clean and Re-Organize Data
#
##############

# Dataset Summary
showcols(idealpoints)

# Only need more recent congresses
idealpoints = idealpoints[idealpoints[:congress] .> 100, :]


# Check Party Code. Seems to have some weird values...
freqtable(idealpoints[:party_code])

# 100 is for dems, 200 for republicans
idealpoints[:democrat] = idealpoints[:party_code] .== 100


##############
#
# Basic Analysis
#
##############

using GLM
using RegressionTables
using FixedEffectModels
partisanship = fit(LinearModel, @formula(idealpoint_1stdimension ~ democrat), idealpoints)
idealpoints[:congress] = categorical(idealpoints[:congress])
reg1 = reg(idealpoints, @model(idealpoint_1stdimension ~ democrat))
reg2 = reg(idealpoints, @model(idealpoint_1stdimension ~ democrat, fe=congress))
regtable(reg1, reg2; renderSettings = latexOutput("computation_Julia/regression_tables/idealpoints.tex"))

##############
#
# Plots
#
##############
using Plots
