<?php
  require_once(__DIR__.'/../config/config.php');
  require_once('connection.php');
  require_once('exception/recordNotFoundException.php');
  require_once('team.php');
  require_once('division.php');
  class Conference 
  {
    public $id;
    public $name;
    public $logo;

    public function getId(){ return $this->id; }
    public function setName($value){ return $this->name = $value; }
    public function getName(){ return $this->name; }
    public function setLogo($value){ return $this->logo = $value; }
    public function getLogo(){ return $this->logo; }

    public function __construct() {
        if (func_num_args() == 0){
          $this->id = '';
          $this->name = '';
          $this->logo = '';
        }

        if (func_num_args() == 1){
          $arguments = func_get_args();
          $connection = MySqlConnection::getConnection();
          $query = 'select id, name, logo from conferences where id = ?';
          $command = $connection->prepare($query);
          $command->bind_param('s', $arguments[0]);
          $command->execute();
          $command->bind_result(
            $id, 
            $name, 
            $logo
          );
          if($command->fetch()){
            $this->id = $id;
            $this->name = $name;
            $this->logo = $logo;
          }
          else
            throw new RecordNotFoundException($arguments[0]);
          mysqli_stmt_close($command);
          $connection->close();
        }

        if (func_num_args() == 3){
          $this->id = func_get_arg(0);
          $this->name = func_get_arg(1);
          $this->logo = func_get_arg(2);
        }
    }

    public function toJson(){
      return json_encode(array(
        'id' => $this->id,
        'name' => $this->name,
        'logo' => Config::getFileUrl('conferences').$this->logo
      ));
    }

    public function toJsonFull(){
      $jsonArray = array();
      foreach(self::getDivisions() as $item){
        array_push($jsonArray, json_decode($item->toJson()));
      }
      return json_encode(array(
        'id' => $this->id,
        'name' => $this->name,
        'logo' => $this->logo,
        'divisons' => $jsonArray
      ));
    }

    public static function getAll(){
      $list = array();
      $connection = MySqlConnection::getConnection();
      $query = 'select id, name, logo from conferences order by id';
      $command = $connection->prepare($query);
      $command->execute();
      $command->bind_result($id, $name, $logo);
      while($command->fetch()){
        array_push($list, new Conference($id, $name, $logo));
      }
      mysqli_stmt_close($command);
      $connection->close();
      return $list;
    }

    public function getDivisions(){
      $list = array();
      $connection = MySqlConnection::getConnection();
      $query = 'select id, name from divisions where idConference = ?';
      $command = $connection->prepare($query);
      $command->bind_param('s', $this->id);
      $command->execute();
      $command->bind_result($id, $name);
      while($command->fetch()){
        array_push($list, new Division($id, $name));
      }
      mysqli_stmt_close($command);
      $connection->close();
      return $list;
    }

    public static function getAllToJson() {
      $jsonArray = array();
      foreach(self::getAll() as $item){
        array_push($jsonArray, json_decode($item->toJson()));
      }
      return json_encode($jsonArray);
    }
  }

 ?>
