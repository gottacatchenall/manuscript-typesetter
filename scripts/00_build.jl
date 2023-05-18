@info "Download the various binaries and assets"
#include(joinpath(pwd(), "scripts", "01_downloads.jl"))

run(`cp -r ../figures .`)

@info "Massage the metadata into shape"
include(joinpath(pwd(), "scripts", "02_metadata.jl"))

@info "Create the folders required to typeset"
include(joinpath(pwd(), "scripts", "03_folders.jl"))

@info "Run!"
include(joinpath(pwd(), "scripts", "04_run.jl"))
