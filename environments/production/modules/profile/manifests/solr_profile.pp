class profile::solr_profile{

  $isSolr_installed = false
  $download_path = 'C:\Users\ashwinder\Downloads'

  notify { 'Checking If solr exist': }

  exec { 'Checking Solr is installed':
    command   => "$(if(Get-Service SolrServer -ErrorAction SilentlyContinue) { '$isSolr_installed = true'; } else { '$isSolr_installed = false'; })",
    provider  => powershell,
    logoutput => true,
  }

  notify { "$isSolr_installed": }

  if ($isSolr_installed != $true) {

    notify {'Downloading Solr Zip File' : }

    download_file { "Download Solr Server 5.3" :
      url                   => 'https://archive.apache.org/dist/lucene/solr/5.3.1/solr-5.3.1.zip',
      destination_directory => "$download_path"
    }

  }
}
