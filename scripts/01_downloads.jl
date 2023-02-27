module GetCrossrefFilter
import Downloads
crossref_url = "https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.14.0/pandoc-crossref-Linux.tar.xz"
cref_tar = Downloads.download(crossref_url, "pandoc-crossref.tar.xz")
run(`tar -xf pandoc-crossref.tar.xz`)
run(`chmod +x pandoc-crossref`)
rm("pandoc-crossref.tar.xz")
end

module GetPandocBinary
import Downloads
pandoc_url = "https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-linux-amd64.tar.gz"
pdoc_tar = Downloads.download(pandoc_url, "pandoc.tar.gz")
run(`tar -xvzf pandoc.tar.gz`)
run(`chmod +x pandoc-2.19.2/bin/pandoc`)
rm("pandoc.tar.gz")
end

module GetTectonic
import Downloads
tecfile = Downloads.download("https://drop-sh.fullyjustified.net", "tectonic.sh")
run(`chmod +x tectonic.sh`)
run(`./tectonic.sh`)
end

module GetFonts
import Downloads
Downloads.download(
    "https://www.gust.org.pl/projects/e-foundry/tex-gyre/heros/qhv2.004otf.zip",
    "heros.zip",
)
Downloads.download(
    "https://www.gust.org.pl/projects/e-foundry/tg-math/download/texgyretermes-math-1543.zip",
    "termesmath.zip",
)
Downloads.download(
    "https://www.gust.org.pl/projects/e-foundry/tex-gyre/termes/qtm2.004otf.zip",
    "termes.zip",
)
Downloads.download(
    "https://www.gust.org.pl/projects/e-foundry/tex-gyre/cursor/qcr2.004otf.zip",
    "cursor.zip",
)

_fonts_dir = joinpath(homedir(), ".local", "share", "fonts", "TeXGyre")
run(`mkdir -p $(_fonts_dir)`)

run(`unzip heros.zip`)
run(`unzip termes.zip`)
run(`unzip cursor.zip`)
run(`unzip termesmath.zip`)
mv("texgyretermes-math-1543/opentype/texgyretermes-math.otf", "texgyretermes-math.otf")

_fonts = filter!(f -> endswith(f, ".otf"), filter!(isfile, readdir()))
for _font in _fonts
    fname = last(splitpath(_font))
    mv(_font, joinpath(_fonts_dir, fname); force = true)
end

run(`fc-cache -vf`)
run(`rm heros.zip`)
run(`rm termes.zip`)
run(`rm termesmath.zip`)
run(`rm cursor.zip`)
run(`rm -r texgyretermes-math-1543`)
end

module GetJuliaMono
import Downloads
Downloads.download(
    "https://github.com/cormullion/juliamono/releases/download/v0.048/JuliaMono.zip",
    "JuliaMono.zip",
)

run(`unzip JuliaMono.zip`)
run(`rm -r webfonts`)

_fonts_dir = joinpath(homedir(), ".local", "share", "fonts", "JuliaMono")
run(`mkdir -p $(_fonts_dir)`)

_fonts = filter!(f -> endswith(f, ".ttf"), filter!(isfile, readdir()))
for _font in _fonts
    fname = last(splitpath(_font))
    mv(_font, joinpath(_fonts_dir, fname); force = true)
end

run(`fc-cache -vf`)
run(`rm JuliaMono.zip`)

end