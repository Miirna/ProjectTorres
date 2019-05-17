<?php
  //headers
  header('Access-Control-Allow-Origin: *');
  //controller list
  $controllerList = array('team', 'division', 'conference');
  //get request URI
  $requestUri = substr($_SERVER['REQUEST_URI'], strlen(dirname($_SERVER['PHP_SELF']))); 
  //split uri parts
  $uriParts = explode('/', $requestUri);
  //correct URI
  if (sizeof($uriParts) == 3 || sizeof($uriParts) == 4) {
    //get URI info
    $controller = $uriParts[1];
    //special action
    if (sizeof($uriParts) == 4) $action = $uriParts[2]; else $action = '';
    //get parameters
    $parameters = $uriParts[sizeof($uriParts) - 1]; 
    //send to controllers
    $found = false;
    foreach($controllerList as $item) {
      if ($controller == $item) {
        $found = true; //found controller
        require_once($controller.'controller.php');
      }
    }
    //invalid controller
    if (!$found) {
      echo json_encode(array(
        'status' => 998, 
        'errorMessage' => 'Invalid Controller'
      ));
    }
  }
  else
    echo json_encode(array(
      'status' => 999, 
      'errorMessage' => 'Invalid URI'
    ));
?>