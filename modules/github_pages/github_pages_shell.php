<?php
  
$options = getopt("", array("root:"));

if($options['root']) {
  if(is_dir($options['root'])){
    define('BACKDROP_ROOT', $options['root']);
    require_once BACKDROP_ROOT . '/core/includes/bootstrap.inc';
    backdrop_bootstrap(BACKDROP_BOOTSTRAP_FULL);
    github_pages_path_alias_update(TRUE);
    github_pages_path_alias_clean(TRUE);
  }
}
