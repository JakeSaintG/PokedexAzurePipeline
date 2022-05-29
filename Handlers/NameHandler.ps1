function returnEditedName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Main data of the Pokemon")] $pokemonName
    )
    $pokemonName = $pokemonName.ToLower();

    $filterTable = @{
        @( "jr", "" ) = "mime-jr";
        @( "farfet", "-galar" ) = "farfetchd-galar";
        @( "farfet", "" ) = "farfetchd";
        @( "pumpkaboo", "" ) = "pumpkaboo-average";
        @( "gourgeist", "" ) = "gourgeist-average";
        @( "rime", "mr" ) = "mr-rime";
        @( "porygon", "2" ) = "porygon2";
        @( "porygon", "z" ) = "porygon-z";
        @( "type", "null" ) = "type-null";
        @( "ho", "oh" ) = "ho-oh";
        @( "mime", "-galar" ) = "mr-mime-galar";
        @( "mime", "mr" ) = "mr-mime"
    };

    $counter = 0;

    $filterTable.GetEnumerator() | ForEach-Object {

        if ($pokemonName.Contains($_.key[0]) -and $pokemonName.Contains($_.key[1]))
        {
            $pokemonName = $_.value
        }
        else
        {
            $counter++;
        }
    }
    return $pokemonName;
}