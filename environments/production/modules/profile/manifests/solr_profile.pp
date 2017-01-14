class profile::solr_profile{

  $issolr_installed = false
  $dest_path = 'C:\Users\ashwinder\Downloads'
  $download_path = 'https://archive.apache.org/dist/lucene/solr/5.3.1/solr-5.3.1.zip'


  notify { 'Checking If solr exist': }

  exec { 'Checking Solr is installed':
    command   => "$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { '${issolr_installed} = true'; } else { '${issolr_installed} = false'; })",
    provider  => powershell,
    logoutput => true,
  }

  notify {'$issolr_installed': }

  if (!$isolr_installed) {

    notify {'Downloading Solr Zip File' : }

    download_file { 'Download Solr Server 5.3' :
      url                   => $download_path,
      destination_directory => $dest_path
    }

#    exec { 'Installing Solr':
#      command =>
#    }
  }
}
