<?php
class RecordNotFoundException extends Exception {
    //attributes
    protected $message;

    //constructor
    public function __construct() {
        //0 arguments : generic messages
        if(func_num_args() == 0) 
            $this->messges = 'Record not found';
        //1 argument : detail message
        if(func_num_args() == 1)
            $this->message = 'Record not found for id';
            func_get_arg(0);
    }
}
?>