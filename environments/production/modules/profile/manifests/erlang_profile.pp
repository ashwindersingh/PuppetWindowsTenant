class profile::erlang_profile {

  if $::operatingsystem == 'windows'{

    $get_programs = 'Get-WmiObject Win32_Product | Where {$_.Name -match Microsoft Visual C }'
    $rabbitmq_path = 'C:\Program Files\RabbitMQ Server\rabbitmq_server-3.6.6\sbin'

    notify { 'Creating user': }

#    exec { 'create user':
#      command   => "$(cd '${rabbitmq_path}'; .\\rabbitmqctl.bat add_user liquid liquid@2016; .\\rabbitmqctl.bat set_user_tags liquid administrator; .\\rabbitmqctl.bat set_permissions -p / liquid '^liquid-.*' '.*' '.*')",
#      provider  => powershell,
#      logoutput => true,
#    }
  }
}
