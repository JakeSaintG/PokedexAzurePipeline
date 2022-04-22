function EditHTML {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)] [string] $html,
        [Parameter(Mandatory = $false)] [string] $nameOfPokemonFile,
        [Parameter(Mandatory = $false)] [boolean] $resetHtml = $False
    )

    if ($resetHtml) {
        Clear-Content -Path "Entries/$nameOfPokemonFile.html"
    } else {
        Add-Content -Path "Entries/$nameOfPokemonFile.html" -Value "$html"
    }
}

function WriteFile {
    param (
        [Parameter(Mandatory = $true, HelpMessage = "name of pokemon")] $pokemonName,
        [Parameter(Mandatory = $true, HelpMessage = "Pokemon's regular sprite")] $pokemonImage,
        [Parameter(Mandatory = $true, HelpMessage = "Pokemon's shiny sprite")] $pokemonShinyImage,
        [Parameter(Mandatory = $true, HelpMessage = "Pokemon type(s)")] $pokemonType,
        [Parameter(Mandatory = $true, HelpMessage = "Pokemon's height in meters")] $pokemonHeight,
        [Parameter(Mandatory = $true, HelpMessage = "Pokemon's mass in Kg")] $pokemonWeight,
        [Parameter(Mandatory = $true, HelpMessage = "Pokemon color")] $pokemonColor,
        [Parameter(Mandatory = $true, HelpMessage = "Pokemon's habitiat")] $pokemonHabitat,
        [Parameter(Mandatory = $true, HelpMessage = "Abilities of the pokemon")] $pokemonAbilities,
        [Parameter(Mandatory = $true, HelpMessage = "Main Pokedex entry")] $pokemonDescription,
        [Parameter(Mandatory = $true, HelpMessage = "Pokemon evolution chain")] $pokemonEvolutionChain,
        [Parameter(Mandatory = $true, HelpMessage = "Is the script being run manually?")] $manualScript
    )

    $pokemonDisplayName = $TextInfo.ToTitleCase($pokemonName)

    if ($manualScript) {
        if (-not (Test-Path "Entries" -PathType Container)) {
            New-Item -Path "." -Name "Entries" -ItemType "directory"
        }
        if (Test-Path "Entries/$pokemonName.html" -PathType Leaf) {
            EditHTML -resetHtml $true -nameOfPokemonFile $pokemonName
        }
    } else {
        New-Item -Path "." -Name "Entries" -ItemType "directory"
    }

    EditHTML -nameOfPokemonFile $pokemonName -html @"
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pokedex Entry</title>
        <style type='text/css'>
            *{
                box-sizing: border-box;
            }
            html,
            body {
                height: 100vh;
                margin: 0;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
            main {
                width: 600px;
                margin: 0 auto;
                border: 1px solid black;
            }
            .entry {
                display: flex;
                justify-content: center;
                border-top: 1px solid black;
                border-bottom: 1px solid black;
            }
            .images {
                display: flex;
                flex-direction: column;
                border-right: 1px solid black;
            }
            .details {
                width: 400px;
            }
            ul {
                margin: 0;
                padding: 0;
            }
            li {
                list-style: none;
            }
            h1 {
                text-align: center;
            }
            
            h2, p {
                margin: 0;
                padding: 4px 0;
                border-bottom: 1px solid black;
            }
        </style>
    </head>
    <body>
        <main>
            <h1>$pokemonDisplayName</h1>
            <div class="entry">
                <div class="images">
                    <img src="$pokemonImage" alt="Image of $pokemonDisplayName" width="200" height="200">
                    <img src="$pokemonShinyImage" alt="Image of shiny $pokemonDisplayName" width="200" height="200">
                </div>
                <div class="details">
                    <ul>
                        <li>
                            <h2>Type:</h2>
                            <p>$pokemonType</p>
                        </li>
                        <li>
                            <h2>Size:</h2>
                            <p>Ht: $pokemonHeight M; Wt: $pokemonWeight Kg</p>
                        </li>
                        <li>
                            <h2>Color:</h2>
                            <p>$pokemonColor</p>
                        </li>
                        <li>
                            <h2>Habitat:</h2>
                            <p>$pokemonHabitat</p>
                        </li>
                        <li>
                            <h2>Abilities:</h2>
                            <p>$pokemonAbilities</p>
                        </li>
                        <li>
                            <h2>Description:</h2>
                            <p>$pokemonDescription</p>
                        </li>
                    </ul>  
                </div>
            </div>
            <div class="evoChain">
                <h2>Evolution Chain:</h2>
                <p>$pokemonEvolutionChain</p> 
            </div>
        </main>
    </body>
"@
}