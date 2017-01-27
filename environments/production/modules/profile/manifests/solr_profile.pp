class profile::solr_profile{

  $dest_path = 'D:\Softwares'

  notify {"Unzipping Solr":}
  exec { 'Unzipping  Solr':
    command   => "$(Add-Type -assembly 'system.io.compression.filesystem'; [io.compression.zipfile]::ExtractToDirectory('${dest_path}\\solr-6.2.1.zip','D:\Solr'))",
    unless    => '$(If((Test-Path "D:\Solr\solr-6.2.1") -eq $true) { exit 0 } Else { exit 1 })',
    provider  => powershell,
    logoutput => true
  }

  notify { 'Installing Solr': }
  exec { 'Installing Solr':
    command   => "$(cd '${dest_path}'; .\\nssm.exe install SolrServer D:\\Solr\\solr-6.2.1\\bin\\solr.cmd start -f -p 8983; .\\nssm.exe start SolrServer)",
    onlyif    => "$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { exit 1; } else { exit 0; })",
    provider  => powershell,
    logoutput => true,
  }

#  exec { 'Checking Solr is Start':
#    command   => "$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { '${issolr_installed} = true'; } else { '${issolr_installed} = false'; })",
#    provider  => powershell,
#    logoutput => true,
#  }

}
