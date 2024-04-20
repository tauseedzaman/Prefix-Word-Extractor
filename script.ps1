#===========================================================================
#  ?                                ABOUT
#  @author         :  tauseedzaman
#  @email          :  tauseedzaman@pm.me    
#  @createdOn      :  10/02/2024
#  @description    :  PrefixWordExtractor is a PowerShell script that extracts words from a text file which start with predefined prefixes like 'KN', 'HS', 'CI', 'LN', and 'PR', and exports them into a CSV file named "output.csv". It validates the existence of the source text file, reads its content, filters out words based on specified prefixes, and saves the results in a CSV format for further analysis or processing.
#===========================================================================

$SOURCE_TXT_FILE_PATH = "./Exfile.txt"
$OUTPUT_CSV_FILE_PATH = "./output.csv"
$PREFIXES = 'KN', 'HS', 'CI', 'LN', 'PR'


# chekc if text file is valid other wise show error
if (-not (Test-Path "$SOURCE_TXT_FILE_PATH")) {
    Write-Host "The specified text file does not exist."
    exit
}


# Read the content of the text file
$fileContent = Get-Content -Path "$SOURCE_TXT_FILE_PATH" -Raw

# Initialize an empty array to store extracted words
$words = @()

# Use a regular expression to capture words that start with the specified prefixes
$prefixPattern = ($PREFIXES -join '|')
$potentialWords = [regex]::Matches($fileContent, "($prefixPattern)\w+")

# Filter out the captured words
foreach ($potentialWord in $potentialWords) {
    $words += [PSCustomObject]@{
        Word = $potentialWord.Value
    }
}

# Export the extracted words to a CSV file
$words | Export-Csv -Path "$OUTPUT_CSV_FILE_PATH" -NoTypeInformation

Write-Host "Words extracted from text file and saved to CSV successfully."
