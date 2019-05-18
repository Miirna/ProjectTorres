<?php
    require_once('models/conference.php');

    if($_SERVER['REQUEST_METHOD'] == 'GET'){
        if($parameters == ''){
            echo Conference::getAllToJson();
        } else
            try{
                $c = new Conference($parameters);
                echo json_encode(array(
                    'status' => 0,
                    'conference' => json_decode($c->toJson())
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