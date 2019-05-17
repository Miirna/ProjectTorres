<?php
  require_once('models/team.php');

  if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if ($parameters == ''){
      echo "Get all teams";
    } else {
      echo "Get one team";
      $t = new Team();
      $t->setId($parameters);
      $t->setName('Los Angeles Chargers');
      $t->setLogo('chargers.png');
      echo json_encode(array(
        'status' => 0,
        'team' => json_decode($t->toJson())
      ));

    }
  }

  if ($_SERVER['REQUEST_METHOD'] == 'POST') {

  }

  if ($_SERVER['REQUEST_METHOD'] == 'PUT') {

  }

  if ($_SERVER['REQUEST_METHOD'] == 'DELETE') {

  }
 ?>
