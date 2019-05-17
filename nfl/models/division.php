<?php
  require_once('conference.php');
  require_once('connection.php');
  require_once('exception/recordNotFoundExeption.php');

  class Division {
    public $id;
    public $name;
    public $conference;

    public function getId(){
      return $this->id;
    }
    public function setName($value){
      return $this->name = $value;
    }
    public function getName(){
      return $this->name;
    }
    public function setConference($value){
      return $this->conference = $value;
    }
    public function getConference(){
      return $this->conference;
    }
    public function __construct() {
        if (func_num_args() == 0){
          $this->id = '';
          $this->name = '';
          $this->conference = new Conference();
        }

        if (func_num_args() == 1){
          $arguments = func_get_args();
          $connection = MySqlConnection::getConnection();
          $query = 'select id, name, idConference from divisions where id = ?';
          $command = $connection->prepare($query);
          $command->bind_param('s', $arguments[0]);
          $command->execute();
          $command->bind_result($id, $name, $conference);
          if($command->fetch()){
            $this->id = $id;
            $this->name = $name;
            $this->conference = $conference;
          }
          else 
            throw new RecordNotFoundException(func_get_arg(0));
          mysqli_stmt_close($command);
          $connection->close();
        }

        if (func_num_args() == 3){
          $this->id = func_get_args(0);
          $this->name = func_get_args(1);
          $this->conference = func_get_args(2);
        }
      }

      //class methods
      public function toJson() {
        return json_encode(array(
          'id' => $this->id,
          'name'=> $this->name,
          'conference'=> $this->conference
        ));
      }

      public static function getAll(){
        $list = array();
        $connection = MySqlConnection::getConnection();
        $query = 'select id, name, idConference from divisions order by id';
        $command = $connection->prepare()($query);
        $command->execute();
        $command->bind_result($id, $name, $conference);
        while($command->fetch()){
          array_push($list, new Division($id, $name, $conference));
        }
        mysqli_stmt_close($command);
        $connection->close();
        return $list;
      }

      public static function getAllToJson() {
        $jsonArray = array();
        foreach(self::getAll as $item){
          array_push($jsonArray, json_decode($item->toJson()));
        }
        return json_encode($jsonArray);
      }
  }

 ?>
