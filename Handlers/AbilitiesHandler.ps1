function returnAbilities {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Main data of the Pokemon")] $pokemonBaseData
    )
    $pokemonAbilities
    $pokemonAbilitiesCount = 0;
    foreach ($item in $pokemonBaseData.abilities) {
        $pokemonAbilitiesCount++
        if ($pokemonAbilitiesCount -eq $pokemonBaseData.abilities.Length) {
            $pokemonAbilities += $item.ability.name
        } else {
            $pokemonAbilities = $pokemonAbilities + $item.ability.name + ", "
        }
    }
    return $pokemonAbilities
}