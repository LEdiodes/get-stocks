## Powershell script called "Get-Stocks.ps1" which takes the US stock quote or a text file contains newline delimited list of stock tickers like
## -File stocklist.txt where stocklist.txt contains a newline delimited list of stock tickers like:
## AAPL
## IBM
## SAP
## The script will then return the stock name and the most recent stock price from Yahoo! Finance.
## Author: Triphol "Pao" Nilkuha
## Email: tnilkuha@gmail.com
## Date: 28 Mar 2016
## Development Env: PowerShell 5.0 on MS Windows 10.



# take stock symbol from command line and pass an argument -File for a text file contains a newline delimited list of stock symbols.
param(
     [string] $symbol,
     [string]$File

)

# Check to see if there is any argument or parameter when calling the script.
If(($symbol) -or ($File)){

$prefixurl = "http://download.finance.yahoo.com/d/quotes.csv?s=" # yahoo finance url prefix
$subfixurl = "&f=l1" # subfix url

If($File){
        If(($File) -and ((Get-Content $File) -eq $Null)){"Your stock tickers text file '$File' is blank."}
        else{

        foreach ($symbol in Get-Content $File | sort-object) {
        $symbol.ToUpper() + " " + (Invoke-RestMethod -Uri "$prefixurl + $symbol + $subfixurl" -Method Get)
            }
                }
    }
Else {
    $symbol.ToUpper() + " " + (Invoke-RestMethod -Uri "$prefixurl + $symbol + $subfixurl" -Method Get)}

}

# If there is no argument or parameter (a stock quote symbol or -File) enter, prompt the screen with this message

Else {Write-Host "Please specify a US stock quote symbol or -File Textfilename.txt for list of stock tickers `n(e.g.'Get-Stocks.ps1 ibm' or 'Get-Stocks.ps1 -File stocklist.txt')"}