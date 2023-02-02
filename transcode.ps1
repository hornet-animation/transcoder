$ascii = @"
"                      =*#%#=                          :##- .##                          +######.
                     =%*  +%*                         :%%%*:%%                            -%*
                     +%+  =%#                         :%#-##%%                            -%*
                     .#%**%#:                         :%# .*%%                            -%*
    .**  :**           .::.           +***+=:          :.   ::         .******.            :.
    :%%:.-%%     ................     #%=.-%%     ................     .%%--:.      ................
    :%%**#%%    :################:    #%####=     *###############+    .%%**-      =################
    :%%  :%%                          #%-.##:                          .%%====.
     --  .--                          :-. .--                           ------

%%%%%%%%%%%%%%%%+                =%%%%%%%%%%%%%%%%                :%%%%%%%%%%%%%%%%-
"
"@


$subtitle = "                                        T R A N S C O D E                                       "

write-host $ascii -ForegroundColor Blue
write-host $subtitle -ForegroundColor Yellow
$exts = @('png', 'jpg', 'exr', 'dpx','tiff','tga')
$commonext = ($(Get-ChildItem | Where-Object { $_.PsIsContainer -eq $false } |
ForEach-Object { $_.Extension } |
Group-Object | Sort-Object Count -Descending | Select-Object -First 1).Name)

write-host "Identifying sequence..."
write-host "discovered a " -NoNewline
write-host $commonext -ForegroundColor Yellow -NoNewline
write-host " Sequence"
write-host ""
write-host "of shot/subset "
$fname = Get-ChildItem -Path "." -Filter "*$commonext" | Select-Object -First 1
write-host $fname -ForegroundColor Yellow
$newFname = $fname -replace ('(\.[0-9]+)' + $commonext), ('.%d' + $commonext)
write-host $newFname
$ffexe ="T:\dev\_builds\Deadline\amd64-12-9-22\vendor\bin\ffmpeg\windows\bin\ffmpeg.exe"
$default = 24
if (!($fps = Read-Host "input fps [$default]")) { $fps = $default }
$basename = $fname -replace $commonext -replace '\.[0-9]+$'
$command = "$ffexe -framerate {0} -start_number 1001 -i {1} -c:v libx264 -pix_fmt yuv420p {2}.mp4" -f $fps,$newFname,$basename
write-host $command
iex $command
