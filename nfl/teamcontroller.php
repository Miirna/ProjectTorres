<?php
  require_once('models/team.php');

  if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if($parameters == ''){
      echo json_encode(array(
        'status' => 0,
        'teams' => json_decode(Team::getAllToJson())   
      ));   
    } else 
        //get one
        try {
          //get object 
          $t = new Team($parameters);
          //display as JSON
          echo json_encode(array(
            'status' => 0,
            'team' => json_decode($t->toJsonFull())
          ));
        }
        catch(RecordNotFoundException $ex){
          echo json_encode(array(
            'status' => 1,
            'errorMessage' => $ex->getMessage()
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
