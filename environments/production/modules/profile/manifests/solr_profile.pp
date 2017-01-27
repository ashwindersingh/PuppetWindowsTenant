class profile::solr_profile{

  $dest_path = 'D:\Softwares'
  $solr_dir  = 'D:\\Solr\\solr-6.2.1'

  notify {"Unzipping Solr":}
  exec { 'Unzipping  Solr':
    command   => "$(Add-Type -assembly 'system.io.compression.filesystem'; [io.compression.zipfile]::ExtractToDirectory('${dest_path}\\solr-6.2.1.zip','D:\Solr'))",
    unless    => '$(If((Test-Path "${solr_dir}") -eq $true) { exit 0 } Else { exit 1 })',
    provider  => powershell,
    logoutput => true
  }

  notify { 'Installing Solr': }
  exec { 'Installing Solr':
    command   => "$(cd '${dest_path}'; .\\nssm.exe install SolrServer '${solr_dir}'\\bin\\solr.cmd start -f -p 8983; .\\nssm.exe start SolrServer)",
    onlyif    => "$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { exit 1; } else { exit 0; })",
    provider  => powershell,
    logoutput => true,
  }

  exec { 'Creating Solr Core':
    command   => "$(cd D:\\Solr\\solr-6.2.1\\bin; solr.cmd create -c Liquid;)",
    unless    => '$(If((Test-Path "${solr_dir}\\server\\solr\\Liquid) -eq $true) { exit 0 } Else { exit 1 })',
    provider  => powershell,
    logoutput => true,
  }

}
Solr\server\solr