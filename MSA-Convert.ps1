Function MSA-Convert{

    [cmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [String]
        $Base64
    )
    Import-Module DSInternals
    $B64Decode = [System.Convert]::FromBase64String($Base64)
    $hex = ((ConvertFrom-ADManagedPasswordBlob $B64Decode).CurrentPassword | Format-Hex -Encoding Unicode | Select-Object -Expand Bytes | ForEach-Object { '{0:x2}' -f $_ }) -join ''
    $ntlm = (ConvertFrom-ADManagedPasswordBlob $B64Decode).SecureCurrentPassword | ConvertTo-NTHash
    Write-Host "`n","##HEX##","`n","0x$hex","`n`n","##NTLM##","`n","$ntlm"
}