metadata = JSON.parsefile(joinpath(pwd(), "metadata.json"))

delete!(metadata, "abstract")
abstract = JSON.parsefile(joinpath(pwd(), "abstract.json"))
metadata["abstract"] = abstract

delete!(metadata, "authors")
affiliations = JSON.parsefile(joinpath(pwd(), "affiliations.json"))
metadata["authors"] = affiliations["authors"]
metadata["authorship"] = affiliations["metadata"]
metadata["institutions"] = affiliations["institutions"]

metadata["filename"] = JSON.parsefile(joinpath(pwd(), "filename.json"))["filename"]

# Get the supp. mat.
function sm_name_from_path(p)
    sm = replace(p, "appendix/" => "")
    sm = replace(sm, ".md" => "")
    return sm
end

possible_suppmat = readdir("appendix"; join = true)
filter!(f -> endswith(f, ".md"), possible_suppmat)

if ~isempty(possible_suppmat)
    SM = []
    for suppmat in possible_suppmat
        sm_text = readlines(suppmat)
        title_line = findfirst(l -> startswith(l, "name: "), sm_text)
        title = replace(sm_text[title_line], "name: " => "")
        order_line = findfirst(l -> startswith(l, "order: "), sm_text)
        order = parse(Int, replace(sm_text[order_line], "order: " => ""))
        push!(SM, Dict("order" => order, "title" => title, "url" => "appendix/$(metadata["filename"])_$(sm_name_from_path(suppmat)).pdf"))
    end
    metadata["appendix"] = SM
end


# Write the file
open("manuscript-metadata.json", "w") do json_file
    return JSON.print(json_file, metadata, 4)
end

rm("filename.json")
rm("abstract.json")
rm("affiliations.json")