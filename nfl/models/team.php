<?php
  //require_once('division.php');
  require_once(__DIR__.'/../config/config.php');
  require_once('connection.php');
  require_once('exceptions/recordNotFoundException.php');
class Team
{
  public $id;
  public $name;
  //public $division;
  public $logo;

  public function setId($value){
    return $this->id = $value;
  }
  public function getId(){
    return $this->id;
  }
  public function setName($value){
    return $this->name = $value;
  }
  public function getName(){
    return $this->name;
  }
  /*public function setDivision($value){
    return $this->division = $value;
  }
  public function getDivision(){
    return $this->division;
  }*/
  public function setLogo($value){
    return $this->logo = $value;
  }
  public function getLogo(){
    return $this->logo;
  }

  public function __construct() {
      if (func_num_args() == 0) {
        $this->id = '';
        $this->name = '';
        $this->logo = '';
      }

      if (func_num_args() == 1){

      }

      if (func_num_args() == 3){
        $this->id = func_get_args(0);
        $this->name = func_get_args(1);
        $this->logo = func_get_args(2);
      }
  }

  public function toJson(){
    return json_encode(array(
      'id' => $this->id,
      'name' => $this->name,
      'logo' => Config::getFileURL('teams').$this->logo
    ));
  }
}

 ?>
