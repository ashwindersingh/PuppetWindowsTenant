class profile::rabbitmq_profile {

  $isRabbit_installed = false
  $service_name  = 'RabbitMQ'
  $rabbitmq_path = 'C:\Program Files\RabbitMQ Server\rabbitmq_server-3.6.6\sbin'

  notify { 'Starting Rabbi MQ Setup': }

  if "${::operatingsystem}" == 'windows'{

    notify { 'Starting Erlang Installation': }

    exec { 'Installing Erlang':
      command   => '$(Start-Process C:\Users\ashwinder\Downloads\otp_win64_19.2.exe -ArgumentList /S -Verb RunAs -Wait)',
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

    notify { 'Cehcking and Installing Rabbit MQ': }

    exec { 'Installing RabbitMQ':
      command   => '$(Start-Process C:\Users\ashwinder\Downloads\rabbitmq-server-3.6.6.exe -ArgumentList /S -Verb RunAs -Wait)',
      onlyif    => "$(if(Get-Service RabbitMQ -ErrorAction SilentlyContinue) { '$isRabbit_installed = true'; exit 1 } else { '$isRabbit_installed = false'; exit 0 })",
      provider  => powershell,
      logoutput => true,
    }

    if '${isRabbit_installed}' == false{

      notify { 'Enabling Managemtn UI' : }

      exec { 'Enable Plugin':
        command   => "$(cd '${rabbitmq_path}'; .\\rabbitmq-plugins.bat enable rabbitmq_management)",
        provider  => powershell,
        logoutput => true,
      }

      notify { 'Creating user': }

      exec { 'create user':
        command   => "$(cd '${rabbitmq_path}'; .\\rabbitmqctl.bat add_user liquid arka.com@2015; .\\rabbitmqctl.bat set_user_tags liquid administrator; .\\rabbitmqctl.bat set_permissions -p / liquid '^liquid-.*' '.*' '.*')",
        provider  => powershell,
        logoutput => true,
      }
    }
  }

  notify { 'Ending  RabbitMq Setup': }
}
