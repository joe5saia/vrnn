###################################################################################################
#=
Trains a variational reccurent autoeconding neural net to fill in missing values in compustat data
Adapted from https://arxiv.org/abs/1506.02216
=#
###################################################################################################
using DataFrames, CSV, Flux, Revise, Distributions, LinearAlgebra, Random, LoopVectorization, FixedEffectModels
using BSON: @save, @load

include("vrnn_helper.jl")


train_data = makedata(;backward=false)
x = train_data[1]
y = train_data[2]
# Constructing Model
nx = size(train_data[1][1],1)
args = Args(x_dim = nx, y_dim = nx, h_dim = nx ÷ 2, z_dim = 3)

#modf, args, opt = load_mod("vaemods/model_back=false.bson")
model = trainmod(args, nothing, nothing; backward = false)