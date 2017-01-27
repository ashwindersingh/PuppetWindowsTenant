class role::liquid_role {

  include profile::windowsfeature_profile
  include profile::rabbitmq_profile
#  include profile::solr_profile
}
