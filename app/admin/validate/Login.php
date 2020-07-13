<?php

namespace app\admin\validate;

use think\Validate;

/**
 * Class Login
 * @package app\admin\validate
 */
class Login extends Validate
{
    /**
     * 验证规则
     * @var array
     */
    protected $rule = [
        'username' => 'require|max:20',
        'password' => 'require|max:30'
    ];

    /**
     * 验证消息
     * @var array
     */
    protected $message = [
        'username.max' => '用户名不得超过20个字符',
        'password.max' => '密码不得超过50个字符'
    ];
}