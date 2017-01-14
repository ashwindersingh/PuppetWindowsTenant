class profile::windowsfeature_profile {

  $iis_features = ['Web-Server','Web-WebServer','Web-Asp-Net45','Web-ISAPI-Ext','Web-ISAPI-Filter','NET-Framework-45-ASPNET','WAS-NET-Environment','Web-Http-Redirect','Web-Filtering','Web-Mgmt-Console','Web-Mgmt-Tools']

  windowsfeature { $iis_features:
    ensure => present,
  }

  windows_java::jdk {'8u45':
    ensure  => present,
    default => true,
  }
}
