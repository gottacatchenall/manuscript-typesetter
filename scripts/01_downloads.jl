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
Downloads.download("https://www.gust.org.pl/projects/e-foundry/tex-gyre/heros/qhv2.004otf.zip", "heros.zip")
Downloads.download("https://www.gust.org.pl/projects/e-foundry/tg-math/download/texgyretermes-math-1543.zip", "termesmath.zip")
Downloads.download("https://www.gust.org.pl/projects/e-foundry/tex-gyre/termes/qtm2.004otf.zip", "termes.zip")
Downloads.download("https://www.gust.org.pl/projects/e-foundry/tex-gyre/cursor/qcr2.004otf.zip", "cursor.zip")
run(`unzip *.zip`)
run(`mkdir -p ~/.local/share/fonts`)
run(`mv texgyre* ~/.local/share/fonts`)
run(`fc-cache -vf`)
run(`rm *.zip`)
end