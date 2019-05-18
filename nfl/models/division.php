<?php
  require_once('conference.php');
  require_once('connection.php');
  require_once('team.php');
  require_once('exception/recordNotFoundException.php');

  class Division {
    public $id;
    public $name;
    public $conference;

    public function getId(){ return $this->id; }
    public function setId($value){ return $this->id = $value; }
    public function setName($value){ return $this->name = $value; }
    public function getName(){ return $this->name; }
    public function setConference($value){ return $this->conference = $value; }
    public function getConference(){ return $this->conference; }

    public function __construct() {
        if (func_num_args() == 0){
          $this->id = '';
          $this->name = '';
          $this->conference = '';
        }

        if (func_num_args() == 1){
          $arguments = func_get_args();
          $connection = MySqlConnection::getConnection();
          $query = 'select d.id, d.name, d.idConference, c.name, c.logo 
                    from divisions as d join conferences as c on d.idConference = c.id where d.id = ?';
          $command = $connection->prepare($query);
          $command->bind_param('s', $arguments[0]);
          $command->execute();
          $command->bind_result(
            $id, 
            $name,
            $conferenceId, 
            $conferenceName,
            $conferenceLogo
          );
          if($command->fetch()){
            $this->id = $id;
            $this->name = $name;
            $this->conference = new Conference($conferenceId, $conferenceName, $conferenceLogo);
          }
          else 
            throw new RecordNotFoundException($arguments[0]);
          mysqli_stmt_close($command);
          $connection->close();
        }

        if (func_num_args() == 3){
          $this->id = func_get_arg(0);
          $this->name = func_get_arg(1);
          $this->conference = func_get_arg(2);
        }
      }

      //class methods
      public function toJson() {
        return json_encode(array(
          'id' => $this->id,
          'name'=> $this->name
        ));
      }
      
      
      public function toJsonFull() {
        $jsonArray = array();
        foreach(self::getTeams() as $item){
          array_push($jsonArray, json_decode($item->toJson()));
        }
        return json_encode(array(
          'id' => $this->id,
          'name'=> $this->name,
          'conference'=> json_decode($this->conference->toJson()),
          'teams' => $jsonArray
        ));
      }

      public static function getAll(){
        $list = array();
        $connection = MySqlConnection::getConnection();
        $query = 'select id, name, idConference from divisions order by id';
        $command = $connection->prepare($query);
        $command->execute();
        $command->bind_result($id, $name, $conference);
        while($command->fetch()){
          array_push($list, new Division($id, $name, $conference));
        }
        mysqli_stmt_close($command);
        $connection->close();
        return $list;
      }

      public function getTeams(){
        $list = array();
        $connection = MySqlConnection::getConnection();
        $query = 'select id, name, logo 
                  from teams where idDivision = ? order by id';
        $command = $connection->prepare($query);
        $command->bind_param('s', $this->id);
        $command->execute();
        $command->bind_result($id, $name, $logo);
        while($command->fetch()){
          array_push($list, new Team($id, $name, $logo));
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
