#ディレクトリ、フルパス、拡張子、ファイル名、更新日時
###Author Tommy
$logname="hoge.log"
echo "" > $logname
$List=Get-ChildItem  -Recurse -Name
$time = "2018/10/10 10:10:30"
foreach($a in $List)
{
    $fullname=$(Get-ItemProperty $a).FullName
    $name=$(Get-ItemProperty $a).Name
    $dir_fullpath=$(Split-Path $fullname -Parent) #フルパスフォルダ名を取得

    $lastIndex=$dir_fullpath.LastIndexOf("\")
    $dir=$(Split-Path $dir_fullpath -Leaf) #ディレクトリ名を取得

    $extension=$(Get-ItemProperty $a).Extension
    $timestamp=$(Get-ItemProperty $a).LastWriteTime.ToString('yyyy/MM/dd HH:mm:ss')
    
    ###ChangeUpdateTimes###
    Set-ItemProperty $dir_fullpath"\"$name -Name LastWriteTime -Value $time
    ###ChangeUpdateTimes###

    ###ChangeMakeTime###
    Get-ChildItem -Path  $dir_fullpath"\"$name | Where-Object { $_ -is [System.IO.FileInfo] } | ForEach-Object { Set-ItemProperty $_.FullName -Name CreationTime -Value $time }
    ###ChangeMakeTime###
    
    echo "$dir`t$dir_fullpath`t$extension`t$name`t$timestamp" >>$logname
}