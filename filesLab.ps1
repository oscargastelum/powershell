#
#########################################################################
#
# Program : Module 12 Lab - Powershell Part 1 
#  
# Created : 05/04/2022
#   
# Programmer : Oscar Gastelum 
#  
# 
# ########################################################################  
#  Program description/ purpose : Will: 
# - Search for users home directory 
# - Search for "powershell" directory
# - Locate "files" directory
# - Creaet "pdf" and "jpg" directories insdied of "Powershell" directory
#   if not already present.
# - Search "files" directory, extract all "pdf" and "jpg" files and 
#   move to corresponding folders. 
#
#--------------------------- Change History ------------------------------
# Programmer : 
# Date :
# Description of change : 
#  
#########################################################################/ 



#path to "powershell" directory. Assumes the directory is in the user home directory
$workingDir = "~\powershell"
$filesDir = Join-Path -Path $workingDir -ChildPath "files"
$pdfDir = Join-Path -Path $workingDir -ChildPath "pdf"
$jpgDir = Join-Path -Path $workingDir -ChildPath "jpg"


Write-Output "`nSearching for directory : $workingDir..."
#check for folder "files" at specified directory.
if(!(Test-Path -Path ($filesDir))){
    Write-Output "Directory: $filesDir Not found. Check Directory path and try again."

}else{
    Write-Output "`nDirectory Found successfully."
    Write-Output "`nSearching for .pdf and .jpg files within Directory..."

    #check for "pdf" and "jpg" directories. Create if non existent.
    if(!(Test-Path -Path ($pdfDir))){
        New-Item ($pdfDir) -ItemType "directory"
        Write-Output "`n*pdf directory created.*`n"
    }

    if(!(Test-Path -Path ($jpgDir))){
        New-Item ($jpgDir) -ItemType "directory"
        Write-Output "`n*jpg directory created.*"
    }

}


#if a file, with the specified extension is found, move to specified folder
if((Get-ChildItem -Path ($filesDir) -Recurse -Include *.pdf)){
    #move pdf files 
    Get-ChildItem -Path ($filesDir) -Recurse -Include *.pdf |  Select-Object -ExpandProperty FullName | Move-Item -Destination ($pdfDir)
    Write-Output "`nSuccessfully moved .pdf files to : $pdfDir"
}else{
    Write-Output "`nNo .pdf Files Found."
}

if((Get-ChildItem -Path ($filesDir) -Recurse -Include *.jpg)){
    #move pdf files 
    Get-ChildItem -Path ($filesDir) -Recurse -Include *.jpg |  Select-Object -ExpandProperty FullName | Move-Item -Destination ($jpgDir)
    Write-Output "Successfully moved .jpg files to : $jpgDir"

}else{
    Write-Output "`nNo .jpg Files Found."
}

Write-Output "`n--- Script Terminated Successfully ---" 