<?php
  require_once(__DIR__.'/../config/config.php');
  require_once('connection.php');
  require_once('exception/recordNotFoundException.php');
    
  class Team {
    //attributes
    private $id;
    private $name;
    private $logo;

    //getters and setters
    public function getId() { return $this->id; }
    public function setId($id) { $this->id = $id; }
    public function getName() { return $this->name; }
    public function setName($name) { $this->name = $name; }
    public function getLogo() { return $this->logo; }
    public function setLogo($logo) { $this->logo = $logo; }

    //constructor
    public function __construct() {
      //empty object
      if (func_num_args() == 0) {
        $this->id = '';
        $this->name = '';
        $this->logo = '';
      }
      //get data from database
      if (func_num_args() == 1) {
        $connection = MySqlConnection::getConnection(); //get connection
        $query = 'select id, name, logo from teams where id = ?'; //query
        $command = $connection->prepare($query); //prepare statement
        $command->bind_param('s', func_get_arg(0)); //parameters
        $command->execute(); //execute
        $command->bind_result($id, $name, $logo); //bind results
        //record was found
        if ($command->fetch()) {
          //pass values to the attributes
          $this->id = $id;
          $this->name = $name;
          $this->logo = $logo;
        }
        else
          throw new RecordNotFoundException(func_get_arg(0));
        //close command
        mysqli_stmt_close($command);
        //close connection
        $connection->close();
      }
      //get data from arguments
      if (func_num_args() == 3) {
        $this->id = func_get_arg(0);
        $this->name = func_get_arg(1);
        $this->logo = func_get_arg(2);
      }
    }

    //instance methods
    //represent the object in JSON format
    public function toJson() {
      return json_encode(array(
        'id' => $this->id,
        'name' => $this->name,
        'logo' => Config::getFileUrl('teams').$this->logo
      ));
    }

    //class methods

    //returns a list of teams
    public static function getAll() {
      $list = array(); //create list
      $connection = MySqlConnection::getConnection(); //get connection
      $query = 'select id, name, logo from teams order by id'; //query
      $command = $connection->prepare($query); //prepare statement
      $command->execute(); //execute
      $command->bind_result($id, $name, $logo); //bind results
      //fetch data
      while ($command->fetch()) {
        array_push($list, new Team($id, $name, $logo)); //add contact to list
      }
      mysqli_stmt_close($command); //close command
      $connection->close(); //close connection
      return $list; //return list
    }

    //returs a JSON array with all the teams
    public static function getAllToJson() {
      $jsonArray = array(); //create JSON array
      //read items
      foreach(self::getAll() as $item) {
          array_push($jsonArray, json_decode($item->toJson()));
      }
      return json_encode($jsonArray); //return JSON array
    }
  }
?>