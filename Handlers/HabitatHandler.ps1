function returnHabitat {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "More detailed data regarding a Pokemon's species")] $pokemonSpeciesData
    )
    $pokemonHabitat = "Unknown"
    if (-not ($null -eq $pokemonSpeciesData.habitat)) {
        $pokemonHabitat = $TextInfo.ToTitleCase($pokemonSpeciesData.habitat.name)
    }
    return $pokemonHabitat
}