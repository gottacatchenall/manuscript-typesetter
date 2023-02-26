module GetCrossrefFilter
import Downloads
crossref_url = "https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.14.0/pandoc-crossref-Linux.tar.xz"
cref_tar = Downloads.download(crossref_url, "pandoc-crossref.tar.xz")
run(`tar -xf pandoc-crossref.tar.xz`)
run(`chmod +x pandoc-crossref`)
rm("pandoc-crossref.tar.xz")
end

module BuildCoreStuff
import JSON
metadata = JSON.parsefile(joinpath(pwd(), "manuscript-metadata.json"))
_common_options = `-F pandoc-crossref --citeproc --bibliography=references.json --csl .typesetter/citationstyle.csl --metadata-file=manuscript-metadata.json`
run(
    `pandoc README.md -s -o dist/$(metadata["filename"])_preprint.pdf --pdf-engine tectonic $(_common_options) --template=.typesetter/templates/preprint.tex`,
)
run(
    `pandoc README.md -s -o dist/$(metadata["filename"])_draft.pdf $(_common_options) --pdf-engine tectonic --template=.typesetter/templates/draft.tex`,
)
run(
    `pandoc README.md -s -o dist/$(metadata["filename"]).odt $(_common_options) --template=.typesetter/templates/default.opendocument`,
)
run(
    `pandoc README.md -o dist/index.html $(_common_options) --template=.typesetter/templates/index.html`,
)
run(
    `pandoc README.md -s -o dist/rawtext.txt $(_common_options) -M suppress-bibliography=true`,
)

possible_suppmat = readdir("appendix"; join = true)
filter!(f -> endswith(f, ".md"), possible_suppmat)
for sm in possible_suppmat
    sm = replace(sm, "appendix/" => "")
    sm = replace(sm, ".md" => "")
    run(
        `pandoc appendix/$(sm).md -s -o dist/appendix/$(metadata["filename"])_$(sm).pdf --pdf-engine tectonic $(_common_options) --template=.typesetter/templates/appendix.tex`,
    )
end

end