#===========================================================================
#  ?                                ABOUT
#  @author         :  tauseed zaman
#  @description    :  this script will extract words from a text file that start with the specified prefixes and save them to a CSV file.
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