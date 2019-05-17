<?php
    require_once('models/division.php');

    if($_SERVER['REQUEST_METHOD'] == 'GET') {
        if($parameters == ''){
            echo Division::getAllToJson();
        } else
            try {
                $d = new Division($parameters);
                echo json_encode(array(
                    'status'=> 0,
                    'division'=> json_decode($d->toJson())
                ));
            }
            catch(RecordNotFoundException $ex){
                echo json_encode(array(
                    'status'=> 1,
                    'errorMessage'=> $ex->getMessage()
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