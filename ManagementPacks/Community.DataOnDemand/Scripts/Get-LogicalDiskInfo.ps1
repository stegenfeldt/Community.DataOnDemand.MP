<#
.SYNOPSIS
    Community.DataOnDemand Disk Info script
.DESCRIPTION
    This script enumerates the logical disks and outputs formatted text
.PARAMETER Format
    Permitted values: text, csv, json
.NOTES
    Copyright 2016 Squared Up Limited, All Rights Reserved.
    Script Developed by github.com/stegenfeldt
#>
Param(
    [ValidateSet("text","csv","json", "list")]
    [string] $Format = "csv"
)

#Requires -Version 2.0
Set-StrictMode -Version 2.0
$ErrorActionPreference = "stop"

function Get-DiskInfo ([string] $Volume)
{
	$disks = Get-Disk
}


switch ($Format)
{
    "text" {
		$OutputObjects `
			| Select-Object Entry, Name, @{N='RecordType';E={Get-DNSRecordType $_.Type}}, Data `
			| Format-Table -AutoSize `
			| Out-String -Width 4096 `
			| Write-Host
	}
    "csv" {
		$OutputObjects `
			| convertto-csv -NoTypeInformation `
			| Out-String -Width 4096 `
			| Write-Host
	}
    "json" {
		$OutputObjects `
			| convertto-json `
			| Out-String -Width 4096 `
			| Write-Host
	}
    "list" {
		$OutputObjects `
			| Select-Object Entry, Name, @{N='RecordType';E={Get-DNSRecordType $_.Type}}, Data `
			| Format-List `
			| Out-String -Width 4096 `
			| Write-Host
	}
	default {"$OutputOjects"}
}