class profile::download_profile {
  
  $dest_path              = 'D:\Softwares'
  $nssm_download_path     = 'http://artifactory.semanooor.com/artifactory/Softwares/nssm64/nssm.exe'
  $solr_download_path     = 'http://artifactory.semanooor.com/artifactory/Softwares/Solr/solr-6.2.1.zip'
  $erlang_download_path   = 'http://artifactory.semanooor.com/artifactory/Softwares/Erlang/otp_win64_19.2.exe'
  $rabbitmq_download_path = 'http://artifactory.semanooor.com/artifactory/Softwares/RabbitMq/rabbitmq-server-3.6.6.exe'

  if ! defined(File["${dest_path}"]){
    file { "${dest_path}":
      ensure => directory,
    }
  }

  notify { 'Started Downloading Erlang': }

  download_file { 'Download Erlang' :
    url                   => "${erlang_download_path}",
    destination_directory => "${dest_path}",
  }

  notify { 'Started Downloading RabbitMq': }

  download_file { 'Download RabbitMq' :
    url                   => "${rabbitmq_download_path}",
    destination_directory => "${dest_path}"
  }

  notify { 'Started Downloading Solr': }
  download_file { 'Download Solr Server 6.3.1' :
    url                   => $solr_download_path,
    destination_directory => $dest_path
  }

  notify { 'Started Downloading Nssm': }
  
  download_file { 'Download Nssm' :
    url                   => $nssm_download_path,
    destination_directory => $dest_path
  }

}
