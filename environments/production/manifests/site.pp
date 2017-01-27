File { backup => false }

node default {

  if "${::operatingsystem}" == 'windows'{

    include stdlib

    notify { 'Starting Liquid Development  SetUP' : }

    include role::liquid_role

    notify { 'Finishing Liquid Development  SetUP' : }
  }
}
