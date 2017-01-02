class profile::windowsfeature_profile {

  $windowsfeatures = hiera_hash('configs::windowsfeatures',{})
  validate_hash($windowsfeatures)
  create_resources('windowsfeature', $windowsfeatures)
}
