class profile::solr_profile{

  $isSolr_installed = false

  exec { 'Checking Solr is installed':
    command  => '$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { '$isSolr_installed = true'; } else { '$isSolr_installed = false'; })',
    provider => powershell,
  }

  if '${isSolr_installed}' == false {

    windows_java::jdk {'8u51':
      ensure  => present,
      default => false,
    }

    download_file { "Download Solr Server 5.3" :
      url => 'http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe',
      destination_directory => 'c:\temp'
    }

    exec('Installing Solr Server 5.3') {
      command =>
    }
  
  }
}