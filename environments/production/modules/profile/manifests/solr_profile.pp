class profile::solr_profile{

  $issolr_installed = false
  $dest_path        = 'C:\Users\ashwinder\Downloads'
  $download_path    = 'http://artifactory.semanooor.com/artifactory/Softwares/Solr/solr-6.2.1.zip'
  $nssm_path        = 'http://artifactory.semanooor.com/artifactory/Softwares/nssm64/nssm.exe'

  notify { 'Checking If solr exist': }

  exec { 'Checking Solr is installed':
    command   => "$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { '${issolr_installed} = true'; } else { '${issolr_installed} = false'; })",
    provider  => powershell,
    logoutput => true,
  }

  if (!$isolr_installed) {

    notify {'Downloading Solr Zip File' : }

    download_file { 'Download Solr Server 5.3' :
      url                   => $download_path,
      destination_directory => $dest_path
    }

    download_file { 'Download Nssm' :
      url                   => $nssm_path,
      destination_directory => $dest_path
    }

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

      if(isolr_installed) {
        exec { 'Create the Solr Core': 
          command   => "$()",
          provider  => powershell,
          logoutput => true        
        }
      }

    }

  }
}
