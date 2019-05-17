<?php
  require_once('conference.php');

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
    public function __construct {
        if (func_num_args() == 0){
          $this->id = '';
          $this->name = '';
          $this->conference = new Conference();
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
