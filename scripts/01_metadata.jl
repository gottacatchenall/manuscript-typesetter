# We need thes packages to compile the manuscript
import Dates
import Downloads
import JSON
import Languages
import Unicode

module PrepareBibliography
    import JSON
    include(joinpath(pwd(), ".typesetter", "scripts", "metadata", "01_bibliography.jl"))
end

module PrepareAffiliations
    import JSON
    include(joinpath(pwd(), ".typesetter", "scripts", "metadata", "02_affiliations.jl"))
end

module PrepareCitationStyle
    import Downloads
    import JSON
    include(joinpath(pwd(), ".typesetter", "scripts", "metadata", "03_citationstyle.jl"))
end

module PrepareAbstract
    import JSON
    include(joinpath(pwd(), ".typesetter", "scripts", "metadata", "04_abstract.jl"))
end

module PrepareFilename
    import JSON
    import Dates
    import Languages
    import Unicode
    include(joinpath(pwd(), ".typesetter", "scripts", "metadata", "05_filename.jl"))
end

module PrepareMetadata
    import JSON
    include(joinpath(pwd(), ".typesetter", "scripts", "metadata", "06_metadata.jl"))
end