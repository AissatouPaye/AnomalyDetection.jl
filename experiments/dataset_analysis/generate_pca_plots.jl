# run as 'julia generate_tsne_plots.jl outpath [reps]'
# outpath = where plots will be stored
# reps = number of data splits to be tested

fpath = @__DIR__
include(joinpath(fpath,"utils.jl"))
using ProgressMeter
inpath = joinpath(fpath,"pca_2D-data")

# get args
outpath = ARGS[1]
datasets = readdir(inpath)
reps = ((length(ARGS)>1)? Int(parse(ARGS[2])) : 1)

# make the graphs
p = Progress(length(datasets)*reps,0.5)

for rep in 1:reps
	for dataset in datasets
		plot_general_all(dataset, inpath, "PCA", outpath, seed = rep)
		close() # so that there are no excess plots
		ProgressMeter.next!(p; showvalues = [(:dataset, dataset), (:rep, rep)])
	end
end