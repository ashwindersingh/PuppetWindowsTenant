File { backup => false }

node default {

  if "${::operatingsystem}" == 'windows'{

    notify { 'Starting Windows Feature Installation': }
    include role::winserver
    notify { 'Finishing Windows Feature Installation': }

    notify { 'Starting RabbitMQ SetUP' : }
    include role::rabbitmq_role
    notify { 'Finishing RabbitMQ SetUP' : }
  }
}
