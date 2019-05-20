<?php
    require_once('models/conference.php');

    if($_SERVER['REQUEST_METHOD'] == 'GET'){
        if($parameters == ''){
            echo json_encode(array(
                'status' => 0,
                'conferences' => json_decode(Conference::getAllToJson())
            ));
        } else
            try{
                $c = new Conference($parameters);
                echo json_encode(array(
                    'status' => 0,
                    'conference' => json_decode($c->toJsonFull())
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