File { backup => false }

node default {

  if "${::operatingsystem}" == 'windows'{

    include stdlib

    notify { 'Starting Windows Feature Installation': }
    include role::winserver
    notify { 'Finishing Windows Feature Installation': }

    notify { 'Starting Liquid Development  SetUP' : }
    include role::liquid_role
    notify { 'Finishing Liquid Development  SetUP' : }
  }
}
