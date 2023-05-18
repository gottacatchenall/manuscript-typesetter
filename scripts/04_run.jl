module BuildCoreStuff
import JSON
metadata = JSON.parsefile(joinpath(pwd(), "manuscript-metadata.json"))
_common_options = `-F pandoc-crossref --citeproc --bibliography=references.json --csl citationstyle.csl --metadata-file=manuscript-metadata.json`

_pandoc = `./pandoc-2.19.2/bin/pandoc`

@info "Build the preprint"
run(
    `$(_pandoc) ../README.md -s -o dist/$(metadata["filename"])_preprint.pdf --pdf-engine ./tectonic $(_common_options) --template=templates/preprint.tex`,
)

@info "Build the draft"
run(
    `$(_pandoc) ../README.md -s -o dist/$(metadata["filename"])_draft.pdf $(_common_options) --pdf-engine ./tectonic --template=templates/draft.tex`,
)

@info "Build the opendocument file"
run(
    `$(_pandoc) ../README.md -s -o dist/$(metadata["filename"]).odt $(_common_options) --template=templates/default.opendocument`,
)

@info "Build the website"
run(
    `$(_pandoc) ../README.md -o dist/index.html $(_common_options) --template=templates/index.html`,
)

@info "Build the raw file"
run(
    `$(_pandoc) ../README.md -o dist/rawtext.txt $(_common_options) -M suppress-bibliography=true`,
)

function sm_name_from_path(p)
    sm = replace(p, "../appendix/" => "")
    sm = replace(sm, ".md" => "")
    return sm
end

possible_suppmat = readdir("../appendix"; join = true)
filter!(f -> endswith(f, ".md"), possible_suppmat)
for sm in possible_suppmat
    sm = sm_name_from_path(sm)    
    @info "Build the supp. mat. $(sm)"
    run(
        `$(_pandoc) ../appendix/$(sm).md -s -o dist/appendix/$(metadata["filename"])_$(sm).pdf --pdf-engine ./tectonic $(_common_options) --template=templates/appendix.tex`,
    )
end

end
