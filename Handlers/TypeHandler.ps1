function returnTypes {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Main data of the Pokemon")] $pokemonBaseData
    )
    $pokemonType = $TextInfo.ToTitleCase($pokemonBaseData.types[0].type.name)
    if ($pokemonBaseData.types.Length -gt 1) {
        $pokemonType = $pokemonType + " / " + $TextInfo.ToTitleCase($pokemonBaseData.types[1].type.name)
    }
    return $pokemonType
}
