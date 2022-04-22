function returnEvolutionChain {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Evolution of pokemon")] $pokemonEvolutionData
    )
    
    $pokemonEvolutionChain
    $evolutions = $pokemonEvolutionData.chain.evolves_to

    if (-not($evolutions.Length -eq 0)) {
        #Handles evolution branching if base pokemon has two possible evolutions that then evolve.
        #It checks for how many evolutions the base has AND if any of those also evolve.
        #(ex: Wurmple to Cascoon OR Silcoon. Then Cascoon to Dustox AND Silcoon to Beautifly.)

        if (($evolutions.Length -gt 1 ) -and ([Linq.Enumerable]::Any([string[]]$evolutions.evolves_to.Length, [Func[string,bool]]{ $args[0] -gt 0 })) ) {
            foreach ($item in $evolutions) {
                $evolvesFrom = $TextInfo.ToTitleCase($pokemonEvolutionData.chain.species.name)
                $evolvesTo = $TextInfo.ToTitleCase($item.Species.Name)
                $pokemonEvolutionChain += "$evolvesFrom ===> $evolvesTo "
                foreach ($i in $item.Evolves_To) {
                    $evolvesToNext = $TextInfo.ToTitleCase($i.Species.Name)
                    $pokemonEvolutionChain += "===> $evolvesToNext<br>"
                }
            }
        } else {
            #Handles evolution branching if there are no more evolutions after the branch
            #ex: Slowpoke to Slowbro OR Slowking; Poliwag to Poliwhirl to Poliwrath OR Politoad.
            #Allows pokemon like Eevee that do not evolve again to be formatted easily.
            $evolvesFrom = $TextInfo.ToTitleCase($pokemonEvolutionData.chain.species.name)
            $pokemonEvolutionChain = "$evolvesFrom ===> "
            foreach ($item in $evolutions) {
                $evolvesTo = $TextInfo.ToTitleCase($item.Species.Name)  + " "
                $pokemonEvolutionChain += $evolvesTo
                if (-not($item.Evolves_To.Length -eq 0)) {
                    $complexEvolution = "===> "
                    $count = 0;
                    foreach ($i in $item.Evolves_To) {
                        $count++
                        $evolvesToNext = $TextInfo.ToTitleCase($i.Species.Name)
                        if ($count -eq $item.Evolves_To.Length) {
                            $complexEvolution += "$evolvesToNext "
                        } else {
                            $complexEvolution += "$evolvesToNext, "
                        }
                    }
                    $pokemonEvolutionChain += $complexEvolution;
                }
            }
        }
    }
    return $pokemonEvolutionChain
}