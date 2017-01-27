class profile::download_profile {

  if ! defined(File["${dest_path}"]){
    file { "${dest_path}":
      ensure => directory,
    }
  }

}
