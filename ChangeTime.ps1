#�f�B���N�g���A�t���p�X�A�g���q�A�t�@�C�����A�X�V����
###Author Tommy
$logname="hoge.log"
echo "" > $logname
$List=Get-ChildItem  -Recurse -Name
$time = "2018/10/10 10:10:30"
foreach($a in $List)
{
    $fullname=$(Get-ItemProperty $a).FullName
    $name=$(Get-ItemProperty $a).Name
    $dir_fullpath=$(Split-Path $fullname -Parent) #�t���p�X�t�H���_�����擾

    $lastIndex=$dir_fullpath.LastIndexOf("\")
    $dir=$(Split-Path $dir_fullpath -Leaf) #�f�B���N�g�������擾

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