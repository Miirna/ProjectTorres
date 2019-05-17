<?php
	class Config {
		//get file Url
		public static function getFileUrl($key) {
			$data = file_get_contents(__DIR__.'/../config/config.json');
			$config = json_decode($data, true);
			if (isset($config['files'])) {
				//get files settings
				$files = $config['files'];
				//file location
				if (isset($files[$key]))
					return 'http://'.$_SERVER['SERVER_NAME'].dirname($_SERVER['PHP_SELF']).$files[$key];
				else
					return '';
			}
		}
    }
?>
