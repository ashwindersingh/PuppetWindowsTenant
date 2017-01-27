class profile::rabbitmq_profile {

  $israbbit_installed     = 'false'
  $service_name           = 'RabbitMQ'
  $dest_path              = 'D:\Softwares'
  $rabbitmq_path          = 'C:\Program Files\RabbitMQ Server\rabbitmq_server-3.6.6\sbin'

  notify { 'Starting Rabbi MQ Setup': }

  if "${::operatingsystem}" == 'windows'{

    notify { 'Starting Erlang Installation': }

    exec { 'Installing Erlang':
      command   => '$(Start-Process D:\Softwares\otp_win64_19.2.exe -ArgumentList /S -Verb RunAs -Wait)',
      unless    => '$(If((Test-Path "C:\Program Files\erl8.2\bin\erl.exe") -eq $true) { exit 0 } Else { exit 1 })',
      provider  => powershell,
      logoutput => true,
    }

    notify { 'Adding Path to the System Env' : }

    exec { 'Add Erlang to System Path':
      command   => "$([Environment]::SetEnvironmentVariable('ERLANG_HOME', 'C:\Program Files\erl8.2', 'Machine'))",
      provider  => powershell,
      logoutput => true,
    }

    notify { 'Checking and Installing Rabbit MQ': }

    exec { 'Checking If RabbitMQ is installed':
      command    => '$(if(Get-Service RabbitMQ -ErrorAction SilentlyContinue) { $israbbit_installed = "true"; } else { $israbbit_installed = "false"; })',
      provider   => powershell,
      logoutput  => true,
    }

    exec { 'Installing RabbitMQ':
      command   => '$(Start-Process D:\Softwares\rabbitmq-server-3.6.6.exe -ArgumentList /S -Verb RunAs -Wait)',
      onlyif    => "$(if(Get-Service RabbitMQ -ErrorAction SilentlyContinue) { exit 1; } else { exit 0; })",
      provider  => powershell,
      logoutput => true,
    }

    if ("${israbbit_installed}" == 'false') {

      notify { 'Creating user and enabling mangement ui': }

      exec { 'create user':
        command   => "$(cd '${rabbitmq_path}'; .\\rabbitmq-plugins.bat enable rabbitmq_management; .\\rabbitmqctl.bat add_user liquid arka.com@2015; .\\rabbitmqctl.bat set_user_tags liquid administrator; .\\rabbitmqctl.bat set_permissions -p / liquid '^liquid-.*' '.*' '.*')",
        provider  => powershell,
      }
    }
  }

  notify { 'Ending  RabbitMq Setup': }
}
