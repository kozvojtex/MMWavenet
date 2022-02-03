
using Pickle
using BSON

mal_path = "/largeandslow/kozel/dataset/malwares/"
clean_path = "/largeandslow/kozel/dataset/cleanwares/"

function make_dataset(path::String)
    names::Array{String} = readdir(path)
    dataset::Array{Float64, 3} = zeros(15, 1024, 1)
    for name::String in names
        d::Matrix{Float64} = hcat(Pickle.load(open(join([path, name])))...)
        dataset = cat(dataset, d; dims=3)
    end
    return dataset[:,:,2:end];
end

malwares = make_dataset(mal_path)
cleanwares = make_dataset(clean_path)

bson("/largeandslow/kozel/dataset/dataset.bson", m = malwares, c = cleanwares)