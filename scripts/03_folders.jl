ispath("dist") || mkpath("dist")
ispath("dist/appendix") || mkpath("dist/appendix")
if ispath("figures")
    cp("figures", "dist/figures"; force=true)
end
cp("logo.png", "dist/logo.png"; force=true)
cp("references.json", "dist/references.json"; force=true)
