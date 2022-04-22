function returnDescription {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "More detailed data regarding a Pokemon's species")] $pokemonSpeciesData
    )

    $filterDescriptionByLanguage = @()
    foreach ($item in $pokemonSpeciesData.flavor_text_entries) {
        if ($item.language.name -eq "en") {
            $filterDescriptionByLanguage += $item
        }
    }
    $pokemonDescription = $filterDescriptionByLanguage[0].flavor_text
    $specialDescriptionForms =  @("-galar", "-alola", "-gmax", "-mega", "rotom", "-black", "-white")
    foreach ($item in $specialDescriptionForms) {
        if ($pokemonName.Contains($item)) {
            $homebrewDSC = Get-Content .\Assets\descriptionExceptions.json | ConvertFrom-Json
            foreach ($form in $homebrewDSC.special_forms) {
                if ($form.name -eq $pokemonName) {
                    $pokemonDescription = $form.fixed_description
                }
            }
        }
    }
    return $pokemonDescription
}