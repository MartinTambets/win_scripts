# location of AD users file
$file = "C:\Users\Administrator\Documents\adusers.csv"
# import file content
$users = Import-Csv $file -Encoding Default -Delimiter ";"
# foreach user data row in file
foreach ($user in $users){
# username is firstname.lastname
$username = $user.Firstname + "." + $user.Lastname
$username = $username.ToLower()
$username = Translit($username)
# user principal name
$upname = $username + "@sv-kool.local"
# display name - eesnimi + perenimi
$displayname = $user.FirstName + " " + $user.LastName
New-ADUser -Name $username `
-DisplayName $displayname `
-GivenName $user.FirstName `
-Surname $user.LastName `
-Department $user.Department `
-Title $user.Role `
-UserPrincipalName $upname `
-AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true
}
# function translit UTF-8 characters to LATIN
function Translit {
# function use as parameter string to translit
param(
[string] $inputString
)
# define the characters which have to be translited
$Translit = @{
[char] 'ä' = "a"
[char] 'ö' = "o"
[char] 'ü' = "u"
[char] 'õ' = "o"
}
# create tanslited output
$outputString=""
#transfer string to arry of characters and by chatacter
foreach ($character in $inputCharacter = $inputString.ToCharArray())
{
# if character is exsists in list of characters for transliting
if ($translit[$character] -cne $null ){
# add to output translited characher
$outputstring += $translit[$character]
} else {
# otherwise add the inital character
$outputstring += $character
}
}
Write-Output $outputstring
}