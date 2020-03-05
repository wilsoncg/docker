function Get-ScriptDirectory {
	Split-Path -Parent $script:MyInvocation.MyCommand.Definition
}

function MachinesToCreate {
    $toCreate = @(
    "ubuntu-mpass1",
    "ubuntu-mpass2",
    "ubuntu-mpass3")

    $exists = 
        get-vm |
        ? name -like "*mpass*" |
        select-object -ExpandProperty name

    if ($exists.Count -eq 0) {
        return $toCreate
    }

    return $toCreate | ? { $exists -notcontains $_ }
}

MachinesToCreate | % { 
    $yaml = join-path $(Get-ScriptDirectory) cloud-config.yaml
    multipass launch --name $_ --cloud-init $yaml 
}