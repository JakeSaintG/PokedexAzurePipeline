param (
    [Parameter(Mandatory = $true, HelpMessage = "name of pokemon")] [string] $pokemonName,
    #Set to true if this is being run manually. DO NOT FORGET TO SET TO FALSE BEFORE PUSHING
    [Parameter(Mandatory = $false, HelpMessage = "Is manual script")] [bool] $manualScript = $false 
)

function CreatePokedexEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "name of pokemon")] [string] $name,
        [Parameter(Mandatory = $false, HelpMessage = "Is manual script")] [bool] $manual = $false 
    )
    $TextInfo = (Get-Culture).TextInfo
    $WorkSpace = (Get-Location).path;
    $modules = @( Get-ChildItem -Path "$WorkSpace\Handlers\*" -Filter *.ps1 -ErrorAction SilentlyContinue );
    if ($modules) { Import-Module $modules -Force -Global };

    # $getPokemonList = Invoke-RestMethod -uri "https://pokeapi.co/api/v2/pokemon?limit=1283"
    # $fullListOfPokemon = $getPokemonList.results.name
    $pokemonBaseData = Invoke-RestMethod -uri "https://pokeapi.co/api/v2/pokemon/$pokemonName"
    $pokemonSpeciesData = Invoke-RestMethod -uri $pokemonBaseData.Species.Url
    $pokemonEvolutionData = Invoke-RestMethod -uri $pokemonSpeciesData.Evolution_Chain.Url    

    $pokemonImage = $pokemonBaseData.sprites.front_default
    $pokemonShinyImage = $pokemonBaseData.sprites.front_shiny
    $pokemonType = returnTypes -pokemonBaseData $pokemonBaseData
    $pokemonHeight = $pokemonBaseData.height / 10
    $pokemonWeight = $pokemonBaseData.weight / 10
    $pokemonColor = $TextInfo.ToTitleCase($pokemonSpeciesData.color.name)
    $pokemonHabitat = returnHabitat -pokemonSpeciesData $pokemonSpeciesData
    $pokemonAbilities = returnAbilities -pokemonBaseData $pokemonBaseData
    $pokemonDescription = returnDescription -pokemonSpeciesData $pokemonSpeciesData
    $pokemonEvolutionChain = returnEvolutionChain -pokemonEvolutionData $pokemonEvolutionData
    WriteFile -manualScript $manualScript -pokemonName $pokemonName -pokemonImage $pokemonImage -pokemonShinyImage $pokemonShinyImage -pokemonType $pokemonType -pokemonHeight $pokemonHeight -pokemonWeight $pokemonWeight -pokemonColor $pokemonColor -pokemonHabitat $pokemonHabitat -pokemonAbilities $pokemonAbilities -pokemonDescription $pokemonDescription -pokemonEvolutionChain $pokemonEvolutionChain
}

CreatePokedexEntry -name $pokemonName -manual $manualScript