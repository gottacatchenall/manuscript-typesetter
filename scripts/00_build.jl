@info "Download the various binaries and assets"
include(joinpath(pwd(), ".typesetter", "scripts", "01_downloads.jl"))

@info "Massage the metadata into shape"
include(joinpath(pwd(), ".typesetter", "scripts", "02_metadata.jl"))

@info "Create the folders required to typeset"
include(joinpath(pwd(), ".typesetter", "scripts", "03_folders.jl"))

@info "Run!"
include(joinpath(pwd(), ".typesetter", "scripts", "04_run.jl"))