class profile::solr_profile{

  $issolr_installed = false
  $dest_path        = 'D:\Softwares'

  notify { 'Checking If solr exist': }

  exec { 'Checking Solr is installed':
    command   => "$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { '${issolr_installed} = true'; } else { '${issolr_installed} = false'; })",
    provider  => powershell,
    logoutput => true,
  }

  if (!$isolr_installed) {

    if validate_absolute_path('D:\Solr\solr-6.2.1') {
      notify {"Unzipping Solr":}
      exec { 'Unzipping  Solr':
        command   => "$(Add-Type -assembly 'system.io.compression.filesystem'; [io.compression.zipfile]::ExtractToDirectory('${dest_path}\\solr-6.2.1.zip','D:\Solr'))",
        provider  => powershell,
        logoutput => true
      }

      notify { 'Installing Solr': }
      exec { 'Installing Solr':
        command   => "$('.\\${dest_path}\\nssm.exe install SolrServer D:\Solr\solr-6.2.1\bin\solr.cmd start -p -f 8983; nssm start SolrServer')",
        provider  => powershell,
        logoutput => true,
      }

      exec { 'Checking Solr is Start':
        command   => "$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { '${issolr_installed} = true'; } else { '${issolr_installed} = false'; })",
        provider  => powershell,
        logoutput => true,
      }
    }

  }
}
