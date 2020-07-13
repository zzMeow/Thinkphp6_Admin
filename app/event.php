<?php
// 事件定义文件
return [
    'bind'      => [
        'AdminLoginAfter' => 'app\events\AdminLoginAfter',
    ],

    'listen'    => [
        'AdminLoginAfter'    =>    ['app\listeners\AdminLoginAfter'],

        'AppInit'  => [],
        'HttpRun'  => [],
        'HttpEnd'  => [],
        'LogLevel' => [],
        'LogWrite' => [],
    ],

    'subscribe' => [
    ],
];
