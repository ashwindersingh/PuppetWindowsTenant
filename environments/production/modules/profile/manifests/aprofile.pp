class profile::aprofile {

  $erlang_download_path   = 'http://artifactory.semanooor.com/artifactory/Softwares/Erlang/otp_win64_19.2.exe'
  $rabbitmq_download_path = 'http://artifactory.semanooor.com/artifactory/Softwares/RabbitMq/rabbitmq-server-3.6.6.exe'
  $rabbitmq_path          = 'C:\Program Files\RabbitMQ Server\rabbitmq_server-3.6.6\sbin'
  $dest_path              = 'D:\Softwares'

  if ! defined(File["${dest_path}"]){
    file { "${dest_path}":
      ensure => directory,
    }
  }

  download_file { 'Download Erlang' :
    url                   => $erlang_download_path,
    destination_directory => $dest_path
  }
}
