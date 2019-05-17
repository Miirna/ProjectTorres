<?php

  class Conference {
    public $id;
    public $name;
    public $logo;

    public function getId(){
      return $this->id;
    }
    public function setName($value){
      return $this->name = $value;
    }
    public function getName(){
      return $this->name;
    }
    public function setLogo($value){
      return $this->logo = $value;
    }
    public function getLogo(){
      return $this->logo;
    }

    public function __construct {
        if (func_num_args() == 0){
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
  }

 ?>
